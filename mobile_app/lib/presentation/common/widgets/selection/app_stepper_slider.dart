import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// The slider with a stepper (board C3): drag for a rough value, − / + or type
/// for an exact one. While dragging the knob wears a soft halo; screen readers
/// hear the final value, not every step.
class AppStepperSlider extends StatefulWidget {
  const AppStepperSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.decreaseLabel,
    required this.increaseLabel,
    super.key,
  }) : assert(min < max);

  /// "Words".
  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  /// "Fewer words" / "More words".
  final String decreaseLabel;
  final String increaseLabel;

  @override
  State<AppStepperSlider> createState() => _AppStepperSliderState();
}

class _AppStepperSliderState extends State<AppStepperSlider> {
  late final TextEditingController _typed = TextEditingController(
    text: '${widget.value}',
  );
  bool _dragging = false;

  @override
  void didUpdateWidget(covariant AppStepperSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _typed.text != '${widget.value}') {
      _typed.text = '${widget.value}';
    }
  }

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  void _set(int value) {
    final int clamped = value.clamp(widget.min, widget.max);
    if (clamped == widget.value) return;
    AppHaptics.selection();
    widget.onChanged(clamped);
  }

  void _setFromPosition(double dx, double width) {
    final double fraction = (dx / width).clamp(0, 1);
    _set(widget.min + (fraction * (widget.max - widget.min)).round());
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final double fraction =
        (widget.value - widget.min) / (widget.max - widget.min);
    final TextStyle caption = styles
        .fieldLabel()
        .resized(12, line: 16, weight: FontWeight.w400)
        .copyWith(color: colors.mutedForeground);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.h,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 44.h),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.label,
                  style: styles
                      .button()
                      .resized(15, line: 20, weight: FontWeight.w700)
                      .copyWith(color: colors.foreground),
                ),
              ),
              _StepButton(
                icon: AppIconName.minus,
                label: widget.decreaseLabel,
                onPressed: widget.value > widget.min
                    ? () => _set(widget.value - 1)
                    : null,
              ),
              SizedBox(width: 4.w),
              Container(
                width: 48.w,
                height: 36.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.primary15,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  controller: _typed,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  cursorColor: colors.primary,
                  style: styles
                      .code()
                      .resized(16, line: 20, tracking: 0)
                      .copyWith(color: colors.accentStrong),
                  decoration: InputDecoration.collapsed(
                    hintText: null,
                  ).copyWith(isDense: true),
                  onSubmitted: (String text) =>
                      _set(int.tryParse(text) ?? widget.value),
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                    _set(int.tryParse(_typed.text) ?? widget.value);
                    _typed.text = '${widget.value}';
                  },
                ),
              ),
              SizedBox(width: 4.w),
              _StepButton(
                icon: AppIconName.plus,
                label: widget.increaseLabel,
                onPressed: widget.value < widget.max
                    ? () => _set(widget.value + 1)
                    : null,
              ),
            ],
          ),
        ),
        Semantics(
          slider: true,
          label: widget.label,
          value: '${widget.value}',
          increasedValue: '${(widget.value + 1).clamp(widget.min, widget.max)}',
          decreasedValue: '${(widget.value - 1).clamp(widget.min, widget.max)}',
          onIncrease: () => _set(widget.value + 1),
          onDecrease: () => _set(widget.value - 1),
          child: ExcludeSemantics(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double width = constraints.maxWidth;
                final double knob = 28.r;
                final double halo = 36.r;
                final double x = fraction * width;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (TapDownDetails d) =>
                      _setFromPosition(d.localPosition.dx, width),
                  onHorizontalDragStart: (DragStartDetails d) {
                    setState(() => _dragging = true);
                    _setFromPosition(d.localPosition.dx, width);
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails d) =>
                      _setFromPosition(d.localPosition.dx, width),
                  onHorizontalDragEnd: (_) => setState(() => _dragging = false),
                  onHorizontalDragCancel: () =>
                      setState(() => _dragging = false),
                  child: SizedBox(
                    height: 28.r,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Container(
                          height: 6.r,
                          decoration: ShapeDecoration(
                            color: colors.secondary,
                            shape: const StadiumBorder(),
                          ),
                        ),
                        Container(
                          width: x,
                          height: 6.r,
                          decoration: ShapeDecoration(
                            color: colors.primary,
                            shape: const StadiumBorder(),
                          ),
                        ),
                        if (_dragging)
                          Positioned(
                            left: x - halo / 2,
                            child: Container(
                              width: halo,
                              height: halo,
                              decoration: BoxDecoration(
                                color: colors.primary15,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        Positioned(
                          left: x - knob / 2,
                          child: Container(
                            width: knob,
                            height: knob,
                            decoration: BoxDecoration(
                              color: AppFixedColors.knob,
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                AppFixedColors.sliderThumbShadow,
                                BoxShadow(
                                  color: colors.hairline,
                                  spreadRadius: 1.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${widget.min}', style: caption),
            Text('${widget.max}', style: caption),
          ],
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final AppIconName icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    );
    return AppPressable(
      onTap: onPressed,
      enabled: onPressed != null,
      semanticLabel: label,
      shape: shape,
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: ShapeDecoration(color: colors.secondary, shape: shape),
        child: Center(
          child: AppIcon(
            icon,
            size: 18,
            stroke: 2.25,
            color: colors.foreground,
          ),
        ),
      ),
    );
  }
}
