import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/features/security/widgets/security_texts.dart';

/// The ⓘ on a finding card (board `S4-14`): why it matters — the web's
/// description (your answer, Part 11) — and how to fix it in three steps,
/// with "Show all" when something is flagged. True when Show all was tapped.
Future<bool> showWhyItMatters(
  BuildContext context, {
  required AuditType type,
  required int count,
}) async =>
    await showAppSheet<bool>(
      context,
      builder: (BuildContext sheet) => _WhyItMattersSheet(type, count),
    ) ??
    false;

class _WhyItMattersSheet extends StatelessWidget {
  const _WhyItMattersSheet(this.type, this.count);

  final AuditType type;
  final int count;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final List<String> steps = fixSteps(type);
    final Widget divider = SizedBox(
      height: 1,
      child: ColoredBox(color: colors.border),
    );
    return AppSheet(
      title: auditLabel(type),
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.h,
          children: <Widget>[
            Row(
              spacing: 12.w,
              children: <Widget>[
                AppIconTile(
                  AppTileIcon(auditIcon(type)),
                  size: AppTileSize.item,
                  tone: count > 0
                      ? AppTileTone.destructive
                      : AppTileTone.accent,
                ),
                Expanded(
                  child: Text(
                    count > 0
                        ? t.report.flagged(n: count)
                        : t.report.nothingFound,
                    style: styles
                        .secondary()
                        .resized(13, line: 18, weight: FontWeight.w700)
                        .copyWith(color: colors.mutedForeground),
                  ),
                ),
              ],
            ),
            Text(
              auditDescription(type),
              style: styles.body().copyWith(color: colors.foreground),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8.h,
              children: <Widget>[
                Semantics(
                  header: true,
                  child: Text(
                    t.report.howToFix.toUpperCase(),
                    style: styles.sectionLabel().copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: ShapeDecoration(
                    color: colors.background,
                    shape: AppRadius.shape(context, AppRadius.xxl),
                  ),
                  child: Column(
                    children: <Widget>[
                      for (int i = 0; i < steps.length; i++) ...<Widget>[
                        if (i > 0) divider,
                        _Step(number: i + 1, text: steps[i]),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (count > 0)
              AppButton(
                label: t.common.showAll(count: count),
                onPressed: () => Navigator.of(context).pop(true),
              ),
          ],
        ),
      ),
    );
  }
}

/// `.hstep`: a numbered step.
class _Step extends StatelessWidget {
  const _Step({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 44.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            Container(
              width: 24.r,
              height: 24.r,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: colors.primary15,
                shape: const StadiumBorder(),
              ),
              child: Text(
                '$number',
                style: styles
                    .badge()
                    .resized(12, line: 16, weight: FontWeight.w800)
                    .copyWith(color: colors.accentStrong),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: styles
                    .body()
                    .resized(15, line: 20)
                    .copyWith(color: colors.foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
