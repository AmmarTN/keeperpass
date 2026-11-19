import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/migration_stage.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/core/utils/text/initials.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_provider_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_avatar.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_explainers.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_inline_note.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_status.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/create_vault/widgets/create_vault_parts.dart';
import 'package:keeperpass/presentation/features/move_vault/cubit/move_vault_cubit.dart';
import 'package:keeperpass/presentation/features/move_vault/widgets/move_diagram.dart';
import 'package:keeperpass/presentation/features/welcome/widgets/welcome_hero.dart';

/// Move vault to [destination], with its own cubit.
class MoveVaultPage extends StatelessWidget {
  const MoveVaultPage({required this.destination, super.key});

  final ProviderId destination;

  @override
  Widget build(BuildContext context) => BlocProvider<MoveVaultCubit>(
    create: (_) => getIt<MoveVaultCubit>()..start(destination),
    child: const MoveVaultScreen(),
  );
}

/// Moving the vault to the other storage (boards `Move-vault`, `S5-25` …
/// `S5-31`): what will happen and Connect, then who it goes to and with
/// which secret, then the stages. A move that worked ends on Welcome.
class MoveVaultScreen extends StatefulWidget {
  const MoveVaultScreen({super.key});

  @override
  State<MoveVaultScreen> createState() => _MoveVaultScreenState();
}

class _MoveVaultScreenState extends State<MoveVaultScreen>
    with ToastsOverTabBar<MoveVaultScreen> {
  @override
  Widget build(BuildContext context) {
    final MoveVaultStep step = context.select(
      (MoveVaultCubit c) => c.state.step,
    );
    return BlocListener<MoveVaultCubit, MoveVaultState>(
      listenWhen: (MoveVaultState a, MoveVaultState b) =>
          a.connectFailure != b.connectFailure &&
          b.connectFailure is SignInCancelled,
      // A closed sign-in is not an error (as Welcome).
      listener: (BuildContext context, _) => AppToastHost.of(context).show(
        AppToastData(
          icon: AppIconName.info,
          title: t.errors.vault.signInCanceled,
          detail: t.connect.canceledDetail,
        ),
      ),
      child: PopScope<void>(
        // Leaving mid-move would orphan the work (web: Cancel disabled).
        canPop: step != MoveVaultStep.moving,
        child: Scaffold(
          backgroundColor: context.colors.background,
          resizeToAvoidBottomInset: true,
          body: switch (step) {
            MoveVaultStep.start => const _Start(),
            MoveVaultStep.confirm => const _Confirm(),
            MoveVaultStep.moving => const _Moving(),
            MoveVaultStep.failed => const _NotMoved(),
          },
        ),
      ),
    );
  }
}

/// The compact bar with Cancel, and the page under it with its sticky
/// action.
class _Frame extends StatelessWidget {
  const _Frame({required this.children, required this.action, this.top = 0});

  final List<Widget> children;
  final Widget action;
  final double top;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      SafeArea(
        bottom: false,
        child: AppCompactBar(
          title: t.moveVault.title,
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
              padding: EdgeInsets.fromLTRB(16.w, top.h, 16.w, 150.h),
              children: children,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: StickyAction(child: action),
            ),
          ],
        ),
      ),
    ],
  );
}

/// What will happen, and Connect (board `S5-25`).
class _Start extends StatelessWidget {
  const _Start();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final MoveVaultCubit cubit = context.read<MoveVaultCubit>();
    final MoveVaultState state = context.watch<MoveVaultCubit>().state;
    final ProviderId to = state.destination!;
    final Failure? failure = state.connectFailure;
    return _Frame(
      top: 26,
      action: AppProviderButton(
        provider: to.logo,
        label: t.moveVault.connect(storage: to.storageName),
        busy: state.connecting,
        onCard: true,
        onPressed: cubit.connect,
      ),
      children: <Widget>[
        if (state.from != null) MoveDiagram(from: state.from!, to: to),
        SizedBox(height: 24.h),
        Text(
          t.settings.moveTo(storage: to.storageName),
          textAlign: TextAlign.center,
          style: styles.appBarTitle().copyWith(color: colors.foreground),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(6.w, 8.h, 6.w, 0),
          child: Text(
            t.moveVault.intro,
            textAlign: TextAlign.center,
            style: styles.body().copyWith(color: colors.mutedForeground),
          ),
        ),
        SizedBox(height: 22.h),
        AppNumberedList(
          items: <Widget>[
            Text(t.moveVault.step1(storage: to.storageName)),
            Text(t.moveVault.step2),
            Text(t.moveVault.step3),
          ],
        ),
        if (failure != null && failure is! SignInCancelled) ...<Widget>[
          SizedBox(height: 16.h),
          AppBanner(
            tone: AppBannerTone.error,
            icon: AppIconName.triangleAlert,
            title: failure.getMessage(),
          ),
        ],
      ],
    );
  }
}

/// Who it goes to, the consent an existing vault needs, and which secret
/// (boards `S5-26`, `S5-27`).
class _Confirm extends StatefulWidget {
  const _Confirm();

  @override
  State<_Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<_Confirm> {
  final SecretTextEditingController _secret = SecretTextEditingController();
  final SecretTextEditingController _repeat = SecretTextEditingController();

  @override
  void initState() {
    super.initState();
    final MoveVaultState state = context.read<MoveVaultCubit>().state;
    _secret.text = state.secret;
    _repeat.text = state.repeat;
  }

  @override
  void dispose() {
    _secret.dispose();
    _repeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final MoveVaultCubit cubit = context.read<MoveVaultCubit>();
    return BlocConsumer<MoveVaultCubit, MoveVaultState>(
      listenWhen: (MoveVaultState a, MoveVaultState b) =>
          a.generation != b.generation,
      listener: (BuildContext context, MoveVaultState state) {
        _secret.text = state.secret;
        _repeat.text = state.repeat;
      },
      builder: (BuildContext context, MoveVaultState state) {
        final MigrationTarget target = state.target!;
        final ProviderId to = state.destination!;
        final String name = target.name.isNotEmpty ? target.name : target.email;
        return _Frame(
          action: AppButton(
            label: t.moveVault.submit,
            onPressed: state.canMove ? cubit.move : null,
          ),
          children: <Widget>[
            AppSectionLabel(t.moveVault.account),
            AppSurface(
              padding: EdgeInsets.all(14.r),
              child: Row(
                spacing: 12.w,
                children: <Widget>[
                  AppAvatar(
                    initials: initialsOf(name),
                    provider: to.logo,
                    badgeRing: colors.card,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: styles.rowTitle().copyWith(
                            color: colors.foreground,
                          ),
                        ),
                        if (target.name.isNotEmpty)
                          Text(
                            target.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
            if (target.hasVault) ...<Widget>[
              SizedBox(height: 12.h),
              AppBanner(
                tone: AppBannerTone.warning,
                icon: AppIconName.triangleAlert,
                title: t.moveVault.existingTitle(storage: to.storageName),
                body: t.moveVault.existingBody(storage: to.storageName),
                footer: AppCheckRow(
                  label: t.moveVault.existingConfirm,
                  checked: state.replaceConfirmed,
                  onChanged: cubit.setReplace,
                ),
              ),
            ],
            AppSectionLabel(t.moveVault.secretSection),
            AppInsetGroup(
              dividerInset: AppDividerInset.text,
              children: <Widget>[
                AppSettingsRow.radio(
                  title: t.moveVault.keepSecret,
                  selected: !state.newSecret,
                  onTap: () => cubit.setNewSecret(false),
                ),
                AppSettingsRow.radio(
                  title: t.moveVault.newSecret,
                  subtitle: t.moveVault.newSecretNote,
                  selected: state.newSecret,
                  onTap: () => cubit.setNewSecret(true),
                ),
              ],
            ),
            if (state.newSecret) ...<Widget>[
              SizedBox(height: 16.h),
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
            ],
          ],
        );
      },
    );
  }
}

/// The stages, with the upload's progress (board `S5-28`).
class _Moving extends StatelessWidget {
  const _Moving();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final MoveVaultState state = context.watch<MoveVaultCubit>().state;
    final ProviderId to = state.destination!;
    final int at = state.stage.index;

    AppStepState stateOf(MigrationStage stage) => switch (stage.index) {
      final int i when i < at => AppStepState.done,
      final int i when i == at => AppStepState.running,
      _ => AppStepState.waiting,
    };

    return Stack(
      children: <Widget>[
        const Positioned.fill(child: AppBackdrop(glowLeft: -74, glowTop: -70)),
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Semantics(
                liveRegion: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24.h,
                  children: <Widget>[
                    if (state.from != null)
                      MoveDiagram(from: state.from!, to: to),
                    Text(
                      t.moveVault.movingTitle,
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
                            label: t.moveVault.stageEncrypting,
                            state: stateOf(MigrationStage.encrypting),
                          ),
                          AppProgressStep(
                            label: t.moveVault.stageSaving(
                              storage: to.storageName,
                            ),
                            state: stateOf(MigrationStage.uploading),
                            progress: state.stage == MigrationStage.uploading
                                ? state.progress
                                : null,
                          ),
                          AppProgressStep(
                            label: t.moveVault.stageChecking,
                            state: stateOf(MigrationStage.verifying),
                          ),
                          AppProgressStep(
                            label: t.moveVault.stageRenaming,
                            state: stateOf(MigrationStage.finishing),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      t.moveVault.movingNote,
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
        ),
      ],
    );
  }
}

/// Nothing changed; try again or leave (board `S5-31`).
class _NotMoved extends StatelessWidget {
  const _NotMoved();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final MoveVaultCubit cubit = context.read<MoveVaultCubit>();
    final MoveVaultState state = context.watch<MoveVaultCubit>().state;
    final Failure? failure = state.failure;
    final String body = switch (failure) {
      MigrationFailure(error: MigrationError.verifyFailed) ||
      null => t.moveVault.notMovedBody,
      final Failure failure => failure.getMessage(),
    };
    return SafeArea(
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
                    spacing: 16.h,
                    children: <Widget>[
                      Center(
                        child: AppVaultFileCard(
                          fileName: VaultFileNames.vault,
                          meta: t.moveVault.unchanged(
                            from: state.from?.storageName ?? '',
                          ),
                          cipherPreview: kCipherPreview,
                          width: 300,
                        ),
                      ),
                      Text(
                        t.moveVault.notMovedTitle,
                        textAlign: TextAlign.center,
                        style: styles.appBarTitle().copyWith(
                          color: colors.foreground,
                        ),
                      ),
                      Text(
                        body,
                        textAlign: TextAlign.center,
                        style: styles.body().copyWith(
                          color: colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10.h,
              children: <Widget>[
                AppButton(
                  label: t.common.tryAgain,
                  icon: AppIconName.rotateCw,
                  onPressed: cubit.move,
                ),
                AppButton(
                  label: t.common.cancel,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
