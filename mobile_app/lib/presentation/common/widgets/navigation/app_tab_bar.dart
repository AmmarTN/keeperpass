import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// One tab of the [AppTabBar].
@immutable
class AppTab {
  const AppTab({
    required this.icon,
    required this.label,
    this.badgeCount = 0,
    this.semanticLabel,
  });

  final AppIconName icon;

  /// "Vault".
  final String label;

  /// Security's flagged-item count (0 hides the badge).
  final int badgeCount;

  /// "Security, 4 items flagged".
  final String? semanticLabel;
}

/// The tab bar (board C4): one bar for both platforms; the active tab sits on
/// a soft pill, a count badge rides on Security.
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<AppTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// The bar's height above the bottom safe area (for toasts and content).
  static double contentHeight() => 53.h;

  /// Android's button navigation (back, home, recents) is a solid band that
  /// hides what is under it; the gesture handle and the iPhone's home
  /// indicator are drawn over the app. Button navigation has no side
  /// gesture areas for "back".
  static bool _solidSystemBar(BuildContext context) {
    if (Theme.of(context).platform != TargetPlatform.android) return false;
    final EdgeInsets gestures = MediaQuery.systemGestureInsetsOf(context);
    return MediaQuery.paddingOf(context).bottom > 0 &&
        gestures.left == 0 &&
        gestures.right == 0;
  }

  /// The space under the tabs. The board's 84 pt bar is 7 + 46 pt of tabs
  /// over a 34 pt home indicator, the indicator overlapping the bar by 3 pt;
  /// above a solid Android navigation bar the tabs keep 8 pt to it instead.
  static double bottomPadding(BuildContext context) {
    final double inset = MediaQuery.paddingOf(context).bottom;
    if (_solidSystemBar(context)) return inset + 8.h;
    return math.max(inset - 3, 8.h);
  }

  /// How far the bar reaches above the bottom safe area (toasts sit on it).
  static double reachAboveInset(BuildContext context) =>
      contentHeight() +
      bottomPadding(context) -
      MediaQuery.paddingOf(context).bottom;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double bottom = bottomPadding(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.sidebar,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 7.h, bottom: bottom),
        child: Semantics(
          container: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < tabs.length; i++)
                Expanded(
                  child: _TabButton(
                    tab: tabs[i],
                    selected: i == selectedIndex,
                    onTap: () => onSelected(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final AppTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color color = selected ? colors.accentStrong : colors.mutedForeground;
    return Semantics(
      selected: selected,
      button: true,
      label: tab.semanticLabel ?? tab.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 3.h,
              children: <Widget>[
                Container(
                  width: 56.w,
                  height: 30.h,
                  alignment: Alignment.center,
                  decoration: selected
                      ? ShapeDecoration(
                          color: colors.primary15,
                          shape: const StadiumBorder(),
                        )
                      : null,
                  child: AppIcon(
                    tab.icon,
                    size: 22,
                    stroke: selected ? 2 : 1.75,
                    color: color,
                  ),
                ),
                Text(
                  tab.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // One bar for both platforms (board C4): 11 / 13 everywhere.
                  style: AppTextStyles(context)
                      .badge()
                      .resized(11, line: 13, weight: FontWeight.w700)
                      .copyWith(color: color),
                ),
              ],
            ),
            if (tab.badgeCount > 0)
              Positioned(
                top: -4.h,
                left: 0,
                right: 0,
                child: Align(
                  child: Transform.translate(
                    // `left: calc(50% + 10px)`: the badge starts 10 pt right of centre.
                    offset: Offset(10.w + 9.r, 0),
                    child: _Badge(count: tab.badgeCount),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    // No `alignment`: a Container with one fills the width it is given.
    return Container(
      height: 18.r,
      constraints: BoxConstraints(minWidth: 18.r),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: ShapeDecoration(
        color: colors.destructiveTint,
        shape: const StadiumBorder(),
        shadows: <BoxShadow>[
          BoxShadow(color: colors.sidebar, spreadRadius: 2.r),
        ],
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          '$count',
          style: AppTextStyles(context)
              .badge()
              .resized(11, line: 13, weight: FontWeight.w800)
              .copyWith(color: colors.destructiveStrong),
        ),
      ),
    );
  }
}
