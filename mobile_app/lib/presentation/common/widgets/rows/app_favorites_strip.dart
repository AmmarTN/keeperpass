import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';

/// A favourite card (`.favc`, board C2): 140 pt wide, its tile, name and one
/// line, with its own copy button in the corner.
class AppFavoriteCard extends StatelessWidget {
  const AppFavoriteCard({
    required this.tile,
    required this.name,
    required this.subtitle,
    required this.copyLabel,
    required this.onCopy,
    this.onTap,
    super.key,
  });

  final Widget tile;
  final String name;
  final String subtitle;
  final String copyLabel;
  final VoidCallback onCopy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return SizedBox(
      width: 140.w,
      child: Stack(
        children: <Widget>[
          // The card fills its 140 pt slot, so the copy button sits inside.
          SizedBox(
            width: double.infinity,
            child: AppPressable(
              onTap: onTap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: AppSurface(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.h,
                  children: <Widget>[
                    tile,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 1.h,
                      children: <Widget>[
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: styles
                              .rowTitle()
                              .resized(15, line: 20, weight: FontWeight.w800)
                              .copyWith(color: colors.foreground),
                        ),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: styles
                              .secondary()
                              .resized(12, line: 16)
                              .copyWith(color: colors.mutedForeground),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // `.cpb`: the 36 pt button sits 8 pt from the corner; its larger tap
          // target is centred on it.
          Positioned(
            right: 26.r - AppPressable.minTarget(context) / 2,
            top: 26.r - AppPressable.minTarget(context) / 2,
            child: AppCopyButton(
              semanticLabel: copyLabel,
              onCopy: onCopy,
              variant: AppCopyButtonVariant.favorite,
            ),
          ),
        ],
      ),
    );
  }
}

/// The favourites strip: cards side by side, scrolling sideways, bleeding to
/// the screen edges.
class AppFavoritesStrip extends StatelessWidget {
  const AppFavoritesStrip({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.w,
        children: children,
      ),
    );
  }
}
