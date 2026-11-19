import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:keeperpass/presentation/features/settings/widgets/settings_texts.dart';

/// Where the vault lives, and what can reach it (board `S5-24`): the
/// phone-to-storage picture, the account and the file, Move, and each
/// storage's access page. [onMove] starts Move vault.
class StoragePage extends StatelessWidget {
  const StoragePage({required this.onMove, super.key});

  final void Function(ProviderId destination) onMove;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final SettingsCubit cubit = context.read<SettingsCubit>();
    final List<ProviderId> targets = context.select(
      (SettingsCubit c) => c.state.moveTargets,
    );
    final SessionCubit session = context.watch<SessionCubit>();
    final ProviderAccount? account = session.state.account;
    final DateTime? savedAt =
        context.select((SyncCubit c) => c.state.savedAt) ??
        session.state.vaultFile?.modifiedAt;
    final double bottom = MediaQuery.paddingOf(context).bottom;

    Widget logoTile(ProviderId provider) => AppIconTile(
      AppTileChild(AppProviderLogo(provider.logo, size: 16)),
      size: AppTileSize.settings,
      tone: AppTileTone.white,
    );

    return Scaffold(
      backgroundColor: colors.background,
      body: AppLargeTitleScrollView(
        title: t.storage.title,
        subtitle: t.storage.subtitle,
        leading: AppLinkButton.back(
          label: t.settings.title,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList.list(
              children: <Widget>[
                if (account != null) ...<Widget>[
                  SizedBox(height: 16.h),
                  _Diagram(provider: account.provider),
                  SizedBox(height: 12.h),
                  AppInsetGroup(
                    dividerInset: AppDividerInset.settings,
                    children: <Widget>[
                      AppSettingsRow(
                        leading: logoTile(account.provider),
                        title: account.provider.storageName,
                        subtitle: account.email,
                      ),
                      AppSettingsRow(
                        leading: const AppIconTile(
                          AppTileIcon(AppIconName.fileLock),
                          size: AppTileSize.settings,
                        ),
                        title: VaultFileNames.vault,
                        monoTitle: true,
                        subtitle: vaultFileLine(
                          account.provider.folderLabel,
                          savedAt,
                          cubit.now(),
                        ),
                      ),
                    ],
                  ),
                ],
                for (final ProviderId target in targets) ...<Widget>[
                  SizedBox(height: 14.h),
                  AppButton(
                    label: t.settings.moveTo(storage: target.storageName),
                    icon: AppIconName.arrowRightLeft,
                    variant: AppButtonVariant.secondary,
                    onPressed: () => onMove(target),
                  ),
                ],
                AppSectionLabel(
                  t.storage.access,
                  icon: AppIconName.shieldCheck,
                ),
                AppInsetGroup(
                  dividerInset: AppDividerInset.settings,
                  children: <Widget>[
                    for (final ProviderId provider
                        in session.availableProviders)
                      AppSettingsRow(
                        leading: logoTile(provider),
                        title: provider.accessLabel,
                        externalLink: true,
                        onTap: () =>
                            unawaited(cubit.openLink(provider.accessLink)),
                      ),
                  ],
                ),
                AppFootnote(t.storage.accessNote),
                SizedBox(height: bottom + 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "Encrypted on this phone, stored in your Google Drive": the phone, a
/// locked lane with "Encrypted file only", and the storage.
class _Diagram extends StatelessWidget {
  const _Diagram({required this.provider});

  final ProviderId provider;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final TextStyle label = styles
        .badge()
        .resized(12, line: 16, weight: FontWeight.w700)
        .copyWith(color: colors.foreground);

    Widget end(Widget tile, String name) => SizedBox(
      width: 96.w,
      child: Column(
        spacing: 6.h,
        children: <Widget>[
          tile,
          Text(name, textAlign: TextAlign.center, style: label),
        ],
      ),
    );

    Widget line(Color color) => Expanded(
      child: Container(
        height: 2.r,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );

    return AppSurface(
      padding: EdgeInsets.fromLTRB(12.w, 18.h, 12.w, 14.h),
      child: Semantics(
        image: true,
        label: t.storage.diagram(storage: provider.storageName),
        child: ExcludeSemantics(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.w,
            children: <Widget>[
              end(
                const AppIconTile(
                  AppTileIcon(AppIconName.smartphone),
                  size: AppTileSize.diagram,
                ),
                t.storage.thisPhone,
              ),
              Expanded(
                child: Padding(
                  // The lane runs through the tiles' middle.
                  padding: EdgeInsets.only(top: 10.r),
                  child: Column(
                    spacing: 6.h,
                    children: <Widget>[
                      Row(
                        spacing: 6.w,
                        children: <Widget>[
                          line(colors.primary),
                          Container(
                            width: 28.r,
                            height: 28.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colors.card,
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: colors.hairline,
                                  spreadRadius: 1.r,
                                ),
                              ],
                            ),
                            child: AppIcon(
                              AppIconName.lock,
                              size: 14,
                              stroke: 2.25,
                              color: colors.accentStrong,
                            ),
                          ),
                          line(colors.trackOff),
                        ],
                      ),
                      Text(
                        t.storage.encryptedOnly,
                        textAlign: TextAlign.center,
                        style: styles
                            .badge()
                            .resized(11, line: 14, weight: FontWeight.w700)
                            .copyWith(color: colors.mutedForeground),
                      ),
                    ],
                  ),
                ),
              ),
              end(
                AppIconTile(
                  AppTileChild(
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        AppIcon(
                          AppIconName.cloud,
                          size: 24,
                          stroke: 1.75,
                          color: colors.accentStrong,
                        ),
                        Positioned(
                          right: -7.r,
                          bottom: -5.r,
                          child: Container(
                            width: 16.r,
                            height: 16.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppFixedColors.tileWhite,
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: colors.primary15,
                                  spreadRadius: 1.5.r,
                                ),
                              ],
                            ),
                            child: AppProviderLogo(provider.logo, size: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  size: AppTileSize.diagram,
                ),
                provider.storageName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
