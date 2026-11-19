import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// A quiet note under a field (`.warn`): a 16 pt icon and a muted line —
/// the weak-secret warning (red icon) or a reminder (muted icon). A warning,
/// never a block.
class AppInlineNote extends StatelessWidget {
  const AppInlineNote({
    required this.icon,
    required this.text,
    this.warning = false,
    super.key,
  });

  final AppIconName icon;
  final String text;

  /// Red icon (the weak-secret warning); muted otherwise.
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.w,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: AppIcon(
            icon,
            size: AppIconSizes.sm,
            stroke: 2,
            color: warning ? colors.destructiveStrong : colors.mutedForeground,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles(context)
                .secondary()
                .resized(13, line: 19)
                .copyWith(color: colors.mutedForeground),
          ),
        ),
      ],
    );
  }
}
