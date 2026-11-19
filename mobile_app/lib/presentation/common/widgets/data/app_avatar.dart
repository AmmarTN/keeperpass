import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';

/// The account avatar (`.av`, board C7): initials on the accent, the storage
/// provider riding on the corner. 40, 56 and 64 pt.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.initials,
    this.provider,
    this.size = 40,
    this.badgeRing,
    super.key,
  });

  /// "JD".
  final String initials;
  final AppProvider? provider;
  final double size;

  /// The badge's 2 pt ring: the background by default, the card colour when
  /// the avatar sits on a card.
  final Color? badgeRing;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final (
      double radius,
      double font,
      double badge,
      double logo,
    ) = switch (size) {
      <= 40 => (10.0, 15.0, 20.0, 12.0),
      <= 56 => (14.0, 20.0, 20.0, 12.0),
      _ => (16.0, 23.0, 23.0, 14.0),
    };

    return SizedBox.square(
      dimension: size.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: size.r,
            height: size.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(radius.r),
            ),
            child: Text(
              initials,
              textScaler: TextScaler.noScaling,
              style: AppTextStyles(context)
                  .title()
                  .resized(
                    font,
                    line: font,
                    weight: FontWeight.w800,
                    tracking: 0,
                  )
                  .copyWith(color: colors.primaryForeground, fontSize: font.r),
            ),
          ),
          if (provider != null)
            Positioned(
              right: -5.r,
              bottom: -5.r,
              child: Container(
                width: badge.r,
                height: badge.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppFixedColors.tileWhite,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: badgeRing ?? colors.background,
                      spreadRadius: 2.r,
                    ),
                  ],
                ),
                child: AppProviderLogo(provider!, size: logo),
              ),
            ),
        ],
      ),
    );
  }
}
