import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/widgets/scan_camera.dart';

/// Scanning (board `S6-28`): the camera, always dark so it reads the same
/// in both themes; a frame, one hint, the light, and the way out to typing
/// the key. Owns the [ScanCamera]: started once on screen, stopped while the
/// app is away. Toasts rise over the hint while it is up.
class ScanningView extends StatefulWidget {
  const ScanningView({
    required this.camera,
    required this.onClose,
    required this.onEnterKey,
    super.key,
  });

  final ScanCamera Function() camera;
  final VoidCallback onClose;
  final VoidCallback onEnterKey;

  @override
  State<ScanningView> createState() => _ScanningViewState();
}

class _ScanningViewState extends State<ScanningView>
    with WidgetsBindingObserver {
  late final ScanCamera _camera = widget.camera();
  late final StreamSubscription<String> _reads;
  late final StreamSubscription<ScanCameraProblem> _problems;
  AppToastHostState? _toasts;

  @override
  void initState() {
    super.initState();
    final ScanCubit cubit = context.read<ScanCubit>();
    _reads = _camera.reads.listen(cubit.read);
    _problems = _camera.problems.listen(
      (ScanCameraProblem problem) => switch (problem) {
        ScanCameraProblem.refused => cubit.cameraRefused(),
        ScanCameraProblem.failed => cubit.cameraFailed(),
      },
    );
    WidgetsBinding.instance.addObserver(this);
    // After the frame: the preview must be on screen before it starts, and
    // the toast host must not change while building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(_camera.start());
      final AppToastHostState? toasts = AppToastHost.maybeOf(context);
      // Over the hint: from the bottom, its 24 pt margin above the safe
      // area, the 48 pt button and the 16 pt gap.
      toasts?.raisedTo.value = MediaQuery.paddingOf(context).bottom + 88.h;
      _toasts = toasts;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        unawaited(_camera.start());
      case AppLifecycleState.inactive:
        unawaited(_camera.stop());
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final AppToastHostState? toasts = _toasts;
    if (toasts != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (toasts.mounted) toasts.raisedTo.value = null;
      });
    }
    unawaited(_reads.cancel());
    unawaited(_problems.cancel());
    unawaited(_camera.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles styles = AppTextStyles(context);
    final bool found = context.select<ScanCubit, bool>(
      (ScanCubit c) => c.state.found != null,
    );
    final double safeBottom = MediaQuery.paddingOf(context).bottom;
    final Duration duration = AppMotion.reduceMotion(context)
        ? Duration.zero
        : AppMotion.base;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Light status bar icons over the dark camera, in both themes.
      value: SystemUiOverlayStyle.light,
      child: Material(
        type: MaterialType.transparency,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: AppFixedColors.cameraBackdrop,
          ),
          child: BackdropGroup(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Semantics(
                    image: true,
                    label: t.scan.cameraView,
                    child: ExcludeSemantics(child: _camera.view(context)),
                  ),
                ),
                // "Code Found" over a dimmed camera.
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      opacity: found ? 1 : 0,
                      duration: duration,
                      child: const ColoredBox(color: AppFixedColors.cameraDim),
                    ),
                  ),
                ),
                // The board draws "Code Found" over the camera alone: the
                // bar, the frame and the hint step away.
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: found,
                    child: AnimatedOpacity(
                      opacity: found ? 0 : 1,
                      duration: duration,
                      child: Stack(
                        children: <Widget>[
                          const _QrFrame(),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: SafeArea(
                              bottom: false,
                              child: SizedBox(
                                height: 52.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      _GlassButton(
                                        icon: AppIconName.x,
                                        stroke: 2.25,
                                        label: t.common.close,
                                        onTap: widget.onClose,
                                      ),
                                      Expanded(
                                        child: Semantics(
                                          header: true,
                                          child: Text(
                                            t.scan.title,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: styles.navTitle().copyWith(
                                              color: AppFixedColors.onCamera,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ValueListenableBuilder<bool?>(
                                        valueListenable: _camera.light,
                                        builder: (_, bool? on, _) => on == null
                                            // No light on this camera: the title
                                            // stays centred.
                                            ? SizedBox(width: 44.r)
                                            : _GlassButton(
                                                icon: AppIconName.flashlight,
                                                stroke: 2,
                                                label: t.scan.torch,
                                                toggled: on,
                                                onTap: () => unawaited(
                                                  _camera.toggleLight(),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                24.w,
                                0,
                                24.w,
                                safeBottom + 24.h,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 16.h,
                                children: <Widget>[
                                  Text(
                                    t.scan.hint,
                                    textAlign: TextAlign.center,
                                    style: styles.bodyStrong().copyWith(
                                      color: AppFixedColors.onCamera,
                                    ),
                                  ),
                                  _GlassPill(
                                    icon: AppIconName.keyboard,
                                    label: t.editItem.enterSetupKey,
                                    onTap: widget.onEnterKey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The frame (`.qrf`): four white corners, 236 pt square, its centre 44 %
/// down the screen, with the line across it (`.scan`).
class _QrFrame extends StatelessWidget {
  const _QrFrame();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double side = 236.r;
      return Stack(
        children: <Widget>[
          Positioned(
            left: (constraints.maxWidth - side) / 2,
            top: constraints.maxHeight * 0.44 - side / 2,
            width: side,
            height: side,
            child: ExcludeSemantics(
              child: CustomPaint(
                painter: _CornersPainter(
                  corner: 44.r,
                  radius: 22.r,
                  width: 4.r,
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 18.r,
                      right: 18.r,
                      top: side * 0.46,
                      height: 2.r,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppFixedColors.scanLine,
                          borderRadius: BorderRadius.circular(2.r),
                          boxShadow: const <BoxShadow>[
                            AppFixedColors.scanLineGlow,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

/// `.qrf b`: a [corner]-long border on two sides of each corner, rounded at
/// [radius] (outer edge), [width] thick.
class _CornersPainter extends CustomPainter {
  const _CornersPainter({
    required this.corner,
    required this.radius,
    required this.width,
  });

  final double corner;
  final double radius;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppFixedColors.onCamera
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    // The stroke runs along the border's middle: half its width in, with
    // the radius shrunk by as much.
    final double inset = width / 2;
    final double r = radius - inset;
    for (int quarter = 0; quarter < 4; quarter++) {
      canvas
        ..save()
        ..translate(size.width / 2, size.height / 2)
        ..rotate(quarter * 3.141592653589793 / 2)
        ..translate(-size.width / 2, -size.height / 2);
      final Path path = Path()
        ..moveTo(inset, corner)
        ..lineTo(inset, inset + r)
        ..arcToPoint(Offset(inset + r, inset), radius: Radius.circular(r))
        ..lineTo(corner, inset);
      canvas
        ..drawPath(path, paint)
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_CornersPainter old) =>
      old.corner != corner || old.radius != radius || old.width != width;
}

/// `.glass`: a 44 pt round button, 16 % white over the blurred camera.
class _GlassButton extends StatelessWidget {
  const _GlassButton({
    required this.icon,
    required this.stroke,
    required this.label,
    required this.onTap,
    this.toggled,
  });

  final AppIconName icon;
  final double stroke;
  final String label;
  final VoidCallback onTap;
  final bool? toggled;

  @override
  Widget build(BuildContext context) => AppPressable(
    onTap: onTap,
    semanticLabel: label,
    toggled: toggled,
    shape: const CircleBorder(),
    child: _Glass(
      child: SizedBox.square(
        dimension: 44.r,
        child: Center(
          child: AppIcon(
            icon,
            size: 20,
            stroke: stroke,
            color: AppFixedColors.onCamera,
          ),
        ),
      ),
    ),
  );
}

/// `.gbtn`: "Enter setup key", a 48 pt glass pill.
class _GlassPill extends StatelessWidget {
  const _GlassPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final AppIconName icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => AppPressable(
    onTap: onTap,
    semanticLabel: label,
    shape: const StadiumBorder(),
    child: _Glass(
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.w,
          children: <Widget>[
            AppIcon(icon, size: 18, stroke: 2, color: AppFixedColors.onCamera),
            Text(
              label,
              style: AppTextStyles(
                context,
              ).button().copyWith(color: AppFixedColors.onCamera),
            ),
          ],
        ),
      ),
    ),
  );
}

/// 16 % white over a 20 pt blur of the camera (`backdrop-filter`), clipped
/// round (both glass shapes are fully rounded); the screen's three share
/// one backdrop.
class _Glass extends StatelessWidget {
  const _Glass({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(999),
    child: BackdropFilter.grouped(
      // A CSS blur of 20 is a σ of 20 (filters do not halve it).
      filter: ImageFilter.blur(sigmaX: 20.r, sigmaY: 20.r),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppFixedColors.cameraGlass),
        child: child,
      ),
    ),
  );
}
