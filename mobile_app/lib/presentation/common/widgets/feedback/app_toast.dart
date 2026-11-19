import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';

/// What a toast says (board C6): a title, one line, and the clipboard
/// countdown when it applies.
@immutable
class AppToastData {
  const AppToastData({
    required this.icon,
    required this.title,
    this.detail,
    this.countdown,
    this.visible,
  });

  final AppIconName icon;

  /// "Password copied".
  final String title;

  /// "From GitHub · Clears in 30 s".
  final String? detail;

  /// The clipboard countdown: the toast stays while it runs and the accent
  /// bar along its bottom shrinks to nothing.
  final Duration? countdown;

  /// How long it stays (3 s by default): "Sign-in canceled" stays 4 s
  /// (board `U2-Connect`).
  final Duration? visible;
}

/// The toast card (`.toast`).
class AppToast extends StatelessWidget {
  const AppToast(this.data, {this.progress, this.resting = false, super.key});

  final AppToastData data;

  /// What is left of the countdown, 1 → 0.
  final Animation<double>? progress;

  /// Drawn in a page rather than floating over it (the Clear Clipboard
  /// preview, board `S5-16`): the resting ring, not the floating shadow.
  final bool resting;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Semantics(
      liveRegion: true,
      container: true,
      child: AppSurface(
        elevation: resting ? AppElevation.resting : AppElevation.floating,
        clip: true,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 14.w, 10.h),
              child: Row(
                spacing: 12.w,
                children: <Widget>[
                  AppIconTile(AppTileIcon(data.icon), size: AppTileSize.toast),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.title,
                          style: styles.button().copyWith(
                            color: colors.foreground,
                          ),
                        ),
                        if (data.detail != null)
                          Text(
                            data.detail!,
                            style: styles.secondary().copyWith(
                              color: colors.mutedForeground,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (progress != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: progress!,
                    builder: (BuildContext context, _) => Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: FractionallySizedBox(
                        widthFactor: progress!.value,
                        child: Container(height: 3, color: colors.primary),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Hosts toasts above every screen: at the bottom, above the tab bar. Put it
/// in `MaterialApp.builder`; show a toast with `AppToastHost.of(context)`.
class AppToastHost extends StatefulWidget {
  const AppToastHost({required this.child, super.key});

  final Widget child;

  static AppToastHostState of(BuildContext context) {
    final AppToastHostState? state = context
        .findAncestorStateOfType<AppToastHostState>();
    assert(state != null, 'No AppToastHost above this context.');
    return state!;
  }

  /// The host, or null when there is none (component tests).
  static AppToastHostState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<AppToastHostState>();

  @override
  State<AppToastHost> createState() => AppToastHostState();
}

class AppToastHostState extends State<AppToastHost>
    with TickerProviderStateMixin {
  late final AnimationController _presence;
  late final AnimationController _countdown;
  AppToastData? _current;
  Timer? _hide;

  /// Space kept free under toasts — the tab bar's height when a tab screen
  /// is showing (set by the shell), 0 otherwise.
  final ValueNotifier<double> bottomOffset = ValueNotifier<double>(0);

  /// How many screens cover the tab bar (an item and what opens from it):
  /// while any does, toasts sit 40 pt from the bottom edge (board `S3-20`).
  /// Change it after the frame — see [ToastsOverTabBar].
  final ValueNotifier<int> coveringTabBar = ValueNotifier<int>(0);

  /// A screen with its own controls along the bottom (the scanner, board
  /// `Scan-QR`) raises toasts to this distance from the bottom edge while it
  /// is up; null otherwise.
  final ValueNotifier<double?> raisedTo = ValueNotifier<double?>(null);

  @override
  void initState() {
    super.initState();
    // Created up front: a lazy controller would first be built in dispose().
    _presence = AnimationController(vsync: this);
    _countdown = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _hide?.cancel();
    _presence.dispose();
    _countdown.dispose();
    bottomOffset.dispose();
    coveringTabBar.dispose();
    raisedTo.dispose();
    super.dispose();
  }

  /// Shows [data], replacing any toast on screen.
  void show(AppToastData data) {
    _hide?.cancel();
    final bool reduceMotion = AppMotion.reduceMotion(context);
    setState(() => _current = data);
    _presence.animateTo(
      1,
      duration: reduceMotion ? Duration.zero : AppMotion.enter,
      curve: AppMotion.easeOut,
    );

    final Duration visible =
        data.countdown ?? data.visible ?? AppMotion.toastVisible;
    if (data.countdown != null) {
      _countdown
        ..duration = data.countdown
        ..value = 1
        ..animateTo(0, curve: Curves.linear);
    }
    _hide = Timer(visible, dismiss);
  }

  /// Hides the toast on screen.
  void dismiss() {
    _hide?.cancel();
    if (!mounted) return;
    final bool reduceMotion = AppMotion.reduceMotion(context);
    _presence
        .animateBack(
          0,
          duration: reduceMotion ? Duration.zero : AppMotion.base,
          curve: AppMotion.easeOut,
        )
        .whenComplete(() {
          if (mounted && _presence.value == 0) setState(() => _current = null);
        });
  }

  @override
  Widget build(BuildContext context) {
    final AppToastData? current = _current;
    return Stack(
      children: <Widget>[
        widget.child,
        if (current != null)
          ListenableBuilder(
            listenable: Listenable.merge(<Listenable>[
              bottomOffset,
              coveringTabBar,
              raisedTo,
            ]),
            builder: (BuildContext context, Widget? child) => Positioned(
              left: 16.w,
              right: 16.w,
              bottom:
                  raisedTo.value ??
                  MediaQuery.paddingOf(context).bottom +
                      (coveringTabBar.value > 0
                          ? 6.h
                          : bottomOffset.value + 12.h),
              child: child!,
            ),
            child: AnimatedBuilder(
              animation: _presence,
              // The host sits above the routes, outside any Material: without
              // one, text falls back to the debug style (yellow underline).
              child: Material(
                type: MaterialType.transparency,
                child: AppToast(
                  current,
                  progress: current.countdown == null ? null : _countdown,
                ),
              ),
              builder: (BuildContext context, Widget? toast) => Opacity(
                opacity: _presence.value,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    (1 - _presence.value) * AppMotion.toastSlide.h,
                  ),
                  child: toast,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// For a screen pushed over the tab bar: while it is up, toasts sit at the
/// bottom edge instead of above the (hidden) bar. Counted, so screens opened
/// from it, and the shell going away with it, settle in any order.
mixin ToastsOverTabBar<T extends StatefulWidget> on State<T> {
  AppToastHostState? _toastHost;

  @override
  void initState() {
    super.initState();
    // After the frame: the host must not be marked dirty while building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final AppToastHostState? host = AppToastHost.maybeOf(context);
      if (host == null || !host.mounted) return;
      _toastHost = host;
      host.coveringTabBar.value++;
    });
  }

  @override
  void dispose() {
    final AppToastHostState? host = _toastHost;
    if (host != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (host.mounted) host.coveringTabBar.value--;
      });
    }
    super.dispose();
  }
}
