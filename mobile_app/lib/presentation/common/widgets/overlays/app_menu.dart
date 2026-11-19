import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';

/// One item of an [AppMenu].
@immutable
class AppMenuItem<T> {
  const AppMenuItem({
    required this.value,
    required this.label,
    this.icon,
    this.destructive = false,
  });

  final T value;
  final String label;

  /// Shown at the end of action items ("Move to vault…" with its folder).
  final AppIconName? icon;

  /// Red, with its icon ("Delete item").
  final bool destructive;
}

/// Shows a card menu (board C5) next to the widget that owns [anchorContext]:
/// it replaces the iOS pull-down and the Material dropdown. With [selected]
/// it is a one-of menu with checks ("Sort", "Language").
Future<T?> showAppMenu<T>(
  BuildContext anchorContext, {
  required List<AppMenuItem<T>> items,
  String? heading,
  T? selected,
  double? width,
}) {
  final RenderBox anchor = anchorContext.findRenderObject()! as RenderBox;
  final Rect anchorRect = anchor.localToGlobal(Offset.zero) & anchor.size;
  final bool reduceMotion = AppMotion.reduceMotion(anchorContext);
  // Keep the caller's theme inside the menu route.
  final CapturedThemes themes = InheritedTheme.capture(
    from: anchorContext,
    to: Navigator.of(anchorContext).context,
  );
  return showGeneralDialog<T>(
    context: anchorContext,
    barrierDismissible: true,
    barrierLabel: heading ?? '',
    barrierColor: Colors.transparent,
    transitionDuration: reduceMotion ? Duration.zero : AppMotion.fast,
    pageBuilder: (BuildContext menuContext, _, _) => themes.wrap(
      CustomSingleChildLayout(
        delegate: _MenuLayout(anchorRect, MediaQuery.paddingOf(menuContext)),
        child: AppMenu<T>(
          items: items,
          heading: heading,
          selected: selected,
          width: width,
          onSelected: (T value) => Navigator.of(menuContext).pop(value),
        ),
      ),
    ),
    transitionBuilder:
        (BuildContext context, Animation<double> animation, _, Widget child) {
          final CurvedAnimation curved = CurvedAnimation(
            parent: animation,
            curve: AppMotion.easeOut,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              alignment: Alignment.topCenter,
              scale: Tween<double>(
                begin: AppMotion.dialogStartScale,
                end: 1,
              ).animate(curved),
              child: child,
            ),
          );
        },
  );
}

/// Places the menu under its anchor (above it when there is no room), inside
/// the screen's margins.
class _MenuLayout extends SingleChildLayoutDelegate {
  _MenuLayout(this.anchor, this.padding);

  final Rect anchor;
  final EdgeInsets padding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final double margin = 16.w;
    final double gap = 6.h;
    final double left = anchor.left.clamp(
      margin,
      size.width - childSize.width - margin,
    );
    final double below = anchor.bottom + gap;
    final double top = below + childSize.height <= size.height - padding.bottom
        ? below
        : (anchor.top - gap - childSize.height).clamp(padding.top, size.height);
    return Offset(left, top);
  }

  @override
  bool shouldRelayout(_MenuLayout old) =>
      old.anchor != anchor || old.padding != padding;
}

/// The menu card (`.pop`): an optional heading, then items — radio items with
/// a check, action items with their icon, destructive in red.
class AppMenu<T> extends StatelessWidget {
  const AppMenu({
    required this.items,
    required this.onSelected,
    this.heading,
    this.selected,
    this.width,
    super.key,
  });

  final List<AppMenuItem<T>> items;
  final ValueChanged<T> onSelected;

  /// "Sort by last update".
  final String? heading;
  final T? selected;

  /// 212 pt at least.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Material(
      type: MaterialType.transparency,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 212.w,
          maxWidth: (width ?? 280).w,
        ),
        child: IntrinsicWidth(
          child: AppSurface(
            radius: 14,
            elevation: AppElevation.floating,
            padding: EdgeInsets.all(6.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (heading != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 4.h),
                    child: Text(
                      heading!,
                      style: styles.badge().copyWith(
                        color: colors.mutedForeground,
                      ),
                    ),
                  ),
                for (final AppMenuItem<T> item in items) _item(context, item),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(BuildContext context, AppMenuItem<T> item) {
    final AppColors colors = context.colors;
    final bool isSelected = selected != null && item.value == selected;
    final Color color = item.destructive
        ? colors.destructiveStrong
        : isSelected
        ? colors.accentStrong
        : colors.foreground;
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9.r),
    );

    return AppPressable(
      inMutuallyExclusiveGroup: selected != null,
      checked: selected == null ? null : isSelected,
      onTap: () => onSelected(item.value),
      shape: shape,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: isSelected
            ? ShapeDecoration(color: colors.primary10, shape: shape)
            : null,
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            Expanded(
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(
                  context,
                ).bodyStrong().copyWith(color: color),
              ),
            ),
            if (isSelected)
              AppIcon(AppIconName.check, size: 18, stroke: 2.5, color: color)
            else if (item.icon != null)
              AppIcon(item.icon!, size: AppIconSizes.md, color: color),
          ],
        ),
      ),
    );
  }
}
