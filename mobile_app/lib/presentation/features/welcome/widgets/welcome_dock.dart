import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_provider_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_avatar.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';
import 'package:keeperpass/presentation/features/welcome/cubit/connect_cubit.dart';

/// Everything the dock needs to draw itself.
class WelcomeDockData {
  const WelcomeDockData({
    required this.connect,
    required this.providers,
    required this.offline,
    this.account,
    this.returning = false,
  });

  final ConnectState connect;

  /// The configured providers, Google first.
  final List<ProviderId> providers;
  final bool offline;

  /// The signed-in account (checking, found), or the one to greet.
  final ProviderAccount? account;

  /// An expired session: "Welcome back" with the last account.
  final bool returning;
}

/// The bottom dock (`.dock`, boards `U2-Launch`, `U2-Connect`): every action
/// within a thumb's reach, and every message in the tone it deserves while
/// the hero stays put. While checking it keeps its height, so the card never
/// moves.
class WelcomeDock extends StatelessWidget {
  const WelcomeDock({
    required this.data,
    required this.onSignIn,
    required this.onUseAnotherAccount,
    required this.onRetryCheck,
    super.key,
  });

  final WelcomeDockData data;
  final ValueChanged<ProviderId> onSignIn;
  final VoidCallback onUseAnotherAccount;
  final VoidCallback onRetryCheck;

  /// The dock's design height above the home indicator (351 − 34).
  static const double designHeight = 317;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double bottomInset = MediaQuery.paddingOf(context).bottom;
    final ConnectStage stage = data.connect.stage;
    final bool keepHeight =
        stage == ConnectStage.checking ||
        stage == ConnectStage.found ||
        stage == ConnectStage.checkFailed;

    return Container(
      constraints: BoxConstraints(
        minHeight: keepHeight ? designHeight.h + bottomInset : 0,
      ),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: context.shadows.dockShadow,
      ),
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h + bottomInset),
      child: switch (stage) {
        ConnectStage.checking || ConnectStage.found => _Status(
          account: data.account!,
          found: stage == ConnectStage.found,
          onUseAnotherAccount: onUseAnotherAccount,
        ),
        ConnectStage.checkFailed => _CheckFailed(
          account: data.account!,
          onRetry: onRetryCheck,
          onUseAnotherAccount: onUseAnotherAccount,
        ),
        _ =>
          data.returning && data.account != null
              ? _Returning(
                  data: data,
                  onSignIn: onSignIn,
                  onUseAnotherAccount: onUseAnotherAccount,
                )
              : _Providers(data: data, onSignIn: onSignIn),
      },
    );
  }
}

class _Providers extends StatelessWidget {
  const _Providers({required this.data, required this.onSignIn});

  final WelcomeDockData data;
  final ValueChanged<ProviderId> onSignIn;

  @override
  Widget build(BuildContext context) {
    final ConnectState connect = data.connect;
    final Widget? banner = data.offline
        ? AppBanner(
            tone: AppBannerTone.neutralOnCard,
            icon: AppIconName.wifiOff,
            title: t.common.offlineTitle,
            body: t.connect.offlineDetail,
          )
        : connect.signInFailure != null
        ? AppBanner(
            tone: AppBannerTone.error,
            icon: AppIconName.circleAlert,
            title: t.connect.signInFailed,
            body: connect.signInFailure!.getMessage(),
          )
        : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (banner != null) ...<Widget>[banner, SizedBox(height: 16.h)],
        ProviderButtons(
          providers: data.providers,
          busy: connect.signingIn,
          enabled: !data.offline && connect.stage == ConnectStage.idle,
          onSignIn: onSignIn,
        ),
        if (banner == null) ...<Widget>[SizedBox(height: 20.h), const _Facts()],
        SizedBox(height: 16.h),
        Text(
          t.welcome.footer,
          textAlign: TextAlign.center,
          style: AppTextStyles(context)
              .secondary()
              .resized(12, line: 17)
              .copyWith(color: context.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// Both providers at equal weight; the pressed one carries the spinner and
/// the others rest at 50 %.
class ProviderButtons extends StatelessWidget {
  const ProviderButtons({
    required this.providers,
    required this.busy,
    required this.enabled,
    required this.onSignIn,
    super.key,
  });

  final List<ProviderId> providers;
  final ProviderId? busy;
  final bool enabled;
  final ValueChanged<ProviderId> onSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12.h,
      children: <Widget>[
        for (final ProviderId provider in providers)
          AppProviderButton(
            provider: provider.logo,
            onCard: true,
            busy: busy == provider,
            label: busy == provider
                ? t.welcome.connecting(provider: provider.displayName)
                : provider.continueLabel,
            onPressed: enabled && busy == null
                ? () => onSignIn(provider)
                : null,
          ),
      ],
    );
  }
}

/// The three facts under the buttons (`.tl2`).
class _Facts extends StatelessWidget {
  const _Facts();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final TextStyle style = AppTextStyles(
      context,
    ).secondary().copyWith(color: colors.foreground);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: <Widget>[
        for (final (AppIconName icon, String text) in <(AppIconName, String)>[
          (AppIconName.cloudCheck, t.welcome.factAccess),
          (AppIconName.lockKeyhole, t.welcome.factEncrypted),
          (AppIconName.serverOff, t.welcome.factNoServer),
        ])
          Row(
            spacing: 10.w,
            children: <Widget>[
              AppIcon(
                icon,
                size: AppIconSizes.sm,
                stroke: 2,
                color: colors.accentStrong,
              ),
              Expanded(child: Text(text, style: style)),
            ],
          ),
      ],
    );
  }
}

/// The account at the top of the dock: avatar, name, address.
class AccountRow extends StatelessWidget {
  const AccountRow({required this.account, this.trailing, super.key});

  final ProviderAccount account;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Row(
      spacing: 12.w,
      children: <Widget>[
        AppAvatar(
          initials: account.initials,
          provider: account.provider.logo,
          badgeRing: colors.card,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                account.displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styles.rowTitle().copyWith(color: colors.foreground),
              ),
              if (account.name.isNotEmpty)
                Text(
                  account.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styles.secondary().copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({
    required this.account,
    required this.found,
    required this.onUseAnotherAccount,
  });

  final ProviderAccount account;
  final bool found;
  final VoidCallback onUseAnotherAccount;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String storage = account.provider.storageName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AccountRow(account: account),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: SizedBox(height: 1, child: ColoredBox(color: colors.hairline)),
        ),
        Semantics(
          liveRegion: true,
          child: Row(
            spacing: 12.w,
            children: <Widget>[
              if (found)
                AppIcon(
                  AppIconName.circleCheck,
                  size: 22,
                  stroke: 2,
                  color: colors.accentStrong,
                )
              else
                const AppSpinner(size: 22),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      found ? t.connect.foundTitle : t.connect.checkingTitle,
                      style: styles.rowTitle().copyWith(
                        color: colors.foreground,
                      ),
                    ),
                    Text(
                      found
                          ? t.connect.foundDetail
                          : t.connect.checkingDetail(storage: storage),
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
        SizedBox(height: 24.h),
        AppButton(
          label: t.common.useAnotherAccount,
          variant: AppButtonVariant.ghost,
          size: AppButtonSize.medium,
          onPressed: found ? null : onUseAnotherAccount,
        ),
      ],
    );
  }
}

class _CheckFailed extends StatelessWidget {
  const _CheckFailed({
    required this.account,
    required this.onRetry,
    required this.onUseAnotherAccount,
  });

  final ProviderAccount account;
  final VoidCallback onRetry;
  final VoidCallback onUseAnotherAccount;

  @override
  Widget build(BuildContext context) {
    final String storage = account.provider.storageName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppBanner(
          tone: AppBannerTone.error,
          icon: AppIconName.cloudOff,
          title: t.connect.checkFailedTitle,
          body: t.connect.checkFailedDetail(storage: storage),
        ),
        SizedBox(height: 16.h),
        AppButton(
          label: t.common.tryAgain,
          icon: AppIconName.rotateCw,
          onPressed: onRetry,
        ),
        SizedBox(height: 8.h),
        AppButton(
          label: t.common.useAnotherAccount,
          variant: AppButtonVariant.ghost,
          size: AppButtonSize.medium,
          onPressed: onUseAnotherAccount,
        ),
      ],
    );
  }
}

class _Returning extends StatelessWidget {
  const _Returning({
    required this.data,
    required this.onSignIn,
    required this.onUseAnotherAccount,
  });

  final WelcomeDockData data;
  final ValueChanged<ProviderId> onSignIn;
  final VoidCallback onUseAnotherAccount;

  @override
  Widget build(BuildContext context) {
    final ProviderAccount account = data.account!;
    final ProviderId? busy = data.connect.signingIn;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (data.offline) ...<Widget>[
          AppBanner(
            tone: AppBannerTone.neutralOnCard,
            icon: AppIconName.wifiOff,
            title: t.common.offlineTitle,
            body: t.connect.offlineDetail,
          ),
          SizedBox(height: 16.h),
        ],
        AccountRow(
          account: account,
          trailing: AppPill(
            label: t.connect.lastUsed,
            tone: AppPillTone.accent,
          ),
        ),
        SizedBox(height: 20.h),
        AppProviderButton(
          provider: account.provider.logo,
          onCard: true,
          busy: busy == account.provider,
          label: busy == account.provider
              ? t.welcome.connecting(provider: account.provider.displayName)
              : account.provider.continueLabel,
          onPressed: !data.offline && busy == null
              ? () => onSignIn(account.provider)
              : null,
        ),
        SizedBox(height: 8.h),
        AppButton(
          label: t.common.useAnotherAccount,
          variant: AppButtonVariant.ghost,
          size: AppButtonSize.medium,
          onPressed: busy == null ? onUseAnotherAccount : null,
        ),
      ],
    );
  }
}
