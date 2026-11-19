import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// The round tick (`.cki`, and the selection circle of item rows): filled
/// with a check when on, a muted ring when off.
class AppCheckCircle extends StatelessWidget {
  const AppCheckCircle({
    required this.checked,
    this.ringWidth = 1.5,
    super.key,
  });

  final bool checked;
  final double ringWidth;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Container(
      width: 24.r,
      height: 24.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: checked ? colors.primary : null,
        border: checked
            ? null
            : Border.all(color: colors.mutedForeground, width: ringWidth.r),
      ),
      child: checked
          ? AppIcon(
              AppIconName.check,
              size: AppIconSizes.xs,
              stroke: 3,
              color: colors.primaryForeground,
            )
          : null,
    );
  }
}

/// The radio dot (`.rad`): a 2 pt ring, accent with a dot when chosen.
class AppRadioDot extends StatelessWidget {
  const AppRadioDot({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Container(
      width: 22.r,
      height: 22.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? colors.primary : colors.mutedForeground,
          width: 2.r,
        ),
      ),
      child: selected
          ? Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}

/// An acknowledgement (`.ack`): the round tick and a sentence.
class AppCheckRow extends StatelessWidget {
  const AppCheckRow({
    required this.label,
    required this.checked,
    required this.onChanged,
    super.key,
  });

  final String label;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      checked: checked,
      onTap: () => onChanged(!checked),
      isButton: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 44.h),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            AppCheckCircle(checked: checked),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles(context)
                    .bodyStrong()
                    .resized(15, line: 20)
                    .copyWith(color: context.colors.foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A character-kind tile (`.ctile`): a square check and a Space Mono sample.
class AppCheckTile extends StatelessWidget {
  const AppCheckTile({
    required this.label,
    required this.checked,
    required this.onChanged,
    this.semanticLabel,
    super.key,
  });

  /// "a–z", "?()/%…".
  final String label;
  final bool checked;
  final ValueChanged<bool> onChanged;

  /// What a screen reader says instead of the sample ("Lowercase letters").
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
      side: BorderSide(
        color: checked ? colors.primary60 : colors.hairline,
        width: (checked ? 1.5 : 1).r,
      ),
    );
    return AppPressable(
      checked: checked,
      semanticLabel: semanticLabel,
      onTap: () => onChanged(!checked),
      isButton: false,
      shape: shape,
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: ShapeDecoration(
          color: checked ? colors.primary10 : null,
          shape: shape,
        ),
        child: Row(
          spacing: 10.w,
          children: <Widget>[
            Container(
              width: 20.r,
              height: 20.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: checked ? colors.primary : null,
                borderRadius: BorderRadius.circular(6.r),
                border: checked
                    ? null
                    : Border.all(color: colors.mutedForeground, width: 2.r),
              ),
              child: checked
                  ? AppIcon(
                      AppIconName.check,
                      size: AppIconSizes.xs,
                      stroke: 3,
                      color: colors.primaryForeground,
                    )
                  : null,
            ),
            Flexible(
              child: Text(
                label,
                style: AppTextStyles(context)
                    .code()
                    .resized(14, line: 20, tracking: 0)
                    .copyWith(color: colors.foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The "Secret" toggle chip (`.stg`): a setting that reads as one — locked
/// when on, unlocked when off.
class AppToggleChip extends StatelessWidget {
  const AppToggleChip({
    required this.value,
    required this.onChanged,
    required this.fieldName,
    super.key,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  /// For the spoken label "Secret: Password".
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color foreground = value
        ? colors.accentStrong
        : colors.mutedForeground;
    return AppPressable(
      toggled: value,
      semanticLabel: t.common.secretToggle(field: fieldName),
      onTap: () => onChanged(!value),
      isButton: false,
      shape: const StadiumBorder(),
      child: Container(
        height: 30.r,
        padding: EdgeInsets.only(left: 10.w, right: 11.w),
        decoration: ShapeDecoration(
          color: value ? colors.primary15 : colors.secondary,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6.w,
          children: <Widget>[
            FaGlyph(
              value ? FaGlyphs.lock : FaGlyphs.unlock,
              size: 11,
              color: foreground,
            ),
            Text(
              t.common.secretChip,
              style: AppTextStyles(context)
                  .fieldLabel()
                  .resized(12, line: 16, weight: FontWeight.w700)
                  .copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
