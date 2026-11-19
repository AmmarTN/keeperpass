import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// The line under a list (`.trust`, 18 pt above): a 15 pt accent icon and a
/// muted 13/18 sentence — what happens on the phone (Codes, Security) or a
/// hint (the Vault list filtered by a finding, board `S4-19`).
class AppTrustLine extends StatelessWidget {
  const AppTrustLine(
    this.text, {
    this.icon = AppIconName.lockKeyhole,
    super.key,
  });

  final String text;
  final AppIconName icon;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 18.h, 4.w, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.w,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: AppIcon(
              icon,
              size: 15,
              stroke: 2,
              color: colors.accentStrong,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles(context)
                  .secondary()
                  .resized(13, line: 18)
                  .copyWith(color: colors.mutedForeground),
            ),
          ),
        ],
      ),
    );
  }
}
