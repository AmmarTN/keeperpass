import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';

/// "Oct 21, 2026, 6:54 PM", or "Today, 9:41 AM" for today (board `S3-19`),
/// in the phone's time.
String versionDate(DateTime moment, DateTime now, String locale) {
  final DateTime local = moment.toLocal();
  final DateTime today = now.toLocal();
  final bool isToday =
      local.year == today.year &&
      local.month == today.month &&
      local.day == today.day;
  return isToday
      ? t.itemDetail.todayAt(time: formatShortTime(local, locale))
      : formatDateTime(local, locale);
}

/// "Oct 21, 2026, 6:54 PM · 8 days ago" — the web's date and how long ago
/// (your answer, Part 8: no second line).
String versionLine(
  DateTime moment, {
  required DateTime now,
  required String locale,
  required RelativeTimeFormatter? relativeTime,
}) {
  final String date = versionDate(moment, now, locale);
  if (relativeTime == null) return date;
  return '$date · ${relativeTime.format(moment, now: now, locale: locale)}';
}

/// History (board `S3-19`): the current version, then each earlier one,
/// newest first; an earlier one opens on its own screen. Shown only once
/// the item has an earlier version (the boards draw none without).
class ItemHistorySection extends StatelessWidget {
  const ItemHistorySection({
    required this.item,
    required this.now,
    required this.relativeTime,
    required this.onOpen,
    super.key,
  });

  final VaultItem item;
  final DateTime now;
  final RelativeTimeFormatter? relativeTime;

  /// Opens the earlier version at this position.
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final String locale = LocaleSettings.currentLocale.languageCode;
    String line(DateTime moment) => versionLine(
      moment,
      now: now,
      locale: locale,
      relativeTime: relativeTime,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppSectionLabel(t.itemDetail.history, icon: AppIconName.rotateCcwClock),
        AppInsetGroup(
          children: <Widget>[
            _HistoryRow(
              line: line(item.updated),
              trailing: AppPill.badge(t.itemDetail.currentVersion),
            ),
            for (int i = 0; i < item.history.length; i++)
              _HistoryRow(
                line: line(item.history[i].updated),
                onTap: () => onOpen(i),
              ),
          ],
        ),
      ],
    );
  }
}

/// `.hrow`: when, then the badge or a chevron.
class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.line, this.trailing, this.onTap});

  final String line;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Widget row = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 58.h),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 10.w, 8.h),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            Expanded(
              child: Text(
                line,
                style: AppTextStyles(context)
                    .rowTitle()
                    .resized(15, line: 20, weight: FontWeight.w700)
                    .copyWith(color: colors.foreground),
              ),
            ),
            trailing ??
                AppIcon(
                  AppIconName.chevronRight,
                  size: 18,
                  stroke: 2,
                  color: colors.mutedForeground,
                ),
          ],
        ),
      ),
    );
    if (onTap == null) return row;
    return AppPressable(onTap: onTap, child: row);
  }
}
