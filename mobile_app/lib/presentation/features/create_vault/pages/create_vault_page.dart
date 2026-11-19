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
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_account_chip.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_upload_scene.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_inline_note.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_status.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/create_vault/cubit/create_vault_cubit.dart';
import 'package:keeperpass/presentation/features/create_vault/widgets/create_vault_parts.dart';
import 'package:keeperpass/presentation/features/welcome/widgets/welcome_hero.dart';

/// Create (board `U2-Create`): choose the secret, type it again, write it
/// down; then the vault card is made on screen and travels up the lane.
@RoutePage()
class CreateVaultPage extends StatelessWidget implements AutoRouteWrapper {
  const CreateVaultPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<CreateVaultCubit>(
    create: (_) => getIt<CreateVaultCubit>(),
    child: this,
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateVaultCubit, CreateVaultState>(
      listenWhen: (CreateVaultState a, CreateVaultState b) =>
          a.step != b.step && b.step == CreateStep.done,
      listener: (_, _) => AppHaptics.success(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: BlocBuilder<CreateVaultCubit, CreateVaultState>(
          buildWhen: (CreateVaultState a, CreateVaultState b) =>
              a.step != b.step,
          builder: (BuildContext context, CreateVaultState state) {
            final ProviderAccount? account = context
                .watch<SessionCubit>()
                .state
                .account;
            if (account == null) return const SizedBox.shrink();
            return AnimatedSwitcher(
              duration: AppMotion.reduceMotion(context)
                  ? Duration.zero
                  : AppMotion.enter,
              child: switch (state.step) {
                CreateStep.working ||
                CreateStep.done ||
                CreateStep.failed => _Working(
                  key: const ValueKey<String>('working'),
                  account: account,
                ),
                _ => _Steps(
                  key: const ValueKey<String>('steps'),
                  account: account,
                ),
              },
            );
          },
        ),
      ),
    );
  }
}

class _Steps extends StatefulWidget {
  const _Steps({required this.account, super.key});

  final ProviderAccount account;

  @override
  State<_Steps> createState() => _StepsState();
}

class _StepsState extends State<_Steps> {
  late final CreateVaultCubit _cubit = context.read<CreateVaultCubit>();
  late final SecretTextEditingController _secret = SecretTextEditingController(
    text: _cubit.state.secret,
  );
  late final SecretTextEditingController _repeat = SecretTextEditingController(
    text: _cubit.state.repeat,
  );
  final FocusNode _repeatFocus = FocusNode();

  @override
  void dispose() {
    _secret.dispose();
    _repeat.dispose();
    _repeatFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return BlocConsumer<CreateVaultCubit, CreateVaultState>(
      listenWhen: (CreateVaultState a, CreateVaultState b) =>
          a.generation != b.generation || a.step != b.step,
      listener: (BuildContext context, CreateVaultState state) {
        if (_secret.text != state.secret) _secret.text = state.secret;
        if (_repeat.text != state.repeat) _repeat.text = state.repeat;
        if (state.step == CreateStep.repeat) _repeatFocus.requestFocus();
      },
      builder: (BuildContext context, CreateVaultState state) {
        final bool first = state.step == CreateStep.secret;
        // Step 3 is longer than a screen: its button follows the notice
        // (board `.sticky.flow`) instead of staying pinned.
        final bool flow = state.step == CreateStep.writeDown;
        final Widget action = AppButton(
          label: flow ? t.createVault.create : t.common.continueAction,
          onPressed: state.canContinue ? _cubit.next : null,
        );
        return Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.paddingOf(context).top),
            AppCompactBar(
              leading: first
                  ? AppLinkButton(
                      label: t.common.disconnect,
                      horizontalPadding: 16,
                      onPressed: _cubit.disconnect,
                    )
                  : AppLinkButton.back(
                      label: t.common.back,
                      onPressed: _cubit.back,
                    ),
              trailing: Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: Text(
                  t.common
                      .stepOf(current: state.stepNumber, total: 3)
                      .toUpperCase(),
                  style: AppTextStyles(
                    context,
                  ).sectionLabel().copyWith(color: colors.mutedForeground),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 2.h, 24.w, 0),
              child: AppStepBar(current: state.stepNumber, total: 3),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  24.w,
                  28.h,
                  24.w,
                  flow ? 16.h + MediaQuery.paddingOf(context).bottom : 24.h,
                ),
                child: switch (state.step) {
                  CreateStep.repeat => _RepeatStep(
                    state: state,
                    controller: _repeat,
                    focusNode: _repeatFocus,
                  ),
                  CreateStep.writeDown => _WriteDownStep(
                    state: state,
                    action: action,
                  ),
                  _ => _SecretStep(
                    state: state,
                    account: widget.account,
                    controller: _secret,
                  ),
                },
              ),
            ),
            if (!flow) StickyAction(child: action),
          ],
        );
      },
    );
  }
}

class _SecretStep extends StatelessWidget {
  const _SecretStep({
    required this.state,
    required this.account,
    required this.controller,
  });

  final CreateVaultState state;
  final ProviderAccount account;
  final SecretTextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final CreateVaultCubit cubit = context.read<CreateVaultCubit>();
    final AppColors colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StepHeading(
          eyebrow: t.createVault.eyebrow,
          title: t.createVault.step1Title,
          body: t.createVault.step1Body,
        ),
        SizedBox(height: 18.h),
        AppAccountChip(
          provider: account.provider.logo,
          prefix: t.createVault.settingUpFor,
          email: account.email,
        ),
        SizedBox(height: 26.h),
        AppSecretField(
          // A new generation reveals the new words.
          key: ValueKey<int>(state.generation),
          controller: controller,
          label: t.createVault.secret,
          placeholder: t.createVault.secretPlaceholder,
          large: true,
          initiallyRevealed: state.generated,
          strength: state.secret.isEmpty
              ? null
              : AppStrength.values[state.score],
          textInputAction: TextInputAction.next,
          onChanged: cubit.setSecret,
          onSubmitted: (_) => cubit.next(),
        ),
        if (state.weak) ...<Widget>[
          SizedBox(height: 8.h),
          AppInlineNote(
            icon: AppIconName.triangleAlert,
            text: t.createVault.weakWarning,
            warning: true,
          ),
        ],
        SizedBox(height: 14.h),
        AppButton(
          label: state.generated
              ? t.createVault.generateAnother
              : t.common.generateSecret,
          icon: AppIconName.wandSparkles,
          variant: AppButtonVariant.secondary,
          onPressed: cubit.generate,
        ),
        if (state.generated) ...<Widget>[
          SizedBox(height: 10.h),
          Text(
            t.createVault.generatedNote,
            textAlign: TextAlign.center,
            style: AppTextStyles(
              context,
            ).secondary().copyWith(color: colors.mutedForeground),
          ),
        ],
        SizedBox(height: 14.h),
        const SecretTipsCard(),
      ],
    );
  }
}

class _RepeatStep extends StatelessWidget {
  const _RepeatStep({
    required this.state,
    required this.controller,
    required this.focusNode,
  });

  final CreateVaultState state;
  final SecretTextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final CreateVaultCubit cubit = context.read<CreateVaultCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StepHeading(
          eyebrow: t.createVault.eyebrow,
          title: t.createVault.step2Title,
          body: t.createVault.step2Body,
        ),
        SizedBox(height: 26.h),
        AppSecretField(
          controller: controller,
          focusNode: focusNode,
          label: t.createVault.repeat,
          placeholder: t.common.typeItAgain,
          large: true,
          errorText: state.mismatch ? t.createVault.mismatch : null,
          textInputAction: TextInputAction.done,
          onChanged: cubit.setRepeat,
          onSubmitted: (_) => cubit.next(),
        ),
      ],
    );
  }
}

class _WriteDownStep extends StatelessWidget {
  const _WriteDownStep({required this.state, required this.action});

  final CreateVaultState state;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StepHeading(
          eyebrow: t.createVault.eyebrow,
          title: t.createVault.step3Title,
          body: t.createVault.step3Body,
        ),
        SizedBox(height: 22.h),
        SecretWordsCard(secret: state.secret, generated: state.generated),
        SizedBox(height: 16.h),
        ReadBeforeNotice(
          acknowledged: state.acknowledged,
          onAcknowledged: context.read<CreateVaultCubit>().setAcknowledged,
        ),
        SizedBox(height: 24.h),
        action,
      ],
    );
  }
}

/// "Creating your vault", and "Could not save your vault".
class _Working extends StatelessWidget {
  const _Working({required this.account, super.key});

  final ProviderAccount account;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String storage = account.provider.storageName;

    return BlocBuilder<CreateVaultCubit, CreateVaultState>(
      builder: (BuildContext context, CreateVaultState state) {
        final bool failed = state.step == CreateStep.failed;
        final bool saving = state.stage == CreateStage.saving;
        final String failureDetail =
            state.failure?.maybeMap(
              networkFailure: (_) =>
                  t.createVault.failedDetail(storage: storage),
              orElse: () => state.failure!.getMessage(),
            ) ??
            '';

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
                          uploading: saving && !failed,
                          child: failed
                              ? AppVaultFileCard(
                                  fileName: 'vault.json.enc',
                                  meta: t.createVault.notSaved,
                                  icon: AppIconName.cloudOff,
                                  tone: AppVaultFileTone.destructive,
                                  badge: AppVaultFileBadge.failed,
                                  cipherPreview: kCipherPreview,
                                )
                              : saving
                              ? AppVaultFileCard(
                                  fileName: 'vault.json.enc',
                                  meta: t.common.savingTo(provider: storage),
                                  icon: AppIconName.cloudUpload,
                                  badge: AppVaultFileBadge.working,
                                  cipherPreview: kCipherPreview,
                                )
                              : AppVaultFileCard(
                                  fileName: 'vault.json.enc',
                                  meta: t.createVault.encryptingMeta,
                                  icon: AppIconName.lockKeyhole,
                                  badge: AppVaultFileBadge.working,
                                  cipherPreview: kCipherPreview.substring(
                                    0,
                                    59,
                                  ),
                                  highlight: '0a5e2c9b',
                                ),
                        ),
                      ),
                      Text(
                        failed
                            ? t.createVault.failedTitle
                            : t.createVault.progressTitle,
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
                              label: t.createVault.encrypting,
                              state: saving || failed
                                  ? AppStepState.done
                                  : AppStepState.running,
                              detail: saving || failed
                                  ? null
                                  : t.createVault.encryptingDetail,
                            ),
                            AppProgressStep(
                              label: t.common.savingTo(provider: storage),
                              state: failed
                                  ? AppStepState.failed
                                  : saving
                                  ? AppStepState.running
                                  : AppStepState.waiting,
                              detail: failed
                                  ? failureDetail
                                  : saving
                                  ? t.createVault.savingDetail
                                  : null,
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
                              onPressed: context
                                  .read<CreateVaultCubit>()
                                  .create,
                            ),
                            AppButton(
                              label: t.createVault.backToSecret,
                              variant: AppButtonVariant.ghost,
                              size: AppButtonSize.medium,
                              onPressed: context
                                  .read<CreateVaultCubit>()
                                  .backToSecret,
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
