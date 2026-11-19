import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';

/// One switch on both platforms (`.ios-sw`, board C3): 51 × 31, the accent
/// track when on, the white knob sliding over.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    this.semanticLabel,
    super.key,
  });

  final bool value;

  /// Null disables it (50 %).
  final ValueChanged<bool>? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Duration duration = AppMotion.reduceMotion(context)
        ? Duration.zero
        : AppMotion.base;
    final bool enabled = onChanged != null;

    final Widget track = AnimatedContainer(
      duration: duration,
      curve: AppMotion.easeOut,
      width: 51.r,
      height: 31.r,
      padding: EdgeInsets.all(2.r),
      decoration: ShapeDecoration(
        color: value ? colors.primary : colors.trackOff,
        shape: const StadiumBorder(),
      ),
      child: AnimatedAlign(
        duration: duration,
        curve: AppMotion.easeOut,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 27.r,
          height: 27.r,
          decoration: const BoxDecoration(
            color: AppFixedColors.knob,
            shape: BoxShape.circle,
            boxShadow: AppFixedColors.knobShadow,
          ),
        ),
      ),
    );

    return Semantics(
      toggled: value,
      enabled: enabled,
      label: semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? () => onChanged!(!value) : null,
        child: Opacity(opacity: enabled ? 1 : 0.5, child: track),
      ),
    );
  }
}
