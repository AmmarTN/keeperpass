import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';

/// "Your Vault Changed" (board `Sync-states`; Dropbox only, D9): a newer
/// version was saved from another device. Load it before editing, or keep
/// reading and copying with editing paused. Once loaded, the toast says
/// which version is open.
Future<void> showVaultChangedSheet(BuildContext context) => showAppSheet<void>(
  context,
  builder: (BuildContext sheet) => const VaultChangedSheet(),
);

/// "9:37 AM" today, the date otherwise.
String _when(DateTime? at, DateTime now) {
  if (at == null) return '';
  final String locale = LocaleSettings.currentLocale.languageCode;
  final DateTime local = at.toLocal();
  final DateTime today = now.toLocal();
  final bool sameDay =
      local.year == today.year &&
      local.month == today.month &&
      local.day == today.day;
  return sameDay
      ? formatShortTime(local, locale)
      : formatMediumDate(local, locale);
}

class VaultChangedSheet extends StatelessWidget {
  const VaultChangedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final SyncCubit sync = context.read<SyncCubit>();
    final String storage =
        context.read<SessionCubit>().state.account?.provider.storageName ?? '';
    final DateTime now = sync.now();

    return BlocConsumer<SyncCubit, SyncState>(
      listenWhen: (SyncState a, SyncState b) =>
          a.status != b.status &&
          b.status.action == CubitAction.loadLatest &&
          b.status.statusType == CubitStatusType.success,
      listener: (BuildContext context, SyncState state) {
        final Object? savedAt = state.status.args?['savedAt'];
        AppToastHost.of(context).show(
          AppToastData(
            icon: AppIconName.cloudCheck,
            title: t.sync.upToDate,
            detail: savedAt is DateTime
                ? t.sync.loadedVersion(time: _when(savedAt, now))
                : null,
          ),
        );
        Navigator.of(context).pop();
      },
      builder: (BuildContext context, SyncState state) {
        final bool loading =
            state.status.action == CubitAction.loadLatest &&
            state.status.statusType == CubitStatusType.loading;
        final String? error =
            state.status.action == CubitAction.loadLatest &&
                state.status.statusType == CubitStatusType.failure
            ? state.status.errorMsg
            : null;

        Widget version(
          AppIconName icon,
          Color iconColor,
          String where,
          String when,
        ) => Container(
          constraints: BoxConstraints(minHeight: 48.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            spacing: 10.w,
            children: <Widget>[
              AppIcon(icon, size: 18, stroke: 1.75, color: iconColor),
              Expanded(
                child: Text(
                  where,
                  style: styles
                      .formLabel()
                      .resized(14, line: 20, weight: FontWeight.w700)
                      .copyWith(color: colors.foreground),
                ),
              ),
              Text(
                when,
                style: styles
                    .formLabel()
                    .resized(14, line: 20, weight: FontWeight.w400)
                    .copyWith(color: colors.mutedForeground),
              ),
            ],
          ),
        );

        return AppSheet(
          title: t.sync.changedTitle,
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14.h,
            children: <Widget>[
              Column(
                spacing: 10.h,
                children: <Widget>[
                  const AppIconTile(
                    AppTileIcon(AppIconName.cloudDownload),
                    size: AppTileSize.diagram,
                  ),
                  Text(
                    t.sync.changedBody,
                    textAlign: TextAlign.center,
                    style: styles.body().copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
              Semantics(
                container: true,
                label: t.sync.twoVersions,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: colors.hairline),
                  ),
                  child: Column(
                    children: <Widget>[
                      version(
                        AppIconName.smartphone,
                        colors.mutedForeground,
                        t.sync.onThisPhone,
                        t.sync.loadedAt(time: _when(state.openedAt, now)),
                      ),
                      Divider(height: 1, thickness: 1, color: colors.border),
                      version(
                        AppIconName.cloud,
                        colors.accentStrong,
                        t.sync.inStorage(storage: storage),
                        t.sync.savedNewer(
                          time: _when(state.newerVersion?.modifiedAt, now),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (error != null)
                AppBanner(
                  tone: AppBannerTone.error,
                  icon: AppIconName.cloudOff,
                  title: error,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10.h,
                children: <Widget>[
                  AppButton(
                    label: t.sync.loadLatest,
                    icon: AppIconName.cloudDownload,
                    busy: loading,
                    onPressed: sync.loadLatest,
                  ),
                  AppButton(
                    label: t.sync.notNow,
                    variant: AppButtonVariant.secondary,
                    onPressed: loading
                        ? null
                        : () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Text(
                t.sync.pausedNote,
                textAlign: TextAlign.center,
                style: styles.secondary().copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
