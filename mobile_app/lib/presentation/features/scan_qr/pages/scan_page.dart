import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_trust_line.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/features/create_vault/widgets/create_vault_parts.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/setup_key_page.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/widgets/code_found_sheet.dart';
import 'package:keeperpass/presentation/features/scan_qr/widgets/scan_camera.dart';
import 'package:keeperpass/presentation/features/scan_qr/widgets/scanning_view.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';

/// "Scan QR code" in Codes (board `Scan-QR`): scan or type a code and save
/// it. [CodeAdded] once saved, [NewItemKey] for a typed key going into a new
/// item (named on the new-item screen), null when left.
Future<ScanOutcome?> scanCodeIntoVault(BuildContext context) =>
    _openScan(context, forField: false);

/// "Scan QR code" on a 2FA field in Edit: the key read or typed, for that
/// field (plan, Part 15 rule 9); null when left.
Future<String?> scanCodeForField(BuildContext context) async {
  final ScanOutcome? outcome = await _openScan(context, forField: true);
  return outcome is FieldKey ? outcome.key : null;
}

/// Set while camera access is read before the scanner opens: a second tap in
/// that moment opens no second scanner.
bool _opening = false;

/// Over everything, starting where camera access stands — no flash of the
/// primer when the camera is already allowed.
Future<ScanOutcome?> _openScan(
  BuildContext context, {
  required bool forField,
}) async {
  if (_opening) return null;
  _opening = true;
  final NavigatorState navigator = Navigator.of(context, rootNavigator: true);
  final CameraAccess access = await getIt<CameraPermissionService>()
      .status()
      .whenComplete(() => _opening = false);
  if (!navigator.mounted) return null;
  return navigator.push(
    MaterialPageRoute<ScanOutcome>(
      fullscreenDialog: true,
      builder: (_) => ScanPage(access: access, forField: forField),
    ),
  );
}

/// The scan screens with their own cubit.
class ScanPage extends StatelessWidget {
  const ScanPage({required this.access, required this.forField, super.key});

  final CameraAccess access;
  final bool forField;

  @override
  Widget build(BuildContext context) => BlocProvider<ScanCubit>(
    create: (_) => getIt<ScanCubit>()..open(access),
    child: ScanScreen(forField: forField),
  );
}

/// [ScanPage] under a given cubit (tests provide their own, and a still
/// [camera]).
class ScanScreen extends StatefulWidget {
  const ScanScreen({
    required this.forField,
    this.camera = MobileScannerCamera.new,
    super.key,
  });

  final bool forField;
  final ScanCamera Function() camera;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with WidgetsBindingObserver, ToastsOverTabBar<ScanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Back from the phone's Settings: scanning starts if the camera is now
  /// allowed.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(context.read<ScanCubit>().recheck());
    }
  }

  void _leave([ScanOutcome? outcome]) => Navigator.of(context).pop(outcome);

  /// "Enter setup key": for the field, the key alone; from Codes, with the
  /// Item choice — an existing item is saved here, a new one is named on
  /// the new-item screen.
  Future<void> _enterKey() async {
    final ScanCubit cubit = context.read<ScanCubit>();
    if (widget.forField) {
      final String? key = await openSetupKey(context);
      if (key != null && mounted) _leave(FieldKey(key));
      return;
    }
    final TypedSetupKey? typed = await openSetupKeyFor(
      context,
      items: cubit.allItems(),
    );
    if (typed == null || !mounted) return;
    final String? itemId = typed.itemId;
    if (itemId == null) {
      _leave(NewItemKey(typed.key));
      return;
    }
    final CodeAdded? added = await cubit.saveTyped(typed.key, itemId: itemId);
    if (added != null && mounted) _leave(added);
  }

  /// "Code Found" over the camera, with a light haptic.
  Future<void> _showFound() async {
    final ScanCubit cubit = context.read<ScanCubit>();
    unawaited(AppHaptics.found());
    final ScanOutcome? outcome = await showAppSheet<ScanOutcome>(
      context,
      builder: (_) => BlocProvider<ScanCubit>.value(
        value: cubit,
        child: CodeFoundSheet(forField: widget.forField),
      ),
    );
    if (!mounted) return;
    if (outcome != null) {
      _leave(outcome);
    } else {
      cubit.closeFound();
    }
  }

  void _say(ScanNotice notice) =>
      AppToastHost.of(context).show(switch (notice) {
        ScanNotice.notACode => AppToastData(
          icon: AppIconName.scanQrCode,
          title: t.scan.notACode,
        ),
        ScanNotice.unsupported => AppToastData(
          icon: AppIconName.circleAlert,
          title: t.scan.unsupported,
        ),
        ScanNotice.invalidKey => AppToastData(
          icon: AppIconName.keyRound,
          title: t.totp.invalidKey,
        ),
        ScanNotice.cameraFailed => AppToastData(
          icon: AppIconName.cameraOff,
          title: t.scan.cameraFailed,
        ),
      });

  @override
  Widget build(BuildContext context) {
    final ScanCubit cubit = context.read<ScanCubit>();
    final ScanStep step = context.select<ScanCubit, ScanStep>(
      (ScanCubit c) => c.state.step,
    );
    return MultiBlocListener(
      listeners: <BlocListener<ScanCubit, ScanState>>[
        BlocListener<ScanCubit, ScanState>(
          listenWhen: (ScanState a, ScanState b) =>
              a.found == null && b.found != null,
          listener: (_, _) => unawaited(_showFound()),
        ),
        BlocListener<ScanCubit, ScanState>(
          listenWhen: (ScanState a, ScanState b) => b.notices > a.notices,
          listener: (_, ScanState state) => _say(state.notice!),
        ),
      ],
      child: Scaffold(
        backgroundColor: step == ScanStep.scanning
            ? Colors.transparent
            : context.colors.background,
        body: switch (step) {
          ScanStep.primer => _Primer(
            onContinue: () => unawaited(cubit.allowCamera()),
            onEnterKey: () => unawaited(_enterKey()),
          ),
          ScanStep.scanning => ScanningView(
            camera: widget.camera,
            onClose: _leave,
            onEnterKey: () => unawaited(_enterKey()),
          ),
          ScanStep.cameraOff => _CameraOff(
            onOpenSettings: () => unawaited(cubit.openSettings()),
            onEnterKey: () => unawaited(_enterKey()),
          ),
        },
      ),
    );
  }
}

/// The compact bar with Cancel, the page, and its sticky actions.
class _Frame extends StatelessWidget {
  const _Frame({required this.children, required this.actions});

  final List<Widget> children;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      SafeArea(
        bottom: false,
        child: AppCompactBar(
          title: t.scan.title,
          leading: AppLinkButton.bar(
            label: t.common.cancel,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
      Expanded(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 180.h),
              children: children,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: StickyAction(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10.h,
                  children: actions,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

/// Before the camera (board `S6-27`): why, and what is kept — only the
/// code; Continue lets the phone ask.
class _Primer extends StatelessWidget {
  const _Primer({required this.onContinue, required this.onEnterKey});

  final VoidCallback onContinue;
  final VoidCallback onEnterKey;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return _Frame(
      actions: <Widget>[
        AppButton(label: t.common.continueAction, onPressed: onContinue),
        AppButton(
          label: t.scan.enterInstead,
          variant: AppButtonVariant.secondary,
          onPressed: onEnterKey,
        ),
      ],
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: <Widget>[
              const AppIconTile(
                AppTileIcon(AppIconName.scanQrCode),
                size: AppTileSize.primer,
              ),
              // The tile's 12 pt margin, the 12 pt gap, the title's 6 pt.
              SizedBox(height: 30.h),
              Semantics(
                header: true,
                child: Text(
                  t.scan.primerTitle,
                  textAlign: TextAlign.center,
                  style: styles.appBarTitle().copyWith(
                    color: colors.foreground,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                t.scan.primerBody,
                textAlign: TextAlign.center,
                style: styles.body().copyWith(color: colors.mutedForeground),
              ),
            ],
          ),
        ),
        AppTrustLine(t.scan.primerPrivacy, icon: AppIconName.camera),
        AppTrustLine(t.scan.primerNext, icon: AppIconName.info),
      ],
    );
  }
}

/// Camera access declined (board `S6-31`): how to change it, or typing
/// instead — no blame and no dead end.
class _CameraOff extends StatelessWidget {
  const _CameraOff({required this.onOpenSettings, required this.onEnterKey});

  final VoidCallback onOpenSettings;
  final VoidCallback onEnterKey;

  @override
  Widget build(BuildContext context) => _Frame(
    actions: <Widget>[
      AppButton(
        label: t.scan.openSettings,
        icon: AppIconName.externalLink,
        onPressed: onOpenSettings,
      ),
      AppButton(
        label: t.scan.enterInstead,
        variant: AppButtonVariant.secondary,
        onPressed: onEnterKey,
      ),
    ],
    children: <Widget>[
      // `.empty2` at 120 pt, its sides narrowed to 8 pt on this board.
      VaultEmptyLayout(
        topMargin: 120,
        sides: 8,
        icon: const AppTileIcon(AppIconName.cameraOff),
        title: t.scan.cameraOffTitle,
        message: t.scan.cameraOffBody,
      ),
    ],
  );
}
