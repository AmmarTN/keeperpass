import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// One option of an [AppSegmentedControl].
@immutable
class AppSegment<T> {
  const AppSegment(this.value, this.label);

  final T value;
  final String label;
}

/// The segmented control (board C3): two to four options; the chosen one
/// lifts onto the card colour. [inline] is the small version for a row
/// (Theme: Auto · Light · Dark).
class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.inline = false,
    this.fontSize,
    this.semanticLabel,
    super.key,
  }) : assert(segments.length >= 2 && segments.length <= 4);

  final List<AppSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool inline;

  /// 15 pt by default (13 inline, and for four long options).
  final double? fontSize;

  /// "Mode", "Word separator", "Theme".
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double pad = (inline ? 3 : 4).r;
    final double gap = (inline ? 2 : 4).r;
    final double itemHeight = (inline ? 30 : 36).h;
    final double thumbRadius = (inline ? 8 : 9).r;
    final int index = segments.indexWhere(
      (AppSegment<T> s) => s.value == selected,
    );
    final Duration duration = AppMotion.reduceMotion(context)
        ? Duration.zero
        : AppMotion.base;
    final TextStyle text = AppTextStyles(context).button().resized(
      fontSize ?? (inline ? 13 : 15),
      line: 20,
      weight: FontWeight.w700,
    );

    final Widget control = Container(
      width: inline ? 176.w : null,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular((inline ? 10 : 12).r),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double itemWidth =
              (constraints.maxWidth - gap * (segments.length - 1)) /
              segments.length;
          return SizedBox(
            height: itemHeight,
            child: Stack(
              children: <Widget>[
                if (index >= 0)
                  AnimatedPositioned(
                    duration: duration,
                    curve: AppMotion.easeOut,
                    left: index * (itemWidth + gap),
                    top: 0,
                    bottom: 0,
                    width: itemWidth,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.card,
                        borderRadius: BorderRadius.circular(thumbRadius),
                        boxShadow: <BoxShadow>[
                          ...context.shadows.shadowXs,
                          BoxShadow(color: colors.hairline, spreadRadius: 1.r),
                        ],
                      ),
                    ),
                  ),
                Row(
                  spacing: gap,
                  children: <Widget>[
                    for (int i = 0; i < segments.length; i++)
                      Expanded(
                        child: Semantics(
                          inMutuallyExclusiveGroup: true,
                          checked: i == index,
                          button: true,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (i == index) return;
                              AppHaptics.selection();
                              onChanged(segments[i].value);
                            },
                            child: Center(
                              child: Text(
                                segments[i].label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: text.copyWith(
                                  color: i == index
                                      ? colors.foreground
                                      : colors.mutedForeground,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return Semantics(label: semanticLabel, container: true, child: control);
  }
}
