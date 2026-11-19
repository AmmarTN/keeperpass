import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// The fill behind a swipe action (board C2 "Swipe").
enum AppSwipeTone {
  /// The accent fill (Password).
  primary,

  /// The accent tint (Username).
  accent,

  /// Neutral (More).
  neutral,

  /// The red tint (Delete: My Vaults, Tags).
  destructive,
}

/// One action behind a swiped row.
@immutable
class AppSwipeAction {
  const AppSwipeAction({
    required this.icon,
    required this.label,
    required this.semanticLabel,
    required this.onPressed,
    this.tone,
  });

  final AppIconName icon;

  /// "Password".
  final String label;

  /// "Copy password".
  final String semanticLabel;
  final VoidCallback onPressed;

  /// Null: by position — accent fill, accent tint, neutral.
  final AppSwipeTone? tone;
}

/// Swipe a row left for its actions (board C2 "Swipe": Password, Username,
/// More); a full swipe runs the first one when [fullSwipe] allows it. Each
/// action is 72 pt wide. With a [leadingAction], swiping right past it runs
/// it (the Vault list: favorite).
class AppSwipeActions extends StatefulWidget {
  const AppSwipeActions({
    required this.child,
    required this.actions,
    this.fullSwipe = true,
    this.leadingAction,
    this.actionWidth = 72,
    super.key,
  }) : assert(actions.length >= 1 && actions.length <= 3);

  final Widget child;
  final List<AppSwipeAction> actions;
  final bool fullSwipe;
  final AppSwipeAction? leadingAction;

  /// Each trailing action's width: 72 pt (board C2), 76 on My Vaults
  /// (board `S5-02`).
  final double actionWidth;

  @override
  State<AppSwipeActions> createState() => _AppSwipeActionsState();
}

class _AppSwipeActionsState extends State<AppSwipeActions>
    with SingleTickerProviderStateMixin {
  /// Above 0: swiped left, as a share of the width; below 0: swiped right.
  late final AnimationController _offset = AnimationController(
    vsync: this,
    lowerBound: -1,
    value: 0,
  );
  double _width = 0;

  double get _actionsWidth => widget.actionWidth.w * widget.actions.length;

  @override
  void dispose() {
    _offset.dispose();
    super.dispose();
  }

  void _settle(double to) {
    final Duration duration = AppMotion.reduceMotion(context)
        ? Duration.zero
        : AppMotion.base;
    _offset.animateTo(to, duration: duration, curve: AppMotion.easeOut);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_width == 0) return;
    _offset.value = (_offset.value - details.primaryDelta! / _width).clamp(
      widget.leadingAction == null ? 0 : -1,
      1,
    );
  }

  void _onDragEnd(DragEndDetails details) {
    final double open = _actionsWidth / _width;
    final double velocity = details.primaryVelocity ?? 0;
    if (_offset.value < 0) {
      // Swiped right: past the leading action, it runs.
      if (-_offset.value * _width > 72.w) widget.leadingAction!.onPressed();
      _settle(0);
    } else if (widget.fullSwipe && _offset.value > 0.75) {
      // A full swipe runs the first action, then the row closes.
      widget.actions.first.onPressed();
      _settle(0);
    } else if (_offset.value > open / 2 || velocity < -600) {
      _settle(open);
    } else {
      _settle(0);
    }
  }

  void _run(AppSwipeAction action) {
    action.onPressed();
    _settle(0);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    (Color, Color) fill(AppSwipeTone tone) => switch (tone) {
      AppSwipeTone.primary => (colors.primary, colors.primaryForeground),
      AppSwipeTone.accent => (colors.accent, colors.foreground),
      AppSwipeTone.neutral => (colors.secondary, colors.foreground),
      AppSwipeTone.destructive => (
        colors.destructiveTint,
        colors.destructiveStrong,
      ),
    };

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _width = constraints.maxWidth;
        return GestureDetector(
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: AnimatedBuilder(
            animation: _offset,
            child: widget.child,
            builder: (BuildContext context, Widget? child) {
              final double dx = _offset.value * _width;
              return Stack(
                children: <Widget>[
                  if (dx > 0)
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          for (int i = 0; i < widget.actions.length; i++)
                            _ActionButton(
                              action: widget.actions[i],
                              fill: fill(
                                widget.actions[i].tone ??
                                    AppSwipeTone.values[i],
                              ),
                              onPressed: () => _run(widget.actions[i]),
                              width: widget.actionWidth.w,
                            ),
                        ],
                      ),
                    ),
                  if (dx < 0)
                    Positioned.fill(
                      child: Row(
                        children: <Widget>[
                          _ActionButton(
                            action: widget.leadingAction!,
                            fill: fill(
                              widget.leadingAction!.tone ??
                                  AppSwipeTone.primary,
                            ),
                            width: -dx,
                            onPressed: () => _run(widget.leadingAction!),
                          ),
                        ],
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(-dx, 0),
                    // The row always spans the full width, so all of it
                    // takes the swipe.
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: dx != 0
                            ? const <BoxShadow>[AppFixedColors.swipeEdgeShadow]
                            : null,
                      ),
                      child: SizedBox(width: _width, child: child),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.action,
    required this.fill,
    required this.onPressed,
    this.width,
  });

  final AppSwipeAction action;

  /// Background and foreground.
  final (Color, Color) fill;
  final VoidCallback onPressed;

  /// The leading action follows the finger; trailing ones are 72 pt.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground) = fill;
    return AppPressable(
      onTap: onPressed,
      semanticLabel: action.semanticLabel,
      child: ColoredBox(
        color: background,
        child: SizedBox(
          width: width ?? 72.w,
          // The leading action uncovers its 72 pt content from the left.
          child: ClipRect(
            child: OverflowBox(
              alignment: Alignment.centerLeft,
              minWidth: 72.w,
              maxWidth: 72.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.h,
                children: <Widget>[
                  AppIcon(
                    action.icon,
                    size: AppIconSizes.md,
                    stroke: 2,
                    color: foreground,
                  ),
                  Text(
                    action.label,
                    style: AppTextStyles(context)
                        .badge()
                        .resized(12, line: 16, weight: FontWeight.w700)
                        .copyWith(color: foreground),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
