import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_explainers.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_inline_note.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_status.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_trust_line.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/change_secret/cubit/change_secret_cubit.dart';
import 'package:keeperpass/presentation/features/create_vault/widgets/create_vault_parts.dart';
import 'package:keeperpass/presentation/features/welcome/widgets/welcome_hero.dart';

/// Change secret with its own cubit; true once the secret was changed.
class ChangeSecretPage extends StatelessWidget {
  const ChangeSecretPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ChangeSecretCubit>(
    create: (_) => getIt<ChangeSecretCubit>(),
    child: const ChangeSecretScreen(),
  );
}

/// Re-encrypting the vault under a new secret (boards `Change-secret`,
/// `S5-18` … `S5-23`): the form, then verifying and saving with the vault
/// card, then which secret opens the vault now.
class ChangeSecretScreen extends StatelessWidget {
  const ChangeSecretScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeSecretStep step = context.select(
      (ChangeSecretCubit c) => c.state.step,
    );
    final bool working = switch (step) {
      ChangeSecretStep.verifying ||
      ChangeSecretStep.encrypting ||
      ChangeSecretStep.saving => true,
      _ => false,
    };
    return PopScope<bool>(
      // Leaving mid-change would orphan the work (web: buttons disabled).
      canPop: !working,
      child: Scaffold(
        backgroundColor: context.colors.background,
        resizeToAvoidBottomInset: true,
        body: step == ChangeSecretStep.form ? const _Form() : const _Progress(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final SecretTextEditingController _current = SecretTextEditingController();
  final SecretTextEditingController _secret = SecretTextEditingController();
  final SecretTextEditingController _repeat = SecretTextEditingController();
  final FocusNode _currentFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    final ChangeSecretState state = context.read<ChangeSecretCubit>().state;
    _current.text = state.current;
    _secret.text = state.secret;
    _repeat.text = state.repeat;
  }

  @override
  void dispose() {
    _current.dispose();
    _secret.dispose();
    _repeat.dispose();
    _currentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final ChangeSecretCubit cubit = context.read<ChangeSecretCubit>();
    return BlocConsumer<ChangeSecretCubit, ChangeSecretState>(
      listenWhen: (ChangeSecretState a, ChangeSecretState b) =>
          a.generation != b.generation || (!a.wrongCurrent && b.wrongCurrent),
      listener: (BuildContext context, ChangeSecretState state) {
        if (state.wrongCurrent) {
          // The field keeps focus; nothing else is cleared (board `S5-19`).
          _currentFocus.requestFocus();
          return;
        }
        _secret.text = state.secret;
        _repeat.text = state.repeat;
      },
      builder: (BuildContext context, ChangeSecretState state) => Column(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: AppCompactBar(
              title: t.changeSecret.title,
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
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 120.h),
                  children: <Widget>[
                    Text(
                      t.changeSecret.intro,
                      style: AppTextStyles(
                        context,
                      ).body().copyWith(color: colors.mutedForeground),
                    ),
                    SizedBox(height: 18.h),
                    AppSecretField(
                      controller: _current,
                      focusNode: _currentFocus,
                      label: t.changeSecret.current,
                      errorText: state.wrongCurrent
                          ? t.changeSecret.wrong
                          : null,
                      textInputAction: TextInputAction.next,
                      onChanged: cubit.setCurrent,
                    ),
                    SizedBox(height: 18.h),
                    AppSecretField(
                      key: ValueKey<int>(state.generation),
                      controller: _secret,
                      label: t.newVault.newSecret,
                      labelTrailing: AppLinkButton(
                        label: t.editItem.generate,
                        icon: AppIconName.wandSparkles,
                        fontSize: 14,
                        onPressed: cubit.generate,
                      ),
                      initiallyRevealed: state.generation > 0,
                      strength: state.secret.isEmpty
                          ? null
                          : AppStrength.values[state.score],
                      textInputAction: TextInputAction.next,
                      onChanged: cubit.setSecret,
                    ),
                    if (state.weak) ...<Widget>[
                      SizedBox(height: 8.h),
                      AppInlineNote(
                        icon: AppIconName.triangleAlert,
                        text: t.createVault.weakWarning,
                        warning: true,
                      ),
                    ],
                    SizedBox(height: 18.h),
                    AppSecretField(
                      key: ValueKey<String>('repeat${state.generation}'),
                      controller: _repeat,
                      label: t.newVault.repeat,
                      initiallyRevealed: state.generation > 0,
                      errorText: state.mismatch ? t.createVault.mismatch : null,
                      textInputAction: TextInputAction.done,
                      onChanged: cubit.setRepeat,
                    ),
                    if (state.matches) ...<Widget>[
                      SizedBox(height: 8.h),
                      AppOkNote(t.changeSecret.match),
                    ],
                    AppTrustLine(
                      t.changeSecret.otherDevices,
                      icon: AppIconName.smartphone,
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: StickyAction(
                    child: AppButton(
                      label: t.changeSecret.submit,
                      onPressed: state.canSubmit ? cubit.submit : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Verifying, saving, and both outcomes (boards `S5-20` … `S5-23`).
class _Progress extends StatelessWidget {
  const _Progress();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final ChangeSecretCubit cubit = context.read<ChangeSecretCubit>();
    final ChangeSecretState state = context.watch<ChangeSecretCubit>().state;
    final String storage =
        context.read<SessionCubit>().state.account?.provider.storageName ?? '';
    final ChangeSecretStep step = state.step;
    final bool done = step == ChangeSecretStep.done;
    final bool failed = step == ChangeSecretStep.failed;
    final int percent = (state.progress * 100).round();

    final Widget card = switch (step) {
      ChangeSecretStep.done => AppVaultFileCard(
        fileName: 'vault.json.enc',
        meta: t.changeSecret.doneMeta(storage: storage),
        cipherPreview: kCipherPreview,
        width: 300,
      ),
      ChangeSecretStep.failed => AppVaultFileCard(
        fileName: 'vault.json.enc',
        meta: t.createVault.notSaved,
        icon: AppIconName.cloudOff,
        tone: AppVaultFileTone.destructive,
        badge: AppVaultFileBadge.failed,
        cipherPreview: kCipherPreview,
        width: 300,
      ),
      ChangeSecretStep.saving => AppVaultFileCard(
        fileName: 'vault.json.enc',
        meta: t.changeSecret.savingMeta(storage: storage),
        icon: AppIconName.cloudUpload,
        badge: AppVaultFileBadge.working,
        cipherPreview: kCipherPreview,
        width: 300,
      ),
      _ => AppVaultFileCard(
        fileName: 'vault.json.enc',
        meta: t.changeSecret.verifyingMeta,
        icon: AppIconName.lockKeyhole,
        badge: AppVaultFileBadge.working,
        cipherPreview: kCipherPreview.substring(0, 59),
        highlight: '0a5e2c9b',
        width: 300,
      ),
    };

    final String title = switch (step) {
      ChangeSecretStep.done => t.changeSecret.doneTitle,
      ChangeSecretStep.failed => t.changeSecret.failTitle,
      ChangeSecretStep.saving => t.changeSecret.savingTitle(percent: percent),
      _ => t.changeSecret.verifyingTitle,
    };

    final List<Widget> middle = done || failed
        ? <Widget>[
            Text(
              done
                  ? t.changeSecret.doneBody
                  : state.failure?.maybeMap(
                          networkFailure: (_) =>
                              t.changeSecret.failBody(storage: storage),
                          orElse: () => state.failure!.getMessage(),
                        ) ??
                        '',
              textAlign: TextAlign.center,
              style: styles.body().copyWith(color: colors.mutedForeground),
            ),
          ]
        : <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: AppStagedProgress(
                steps: <AppProgressStep>[
                  if (step == ChangeSecretStep.verifying)
                    AppProgressStep(
                      label: t.changeSecret.stepVerify,
                      state: AppStepState.running,
                      detail: t.changeSecret.stepVerifyNote,
                    )
                  else
                    AppProgressStep(
                      label: t.changeSecret.stepVerified,
                      state: AppStepState.done,
                    ),
                  AppProgressStep(
                    label: step == ChangeSecretStep.saving
                        ? t.changeSecret.stepEncrypted
                        : t.changeSecret.stepEncrypt,
                    state: switch (step) {
                      ChangeSecretStep.saving => AppStepState.done,
                      ChangeSecretStep.encrypting => AppStepState.running,
                      _ => AppStepState.waiting,
                    },
                  ),
                  AppProgressStep(
                    label: step == ChangeSecretStep.saving
                        ? t.changeSecret.stepSaving(storage: storage)
                        : t.changeSecret.stepSave,
                    state: step == ChangeSecretStep.saving
                        ? AppStepState.running
                        : AppStepState.waiting,
                    progress: step == ChangeSecretStep.saving
                        ? state.progress
                        : null,
                  ),
                ],
              ),
            ),
            Text(
              t.changeSecret.keepOpen,
              textAlign: TextAlign.center,
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            ),
          ];

    return Stack(
      children: <Widget>[
        if (!failed)
          const Positioned.fill(
            child: AppBackdrop(glowLeft: -74, glowTop: -70),
          ),
        SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Semantics(
                      liveRegion: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: done || failed ? 16.h : 24.h,
                        children: <Widget>[
                          Center(child: card),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: styles.appBarTitle().copyWith(
                              color: colors.foreground,
                            ),
                          ),
                          ...middle,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (done || failed)
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10.h,
                    children: <Widget>[
                      if (done)
                        AppButton(
                          label: t.common.done,
                          onPressed: () => Navigator.of(context).pop(true),
                        )
                      else ...<Widget>[
                        AppButton(
                          label: t.common.tryAgain,
                          icon: AppIconName.rotateCw,
                          onPressed: cubit.submit,
                        ),
                        AppButton(
                          label: t.common.cancel,
                          variant: AppButtonVariant.secondary,
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
