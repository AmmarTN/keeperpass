import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// The uppercase label above a group (`.sect` / `.sl` / `.slab`), with an
/// optional icon and an optional trailing control such as the sort button.
class AppSectionLabel extends StatelessWidget {
  const AppSectionLabel(
    this.label, {
    this.icon,
    this.trailing,
    this.margin,
    super.key,
  });

  final String label;
  final AppIconName? icon;
  final Widget? trailing;

  /// Defaults to the board's 18 pt above and 6 pt below.
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final Color muted = context.colors.mutedForeground;
    return Padding(
      padding: margin ?? EdgeInsets.only(top: 18.h, bottom: 6.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 32.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Semantics(
                  header: true,
                  child: Row(
                    spacing: 6.w,
                    children: <Widget>[
                      if (icon != null)
                        AppIcon(icon!, size: AppIconSizes.xs, color: muted),
                      Flexible(
                        child: Text(
                          label.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles(
                            context,
                          ).sectionLabel().copyWith(color: muted),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}

/// `.sortb` — the accent sort control at the end of a section label.
class AppSortButton extends StatelessWidget {
  const AppSortButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Color accent = context.colors.accentStrong;
    return AppPressable(
      onTap: onPressed,
      shape: const StadiumBorder(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: AppPressable.minTarget(context)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.w,
          children: <Widget>[
            AppIcon(
              AppIconName.arrowDownUp,
              size: AppIconSizes.xs,
              color: accent,
            ),
            Text(
              label,
              style: AppTextStyles(context)
                  .secondary()
                  .resized(13, line: 18, weight: FontWeight.w700)
                  .copyWith(color: accent),
            ),
          ],
        ),
      ),
    );
  }
}

/// `.sfoot` — the muted note under a group.
class AppFootnote extends StatelessWidget {
  const AppFootnote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 14.w, 0),
      child: Text(
        text,
        style: AppTextStyles(
          context,
        ).secondary().copyWith(color: context.colors.mutedForeground),
      ),
    );
  }
}
