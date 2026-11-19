import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// The list's title that opens the scope sheet (`.scope`, board C3):
/// "All Vaults ⌄" at the large-title size.
class AppScopeSwitcher extends StatelessWidget {
  const AppScopeSwitcher({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppPressable(
      onTap: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6.w,
        children: <Widget>[
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaler: AppTextStyles.largeStyleTextScaler(context),
              style: AppTextStyles(context)
                  .largeTitle()
                  .resized(
                    32,
                    line: 38,
                    weight: FontWeight.w800,
                    tracking: -0.02,
                  )
                  .copyWith(color: colors.foreground),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: AppIcon(
              AppIconName.chevronDown,
              size: 22,
              stroke: 2.5,
              color: colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
