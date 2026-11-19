import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_account_chip.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_upload_scene.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_inline_note.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_status.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/new_vault/cubit/new_vault_cubit.dart';

/// Start a New Vault (board `U2-New-vault`), from "Forgot your secret?":
/// named for what it does, so nobody mistakes it for a password reset. Two
/// cards tell the story first; nothing is erased.
@RoutePage()
class NewVaultPage extends StatelessWidget implements AutoRouteWrapper {
  const NewVaultPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<NewVaultCubit>(
    create: (_) => getIt<NewVaultCubit>(),
    child: this,
  );

  @override
  Widget build(BuildContext context) {
    final ProviderAccount? account = context
        .watch<SessionCubit>()
        .state
        .account;
    return BlocListener<NewVaultCubit, NewVaultState>(
      listenWhen: (NewVaultState a, NewVaultState b) =>
          a.step != b.step && b.step == NewVaultStep.done,
      listener: (BuildContext context, _) {
        AppToastHost.of(context).show(
          AppToastData(
            icon: AppIconName.archive,
            title: t.newVault.doneTitle,
            detail: t.newVault.doneDetail(
              storage: account?.provider.storageName ?? '',
            ),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: account == null
            ? const SizedBox.shrink()
            : BlocBuilder<NewVaultCubit, NewVaultState>(
                buildWhen: (NewVaultState a, NewVaultState b) =>
                    (a.step == NewVaultStep.form) !=
                    (b.step == NewVaultStep.form),
                builder: (BuildContext context, NewVaultState state) =>
                    AnimatedSwitcher(
                      duration: AppMotion.reduceMotion(context)
                          ? Duration.zero
                          : AppMotion.enter,
                      child: state.step == NewVaultStep.form
                          ? _Form(
                              key: const ValueKey<String>('form'),
                              account: account,
                            )
                          : _Working(
                              key: const ValueKey<String>('working'),
                              account: account,
                            ),
                    ),
              ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({required this.account, super.key});

  final ProviderAccount account;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  late final NewVaultCubit _cubit = context.read<NewVaultCubit>();
  late final SecretTextEditingController _secret = SecretTextEditingController(
    text: _cubit.state.secret,
  );
  late final SecretTextEditingController _repeat = SecretTextEditingController(
    text: _cubit.state.repeat,
  );

  @override
  void dispose() {
    _secret.dispose();
    _repeat.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    final bool? start = await showAppSheet<bool>(
      context,
      builder: (BuildContext context) => _ConfirmSheet(account: widget.account),
    );
    if (start ?? false) await _cubit.start();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String storage = widget.account.provider.storageName;

    return BlocConsumer<NewVaultCubit, NewVaultState>(
      listenWhen: (NewVaultState a, NewVaultState b) =>
          a.generation != b.generation,
      listener: (BuildContext context, NewVaultState state) {
        _secret.text = state.secret;
        _repeat.text = state.repeat;
      },
      builder: (BuildContext context, NewVaultState state) {
        return Stack(
          children: <Widget>[
            const Positioned.fill(
              child: AppBackdrop(glowLeft: 60, glowTop: -160, glowSize: 520),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: MediaQuery.paddingOf(context).top),
                AppCompactBar(
                  leading: AppLinkButton.back(
                    label: t.newVault.backLabel,
                    semanticLabel: t.newVault.backToUnlock,
                    onPressed: () => context.router.maybePop(),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      24.w,
                      2.h,
                      24.w,
                      16.h + MediaQuery.paddingOf(context).bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Semantics(
                          header: true,
                          child: Text(
                            t.newVault.title,
                            style: styles.largeTitle().copyWith(
                              color: colors.foreground,
                              letterSpacing: -0.02 * 32,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        _TwoCards(backupName: state.backupName),
                        SizedBox(height: 24.h),
                        Text(
                          t.newVault.body(
                            provider: widget.account.provider.displayName,
                          ),
                          style: styles.body().copyWith(
                            color: colors.foreground,
                          ),
                        ),
                        SizedBox(height: 18.h),
                        _Points(
                          backupName: state.backupName,
                          storage: storage,
                          size: 14,
                          line: 20,
                        ),
                        SizedBox(height: 26.h),
                        Text(
                          t.newVault.account.toUpperCase(),
                          style: styles.sectionLabel().copyWith(
                            color: colors.mutedForeground,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        AppAccountChip(
                          provider: widget.account.provider.logo,
                          email: widget.account.email,
                          locked: true,
                        ),
                        SizedBox(height: 22.h),
                        AppSecretField(
                          key: ValueKey<int>(state.generation),
                          controller: _secret,
                          label: t.newVault.newSecret,
                          labelTrailing: AppLinkButton(
                            label: t.common.generateSecret,
                            icon: AppIconName.wandSparkles,
                            fontSize: 14,
                            onPressed: _cubit.generate,
                          ),
                          placeholder: t.newVault.newSecretPlaceholder,
                          large: true,
                          initiallyRevealed: state.generation > 0,
                          strength: state.secret.isEmpty
                              ? null
                              : AppStrength.values[state.score],
                          textInputAction: TextInputAction.next,
                          onChanged: _cubit.setSecret,
                        ),
                        if (state.weak) ...<Widget>[
                          SizedBox(height: 8.h),
                          AppInlineNote(
                            icon: AppIconName.triangleAlert,
                            text: t.newVault.weakWarning,
                            warning: true,
                          ),
                        ],
                        SizedBox(height: 20.h),
                        AppSecretField(
                          key: ValueKey<String>('repeat${state.generation}'),
                          controller: _repeat,
                          label: t.newVault.repeat,
                          placeholder: t.common.typeItAgain,
                          large: true,
                          initiallyRevealed: state.generation > 0,
                          errorText: state.mismatch
                              ? t.createVault.mismatch
                              : null,
                          textInputAction: TextInputAction.done,
                          onChanged: _cubit.setRepeat,
                        ),
                        SizedBox(height: 20.h),
                        AppInlineNote(
                          icon: AppIconName.keyRound,
                          text: t.newVault.warn,
                        ),
                        SizedBox(height: 22.h),
                        AppButton(
                          label: t.newVault.start,
                          variant: AppButtonVariant.destructive,
                          onPressed: state.canStart ? _confirm : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// The old vault steps back as a dated backup; a new, empty one takes its
/// place.
class _TwoCards extends StatelessWidget {
  const _TwoCards({required this.backupName});

  final String backupName;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        height: 156.h,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              child: Transform.rotate(
                angle: -5 * math.pi / 180,
                child: AppVaultFileCard(
                  width: 272,
                  fileName: backupName,
                  meta: t.newVault.oldMeta,
                  icon: AppIconName.archive,
                  tone: AppVaultFileTone.muted,
                  badge: AppVaultFileBadge.lock,
                  dim: true,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 70.h,
              child: Transform.rotate(
                angle: 3 * math.pi / 180,
                child: AppVaultFileCard(
                  width: 272,
                  fileName: 'vault.json.enc',
                  meta: t.newVault.newMeta,
                  icon: AppIconName.sparkles,
                  badge: AppVaultFileBadge.plus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The three consequences (`.nrow`).
class _Points extends StatelessWidget {
  const _Points({
    required this.backupName,
    required this.storage,
    required this.size,
    required this.line,
    this.inSheet = false,
  });

  final String backupName;
  final String storage;
  final double size;
  final double line;
  final bool inSheet;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final TextStyle text = styles
        .body()
        .resized(size, line: line)
        .copyWith(color: colors.foreground);
    final List<(AppIconName, InlineSpan)> points = <(AppIconName, InlineSpan)>[
      (AppIconName.lockKeyhole, TextSpan(text: t.newVault.pointLocked)),
      (
        AppIconName.archive,
        inSheet
            ? TextSpan(text: t.newVault.confirmKept(storage: storage))
            : t.newVault.pointKept(
                file: TextSpan(
                  text: backupName,
                  style: styles.fileName().resized(12, line: line),
                ),
                storage: TextSpan(text: storage),
              ),
      ),
      (
        AppIconName.sparkles,
        TextSpan(
          text: inSheet ? t.newVault.confirmFresh : t.newVault.pointFresh,
        ),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: inSheet ? 14.h : 12.h,
      children: <Widget>[
        for (final (AppIconName icon, InlineSpan span) in points)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.w,
            children: <Widget>[
              AppIconTile(AppTileIcon(icon), size: AppTileSize.small),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: (inSheet ? 5 : 6).h),
                  child: Text.rich(span, style: text),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// "Start a New Vault?" — a sheet, not an alert: room to name each
/// consequence, with Cancel as large as the action.
class _ConfirmSheet extends StatelessWidget {
  const _ConfirmSheet({required this.account});

  final ProviderAccount account;

  @override
  Widget build(BuildContext context) {
    final NewVaultState state = context.read<NewVaultCubit>().state;
    return AppSheet(
      title: t.newVault.confirmTitle,
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 18.h,
        children: <Widget>[
          _Points(
            backupName: state.backupName,
            storage: account.provider.storageName,
            size: 15,
            line: 22,
            inSheet: true,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10.h,
            children: <Widget>[
              AppButton(
                label: t.newVault.start,
                variant: AppButtonVariant.destructive,
                onPressed: () => Navigator.of(context).pop(true),
              ),
              AppButton(
                label: t.common.cancel,
                variant: AppButtonVariant.secondary,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// "Starting a new vault", and "Nothing was changed".
class _Working extends StatelessWidget {
  const _Working({required this.account, super.key});

  final ProviderAccount account;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String storage = account.provider.storageName;

    return BlocBuilder<NewVaultCubit, NewVaultState>(
      builder: (BuildContext context, NewVaultState state) {
        final bool failed = state.step == NewVaultStep.failed;
        final NewVaultStage stage = state.stage;
        final bool backupFailed = failed && stage != NewVaultStage.saving;
        final bool saveFailed = failed && stage == NewVaultStage.saving;

        AppStepState stepState(NewVaultStage step) {
          if (step.index < stage.index) return AppStepState.done;
          if (step.index > stage.index) return AppStepState.waiting;
          return failed ? AppStepState.failed : AppStepState.running;
        }

        final String failureDetail = backupFailed
            ? t.newVault.backupFailedDetail(storage: storage)
            : state.failure?.maybeMap(
                    networkFailure: (_) =>
                        t.createVault.failedDetail(storage: storage),
                    orElse: () => state.failure!.getMessage(),
                  ) ??
                  '';

        final AppVaultFileCard oldCard = backupFailed
            ? AppVaultFileCard(
                width: 250,
                fileName: 'vault.json.enc',
                meta: t.newVault.backupFailedMeta,
                icon: AppIconName.archive,
                tone: AppVaultFileTone.destructive,
                badge: AppVaultFileBadge.failed,
                dim: true,
              )
            : AppVaultFileCard(
                width: 250,
                fileName: state.backupName,
                meta: stage == NewVaultStage.backingUp
                    ? t.newVault.backingUp
                    : t.newVault.oldMeta,
                icon: AppIconName.archive,
                tone: AppVaultFileTone.muted,
                badge: stage == NewVaultStage.backingUp
                    ? AppVaultFileBadge.working
                    : AppVaultFileBadge.lock,
                dim: true,
              );
        final AppVaultFileCard newCard = saveFailed
            ? AppVaultFileCard(
                fileName: 'vault.json.enc',
                meta: t.createVault.notSaved,
                icon: AppIconName.cloudOff,
                tone: AppVaultFileTone.destructive,
                badge: AppVaultFileBadge.failed,
              )
            : switch (stage) {
                NewVaultStage.encrypting => AppVaultFileCard(
                  fileName: 'vault.json.enc',
                  meta: t.createVault.encryptingMeta,
                  icon: AppIconName.lockKeyhole,
                  badge: AppVaultFileBadge.working,
                ),
                NewVaultStage.backingUp => AppVaultFileCard(
                  fileName: 'vault.json.enc',
                  meta: t.newVault.readyMeta,
                  icon: AppIconName.lockKeyhole,
                ),
                NewVaultStage.saving => AppVaultFileCard(
                  fileName: 'vault.json.enc',
                  meta: t.common.savingTo(provider: storage),
                  icon: AppIconName.cloudUpload,
                  badge: AppVaultFileBadge.working,
                ),
              };

        return Stack(
          children: <Widget>[
            const Positioned.fill(
              child: AppBackdrop(glowLeft: -74, glowTop: -70),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 24.h,
                    children: <Widget>[
                      Semantics(
                        liveRegion: true,
                        child: AppUploadScene(
                          provider: account.provider.logo,
                          uploading: stage == NewVaultStage.saving && !failed,
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.h),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Positioned(
                                  left: -18.w,
                                  top: -30.h,
                                  child: Transform.rotate(
                                    angle: -6 * math.pi / 180,
                                    child: oldCard,
                                  ),
                                ),
                                newCard,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        backupFailed
                            ? t.newVault.nothingChanged
                            : saveFailed
                            ? t.createVault.failedTitle
                            : t.newVault.progressTitle,
                        textAlign: TextAlign.center,
                        style: styles.appBarTitle().copyWith(
                          color: colors.foreground,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: AppStagedProgress(
                          steps: <AppProgressStep>[
                            AppProgressStep(
                              label: t.newVault.encrypting,
                              state: stepState(NewVaultStage.encrypting),
                            ),
                            AppProgressStep(
                              label: t.newVault.backingUp,
                              state: stepState(NewVaultStage.backingUp),
                              detail: backupFailed
                                  ? failureDetail
                                  : stage == NewVaultStage.backingUp
                                  ? t.newVault.backingUpDetail(storage: storage)
                                  : null,
                            ),
                            AppProgressStep(
                              label: t.common.savingTo(provider: storage),
                              state: stepState(NewVaultStage.saving),
                              detail: saveFailed ? failureDetail : null,
                            ),
                          ],
                        ),
                      ),
                      if (failed)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 4.h,
                          children: <Widget>[
                            AppButton(
                              label: t.common.tryAgain,
                              onPressed: context.read<NewVaultCubit>().start,
                            ),
                            AppButton(
                              label: t.newVault.backToUnlock,
                              variant: AppButtonVariant.ghost,
                              size: AppButtonSize.medium,
                              onPressed: () => context.router.maybePop(),
                            ),
                          ],
                        )
                      else
                        Text(
                          t.common.keepOpen,
                          textAlign: TextAlign.center,
                          style: styles.secondary().copyWith(
                            color: colors.mutedForeground,
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
}
