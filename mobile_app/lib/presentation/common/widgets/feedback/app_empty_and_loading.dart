import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';

/// An empty state (board C6): the tile with its halo, a title, one line, and
/// the action that fills it.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    super.key,
  });

  /// [AppTileGlyph] or [AppTileIcon].
  final AppTileContent icon;

  /// "No tags yet".
  final String title;

  /// "Tags are created from an item, or here."
  final String message;

  /// An `AppButton(expand: false)`.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return AppSurface(
      padding: EdgeInsets.fromLTRB(22.w, 28.h, 22.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: AppIconTile(icon, size: AppTileSize.empty),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: styles
                .title()
                .resized(18, line: 24, weight: FontWeight.w800, tracking: 0)
                .copyWith(color: colors.foreground),
          ),
          SizedBox(height: 6.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            ),
          ),
          if (action != null) ...<Widget>[SizedBox(height: 20.h), action!],
        ],
      ),
    );
  }
}

/// A skeleton block (`.skel`).
class AppSkeletonBlock extends StatelessWidget {
  const AppSkeletonBlock({
    required this.height,
    this.width,
    this.widthFactor,
    this.radius = 8,
    super.key,
  });

  final double height;
  final double? width;

  /// A share of the available width (the board's 46 %, 64 % …).
  final double? widthFactor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final Widget block = Container(
      width: width?.r,
      height: height.r,
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
    if (widthFactor == null) return block;
    return FractionallySizedBox(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: widthFactor,
      child: block,
    );
  }
}

/// Skeleton rows for a list's first load (board C6) — never for the vault,
/// which opens complete. The whole group pulses together (opacity 1 ↔ 0.5
/// over 1.5 s; still under reduce motion).
class AppSkeletonRows extends StatefulWidget {
  const AppSkeletonRows({this.rows = 3, this.semanticLabel, super.key});

  final int rows;

  /// "Loading".
  final String? semanticLabel;

  @override
  State<AppSkeletonRows> createState() => _AppSkeletonRowsState();
}

class _AppSkeletonRowsState extends State<AppSkeletonRows>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: AppMotion.skeletonPulse,
  );

  static const List<(double, double)> _widths = <(double, double)>[
    (0.46, 0.64),
    (0.38, 0.52),
    (0.54, 0.40),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduceMotion(context)) {
      _pulse.value = 0;
      _pulse.stop();
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel,
      child: ExcludeSemantics(
        child: RepaintBoundary(
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 1,
              end: AppMotion.skeletonMinOpacity,
            ).animate(_pulse),
            child: AppInsetGroup(
              dividerInset: AppDividerInset.item,
              children: <Widget>[
                for (int i = 0; i < widget.rows; i++)
                  SizedBox(
                    height: 68.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.w, right: 4.w),
                      child: Row(
                        spacing: 12.w,
                        children: <Widget>[
                          const AppSkeletonBlock(
                            width: 40,
                            height: 40,
                            radius: 12,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 6.h,
                              children: <Widget>[
                                AppSkeletonBlock(
                                  height: 14,
                                  widthFactor: _widths[i % 3].$1,
                                ),
                                AppSkeletonBlock(
                                  height: 11,
                                  widthFactor: _widths[i % 3].$2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
