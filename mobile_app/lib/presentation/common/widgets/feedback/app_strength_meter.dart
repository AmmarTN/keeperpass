import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// The five strength steps (web `strength.*`).
enum AppStrength {
  veryWeak(0.2),
  weak(0.4),
  fair(0.6),
  strong(0.8),
  veryStrong(1);

  const AppStrength(this.fill);

  /// How much of the bar is filled.
  final double fill;

  String get label => switch (this) {
    AppStrength.veryWeak => t.strength.veryWeak,
    AppStrength.weak => t.strength.weak,
    AppStrength.fair => t.strength.fair,
    AppStrength.strong => t.strength.strong,
    AppStrength.veryStrong => t.strength.veryStrong,
  };

  /// Red only for Very weak and Weak (board C6).
  bool get isWeak => this == AppStrength.veryWeak || this == AppStrength.weak;
}

/// The strength meter: the large one under a secret field (`.meter`) and the
/// small one under a password in a list or field row (`.fmeter`). The fill
/// moves in 300 ms (board `Motion`); with no [strength] the track stays
/// empty and unlabelled (the Generator's "Nothing to generate.").
class AppStrengthMeter extends StatelessWidget {
  const AppStrengthMeter(this.strength, {super.key})
    : small = false,
      spaced = false;

  /// [spaced]: the 4 pt above it in a field row (`.fmeter`); the
  /// Generator's sits flush (`margin-top: 0`).
  const AppStrengthMeter.small(this.strength, {this.spaced = true, super.key})
    : small = true;

  final AppStrength? strength;
  final bool small;
  final bool spaced;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppStrength? strength = this.strength;
    final Color fill = switch (strength) {
      AppStrength.veryWeak || AppStrength.weak => colors.destructive,
      AppStrength.fair => colors.primary60,
      AppStrength.strong || AppStrength.veryStrong || null => colors.primary,
    };
    final Duration duration = AppMotion.reduceMotion(context)
        ? Duration.zero
        : AppMotion.slow;
    final Widget bar = ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 6.r,
        child: ColoredBox(
          color: colors.secondary,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: strength?.fill ?? 0),
            duration: duration,
            curve: AppMotion.easeOut,
            builder: (BuildContext context, double width, _) =>
                FractionallySizedBox(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: width,
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      color: fill,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
    if (strength == null) {
      return ExcludeSemantics(
        child: small ? SizedBox(width: 112.w, child: bar) : bar,
      );
    }

    final AppTextStyles styles = AppTextStyles(context);
    final Widget meter = small
        ? Padding(
            padding: EdgeInsets.only(top: spaced ? 4.h : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.w,
              children: <Widget>[
                SizedBox(width: 112.w, child: bar),
                Text(
                  strength.label,
                  style: styles
                      .secondary()
                      .resized(12, line: 16)
                      .copyWith(color: colors.mutedForeground),
                ),
              ],
            ),
          )
        : Row(
            spacing: 12.w,
            children: <Widget>[
              Expanded(child: bar),
              Text(
                strength.label,
                style: styles
                    .secondary()
                    .resized(13, line: 18, weight: FontWeight.w700)
                    .copyWith(
                      color: strength.isWeak
                          ? colors.destructiveStrong
                          : colors.foreground,
                    ),
              ),
            ],
          );

    return Semantics(
      label: t.strength.meter(level: strength.label),
      excludeSemantics: true,
      child: meter,
    );
  }
}
