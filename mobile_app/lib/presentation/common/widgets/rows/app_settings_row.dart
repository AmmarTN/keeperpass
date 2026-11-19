import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_switch.dart';

/// A settings-style row (`.srw`, board C2 "Grouped lists"): 52 pt, an
/// optional 30 pt tile, the title (and a second line), and one trailing
/// control. Put them in an `AppInsetGroup` — inset `settings` with tiles,
/// `text` without.
class AppSettingsRow extends StatelessWidget {
  /// Value and chevron, an external link, a custom [trailing] control (the
  /// inline segmented Theme control), or nothing.
  const AppSettingsRow({
    required this.title,
    this.subtitle,
    this.leading,
    this.value,
    this.chevron = false,
    this.externalLink = false,
    this.onTap,
    this.monoTitle = false,
    this.accentTitle = false,
    this._trailing,
    super.key,
  }) : _radioSelected = null,
       _checked = null;

  /// A switch row; tapping the row toggles it too. Without [onChanged] it
  /// shows its value, dimmed (held by another setting).
  AppSettingsRow.toggle({
    required this.title,
    required bool value,
    required ValueChanged<bool>? onChanged,
    this.subtitle,
    this.leading,
    super.key,
  }) : value = null,
       chevron = false,
       monoTitle = false,
       accentTitle = false,
       externalLink = false,
       onTap = onChanged == null ? null : (() => onChanged(!value)),
       _trailing = AppSwitch(
         value: value,
         onChanged: onChanged,
         semanticLabel: title,
       ),
       _radioSelected = null,
       _checked = null;

  /// One of a list: the check mark on the chosen row ("After 10 minutes").
  const AppSettingsRow.choice({
    required this.title,
    required bool selected,
    required this.onTap,
    this.subtitle,
    super.key,
  }) : leading = null,
       value = null,
       chevron = false,
       monoTitle = false,
       accentTitle = false,
       externalLink = false,
       _trailing = null,
       _radioSelected = null,
       _checked = selected;

  /// A radio row: the dot leads ("My Vault · 19 items"), before an optional
  /// tile (the vault choices of Import, Export, Move vault).
  const AppSettingsRow.radio({
    required this.title,
    required bool selected,
    required this.onTap,
    this.subtitle,
    this.leading,
    super.key,
  }) : value = null,
       chevron = false,
       monoTitle = false,
       accentTitle = false,
       externalLink = false,
       _trailing = null,
       _radioSelected = selected,
       _checked = null;

  final String title;
  final String? subtitle;

  /// An [AppIconTile] at `AppTileSize.settings`.
  final Widget? leading;

  /// "After 10 minutes", "1.0.0".
  final String? value;
  final bool chevron;
  final bool externalLink;

  /// A file name as the title, in Space Mono 14 ("vault.json.enc", board
  /// `S5-24`).
  final bool monoTitle;

  /// A title in the accent colour, read as a link ("Technical details",
  /// board `S5-38`).
  final bool accentTitle;
  final VoidCallback? onTap;

  final Widget? _trailing;
  final bool? _radioSelected;
  final bool? _checked;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool oneOf = _radioSelected != null || _checked != null;

    final Widget row = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 52.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            if (_radioSelected != null) AppRadioDot(selected: _radioSelected),
            ?leading,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 1.h,
                  children: <Widget>[
                    Text(
                      title,
                      style:
                          (monoTitle
                                  ? styles.fileName().resized(
                                      14,
                                      line: 22,
                                      weight: FontWeight.w700,
                                    )
                                  : styles.bodyStrong().resized(16, line: 22))
                              .copyWith(
                                color: accentTitle
                                    ? colors.accentStrong
                                    : colors.foreground,
                              ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: styles.secondary().copyWith(
                          color: colors.mutedForeground,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (value != null || chevron || externalLink)
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4.w,
                children: <Widget>[
                  if (value != null)
                    Text(
                      value!,
                      style: styles
                          .body()
                          .resized(15, line: 20)
                          .copyWith(color: colors.mutedForeground),
                    ),
                  if (chevron)
                    AppIcon(
                      AppIconName.chevronRight,
                      size: 18,
                      stroke: 2,
                      color: colors.mutedForeground,
                    ),
                  if (externalLink)
                    AppIcon(
                      AppIconName.externalLink,
                      size: AppIconSizes.sm,
                      stroke: 2,
                      color: colors.mutedForeground,
                    ),
                ],
              ),
            ?_trailing,
            if (_checked == true)
              AppIcon(
                AppIconName.check,
                size: AppIconSizes.md,
                stroke: 2.5,
                color: colors.accentStrong,
              ),
          ],
        ),
      ),
    );

    return AppPressable(
      onTap: onTap,
      isButton: !oneOf,
      inMutuallyExclusiveGroup: oneOf,
      checked: oneOf ? (_radioSelected ?? _checked) : null,
      child: row,
    );
  }
}
