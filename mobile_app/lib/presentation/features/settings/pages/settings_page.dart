import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/app_info.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/language/language_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/theme/theme_cubit.dart';
import 'package:keeperpass/presentation/common/routes/router.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_avatar.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_segmented_control.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:keeperpass/presentation/features/settings/pages/settings_flows.dart';
import 'package:keeperpass/presentation/features/settings/widgets/settings_texts.dart';

/// The Settings tab with its own cubit.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<SettingsCubit>(
    create: (_) => getIt<SettingsCubit>()..load(),
    child: const SettingsScreen(),
  );
}

/// One grouped list (boards `Settings`, `S5-13`): Account, Security,
/// Appearance, Storage, Data, Help and the danger zone last; every row says
/// its current value.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// "Log out?" (board `S5-14`): not destructive, so the accent.
  Future<void> _logOut(BuildContext context, ProviderAccount account) async {
    final SessionCubit session = context.read<SessionCubit>();
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.logOut,
      title: t.settings.logOutTitle,
      message: t.settings.logOutBody(
        storage: account.provider.storageName,
        provider: account.provider.displayName,
      ),
      confirmLabel: t.settings.logOut,
    );
    if (confirmed) await session.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final SettingsCubit cubit = context.read<SettingsCubit>();
    final SettingsState state = context.watch<SettingsCubit>().state;
    final ProviderAccount? account = context.select(
      (SessionCubit c) => c.state.account,
    );
    final AutoLockDelay autoLock = context.watch<LockCubit>().state;
    final ThemePreference theme = context.watch<ThemeCubit>().state;
    final LocaleLanguage language = context.watch<LanguageCubit>().state;
    final double bottom = MediaQuery.paddingOf(context).bottom;

    Widget tile(AppIconName icon, {AppTileTone tone = AppTileTone.accent}) =>
        AppIconTile(AppTileIcon(icon), size: AppTileSize.settings, tone: tone);

    return Scaffold(
      backgroundColor: colors.background,
      body: AppLargeTitleScrollView(
        title: t.settings.title,
        subtitle: t.settings.subtitle,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList.list(
              children: <Widget>[
                if (account != null) ...<Widget>[
                  AppSectionLabel(
                    t.settings.account,
                    icon: AppIconName.userRound,
                  ),
                  AppInsetGroup(
                    dividerInset: AppDividerInset.settings,
                    children: <Widget>[
                      _AccountRow(account: account),
                      AppSettingsRow(
                        leading: tile(
                          AppIconName.logOut,
                          tone: AppTileTone.neutral,
                        ),
                        title: t.settings.logOut,
                        onTap: () => _logOut(context, account),
                      ),
                    ],
                  ),
                  AppFootnote(t.settings.accountNote),
                ],
                AppSectionLabel(
                  t.settings.security,
                  icon: AppIconName.shieldCheck,
                ),
                AppInsetGroup(
                  dividerInset: AppDividerInset.settings,
                  children: <Widget>[
                    AppSettingsRow(
                      leading: tile(AppIconName.lockKeyhole),
                      title: t.settings.lockNow,
                      onTap: context.read<LockCubit>().lockNow,
                    ),
                    AppSettingsRow(
                      leading: tile(AppIconName.timer),
                      title: t.settings.autoLock,
                      value: autoLockValue(autoLock),
                      chevron: true,
                      onTap: () => openAutoLock(context),
                    ),
                    // Face ID comes with Part 16 (plan).
                    AppSettingsRow(
                      leading: tile(AppIconName.clipboardCheck),
                      title: t.settings.clearClipboard,
                      value: clipboardValue(state.clipboardDelay),
                      chevron: true,
                      onTap: () => openClearClipboard(context),
                    ),
                    AppSettingsRow.toggle(
                      leading: tile(AppIconName.eyeOff),
                      title: t.settings.hideInSwitcher,
                      subtitle: t.settings.hideInSwitcherBlocks,
                      value: state.hideInSwitcher,
                      onChanged: cubit.setHideInSwitcher,
                    ),
                    // Android only (board `Lock-privacy`); while hiding
                    // is on, screenshots are blocked anyway.
                    if (Theme.of(context).platform == TargetPlatform.android)
                      AppSettingsRow.toggle(
                        leading: tile(AppIconName.imageOff),
                        title: t.settings.blockScreenshots,
                        subtitle: state.hideInSwitcher
                            ? t.settings.blockScreenshotsWhileHidden
                            : t.settings.blockScreenshotsNote,
                        value: state.blockScreenshots || state.hideInSwitcher,
                        onChanged: state.hideInSwitcher
                            ? null
                            : cubit.setBlockScreenshots,
                      ),
                    AppSettingsRow(
                      leading: tile(AppIconName.keyRound),
                      title: t.settings.changeSecret,
                      chevron: true,
                      onTap: () => unawaited(openChangeSecret(context)),
                    ),
                  ],
                ),
                AppFootnote(t.settings.securityNote),
                AppSectionLabel(
                  t.settings.appearance,
                  icon: AppIconName.contrast,
                ),
                AppInsetGroup(
                  dividerInset: AppDividerInset.settings,
                  children: <Widget>[
                    AppSettingsRow(
                      leading: tile(AppIconName.contrast),
                      title: t.settings.theme,
                      trailing: AppSegmentedControl<ThemePreference>(
                        inline: true,
                        semanticLabel: t.settings.theme,
                        selected: theme,
                        onChanged: context.read<ThemeCubit>().setPreference,
                        segments: <AppSegment<ThemePreference>>[
                          AppSegment<ThemePreference>(
                            ThemePreference.auto,
                            t.settings.themeAuto,
                          ),
                          AppSegment<ThemePreference>(
                            ThemePreference.light,
                            t.settings.themeLight,
                          ),
                          AppSegment<ThemePreference>(
                            ThemePreference.dark,
                            t.settings.themeDark,
                          ),
                        ],
                      ),
                    ),
                    AppSettingsRow(
                      leading: tile(AppIconName.languages),
                      title: t.settings.language,
                      value: languageName(language),
                      chevron: true,
                      onTap: () => openLanguage(context),
                    ),
                  ],
                ),
                if (account != null) ...<Widget>[
                  AppSectionLabel(t.settings.storage, icon: AppIconName.cloud),
                  AppInsetGroup(
                    dividerInset: AppDividerInset.settings,
                    children: <Widget>[
                      AppSettingsRow(
                        leading: tile(AppIconName.cloud),
                        title: t.settings.whereItLives,
                        value: account.provider.storageName,
                        chevron: true,
                        onTap: () => openStorage(context),
                      ),
                      for (final ProviderId target in state.moveTargets)
                        AppSettingsRow(
                          leading: tile(AppIconName.arrowRightLeft),
                          title: t.settings.moveTo(storage: target.storageName),
                          chevron: true,
                          onTap: () =>
                              unawaited(openMoveVault(context, target)),
                        ),
                    ],
                  ),
                ],
                AppSectionLabel(t.settings.data, icon: AppIconName.fileText),
                AppInsetGroup(
                  dividerInset: AppDividerInset.settings,
                  children: <Widget>[
                    AppSettingsRow(
                      leading: tile(AppIconName.download),
                      title: t.settings.importCsv,
                      chevron: true,
                      onTap: () => unawaited(startImport(context)),
                    ),
                    AppSettingsRow(
                      leading: tile(AppIconName.share),
                      title: t.settings.exportCsv,
                      chevron: true,
                      onTap: () => openExport(context),
                    ),
                    AppSettingsRow(
                      leading: tile(AppIconName.rotateCcwClock),
                      title: t.settings.recentExports,
                      value: '${state.exports.length}',
                      chevron: true,
                      onTap: () => openRecentExports(context),
                    ),
                  ],
                ),
                AppSectionLabel(t.settings.help, icon: AppIconName.lifeBuoy),
                AppInsetGroup(
                  dividerInset: AppDividerInset.settings,
                  children: <Widget>[
                    AppSettingsRow(
                      leading: tile(AppIconName.lifeBuoy),
                      title: t.settings.howItWorks,
                      chevron: true,
                      onTap: () => openHowItWorks(context),
                    ),
                    AppSettingsRow(
                      leading: tile(AppIconName.circleQuestionMark),
                      title: t.settings.questions,
                      chevron: true,
                      onTap: () => openQuestions(context),
                    ),
                    AppSettingsRow(
                      leading: const AppAppIcon(size: 30),
                      title: t.settings.about,
                      value: AppInfo.version,
                      chevron: true,
                      onTap: () => openAbout(context),
                    ),
                  ],
                ),
                if (account != null) ...<Widget>[
                  AppSectionLabel(
                    t.settings.dangerZone,
                    icon: AppIconName.triangleAlert,
                  ),
                  AppInsetGroup(
                    dividerInset: AppDividerInset.settings,
                    children: <Widget>[
                      AppSettingsRow(
                        leading: tile(
                          AppIconName.archive,
                          tone: AppTileTone.destructive,
                        ),
                        title: t.settings.archive,
                        subtitle: t.settings.archiveNote,
                        chevron: true,
                        onTap: () => unawaited(openArchive(context)),
                      ),
                    ],
                  ),
                ],
                Padding(
                  padding: EdgeInsets.only(top: 22.h),
                  child: Text(
                    t.settings.footer(version: AppInfo.version),
                    textAlign: TextAlign.center,
                    style: AppTextStyles(
                      context,
                    ).secondary().copyWith(color: colors.mutedForeground),
                  ),
                ),
                // The design references, in debug builds only (Part 7).
                if (kDebugMode) ...<Widget>[
                  SizedBox(height: 16.h),
                  AppInsetGroup(
                    dividerInset: AppDividerInset.text,
                    children: <Widget>[
                      AppSettingsRow(
                        title: 'Design tokens',
                        chevron: true,
                        onTap: () =>
                            context.router.push(const DesignTokensRoute()),
                      ),
                      AppSettingsRow(
                        title: 'Components',
                        chevron: true,
                        onTap: () =>
                            context.router.push(const ComponentGalleryRoute()),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: bottom + 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The account (`.sr` with the 52 pt avatar): name, and the address with
/// where the vault lives.
class _AccountRow extends StatelessWidget {
  const _AccountRow({required this.account});

  final ProviderAccount account;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return MergeSemantics(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          spacing: 14.w,
          children: <Widget>[
            AppAvatar(
              initials: account.initials,
              provider: account.provider.logo,
              size: 52,
              badgeRing: colors.card,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 1.h,
                children: <Widget>[
                  Text(
                    account.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles
                        .rowTitle()
                        .resized(18, line: 24, weight: FontWeight.w800)
                        .copyWith(color: colors.foreground),
                  ),
                  Text(
                    t.settings.accountLine(
                      email: account.email,
                      storage: account.provider.storageName,
                    ),
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
    );
  }
}
