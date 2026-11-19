import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';

/// "Continue with Google / Dropbox" (`.pv`): both providers at equal weight;
/// resting, busy ("Connecting to Google…") and disabled.
class AppProviderButton extends StatelessWidget {
  const AppProviderButton({
    required this.provider,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.onCard = false,
    super.key,
  });

  final AppProvider provider;
  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  /// On a card the button takes the background colour (`.pv.oc`).
  final bool onCard;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final OutlinedBorder shape = AppRadius.shape(context, AppRadius.xl);
    final List<BoxShadow> shadows = busy
        ? <BoxShadow>[
            BoxShadow(color: colors.primary15, spreadRadius: 4.r),
            BoxShadow(color: colors.primary, spreadRadius: 1.r),
          ]
        : <BoxShadow>[
            if (!onCard) ...context.shadows.shadowXs,
            BoxShadow(color: colors.hairline, spreadRadius: 1.r),
          ];

    return AppPressable(
      onTap: busy ? null : onPressed,
      enabled: onPressed != null,
      shape: shape,
      child: Container(
        height: 52.h,
        padding: EdgeInsets.only(left: 16.w, right: 14.w),
        decoration: ShapeDecoration(
          color: onCard ? colors.background : colors.card,
          shape: shape,
          shadows: shadows,
        ),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            SizedBox.square(
              dimension: 24.r,
              child: Center(
                child: busy
                    ? const AppSpinner(size: 20)
                    : AppProviderLogo(provider),
              ),
            ),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(
                  context,
                ).buttonLg().copyWith(color: colors.foreground),
              ),
            ),
            if (!busy)
              AppIcon(
                AppIconName.arrowRight,
                size: AppIconSizes.md,
                color: colors.mutedForeground,
              ),
          ],
        ),
      ),
    );
  }
}
