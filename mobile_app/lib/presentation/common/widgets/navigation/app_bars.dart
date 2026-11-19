import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';

/// The compact bar (board C4): leading action, a centred 17 pt title, and a
/// trailing action — for pickers, deeper pages (Back), modals (Cancel /
/// Save), edit (Save waits for changes) and selection (Cancel · "3
/// selected" · Select All). Put `AppLinkButton.back` / `.bar` in the slots.
class AppCompactBar extends StatelessWidget {
  const AppCompactBar({
    this.title,
    this.leading,
    this.trailing,
    this.slotWidth = 112,
    this.titleOpacity = 1,
    super.key,
  });

  final String? title;
  final Widget? leading;
  final Widget? trailing;

  /// Width of each side slot (112 pt; 96–100 in edit and selection bars).
  final double slotWidth;

  /// Lets a large title fade into the bar on scroll.
  final double titleOpacity;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return SizedBox(
      height: 52.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: slotWidth.w,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: leading,
              ),
            ),
            Expanded(
              child: title == null
                  ? const SizedBox.shrink()
                  : Opacity(
                      opacity: titleOpacity,
                      child: Semantics(
                        header: true,
                        child: Text(
                          title!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles(
                            context,
                          ).navTitle().copyWith(color: colors.foreground),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              width: slotWidth.w,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: trailing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A screen with a large title (board C4: tabs and list screens): a 44 pt
/// action row, the 32 pt title and an optional subtitle; as the title scrolls
/// away it moves into the bar (decision 2026-10-30), and a hairline appears
/// under the bar once content scrolls beneath it.
class AppLargeTitleScrollView extends StatefulWidget {
  const AppLargeTitleScrollView({
    required this.title,
    required this.slivers,
    this.titleWidget,
    this.subtitle,
    this.subtitleHighlighted = false,
    this.leading,
    this.actions = const <Widget>[],
    this.controller,
    this.physics,
    super.key,
  });

  /// The title, also shown centred in the bar once scrolled.
  final String title;

  /// Replaces the large title text (the scope switcher on the Vault tab).
  final Widget? titleWidget;

  /// "2FA codes from your vault, made on this phone".
  final String? subtitle;

  /// Accent and bold, announced as it changes: a selection's count ("2
  /// tags selected", board `S5-08`).
  final bool subtitleHighlighted;

  /// Back with the previous title (pushed screens).
  final Widget? leading;

  /// Top-right actions (`AppIconButton`s, `AppLinkButton.bar`).
  final List<Widget> actions;

  /// The content below the title.
  final List<Widget> slivers;
  final ScrollController? controller;

  /// The Vault list bounces on both platforms, for pull to refresh.
  final ScrollPhysics? physics;

  @override
  State<AppLargeTitleScrollView> createState() =>
      _AppLargeTitleScrollViewState();
}

class _AppLargeTitleScrollViewState extends State<AppLargeTitleScrollView> {
  ScrollController? _ownController;
  ScrollController get _controller =>
      widget.controller ?? (_ownController ??= ScrollController());
  final ValueNotifier<double> _scrolled = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _ownController?.dispose();
    _scrolled.dispose();
    super.dispose();
  }

  void _onScroll() =>
      _scrolled.value = _controller.hasClients ? _controller.offset : 0;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final double topInset = MediaQuery.paddingOf(context).top;
    // The large title is 38 pt tall below a 2 pt gap: once it has scrolled
    // under the bar, the bar takes over.
    final double titleHeight = 40.h;
    final bool reduceMotion = AppMotion.reduceMotion(context);
    // A round header button ends where the content does, 16 pt from the
    // edge (your answer, 2026-11-03); other actions keep the bar's 6 pt.
    final double actionsEnd = widget.actions.lastOrNull is AppIconButton
        ? 16.w -
              (AppPressable.minTarget(context) - AppIconButton.headerCircle.r) /
                  2
        : 6.w;

    return Column(
      children: <Widget>[
        ValueListenableBuilder<double>(
          valueListenable: _scrolled,
          builder: (BuildContext context, double offset, _) {
            final double progress = (offset / titleHeight).clamp(0, 1);
            return DecoratedBox(
              decoration: BoxDecoration(
                color: colors.background,
                border: Border(
                  bottom: BorderSide(
                    color: offset > 0 ? colors.border : Colors.transparent,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: topInset),
                child: SizedBox(
                  height: 44.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w, right: actionsEnd),
                    child: Row(
                      children: <Widget>[
                        widget.leading ?? SizedBox(width: 8.w),
                        Expanded(
                          child: Opacity(
                            opacity: reduceMotion
                                ? (progress >= 1 ? 1 : 0)
                                : progress,
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: styles.navTitle().copyWith(
                                color: colors.foreground,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 2.w,
                          children: widget.actions,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Expanded(
          child: CustomScrollView(
            controller: _controller,
            physics: widget.physics,
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.titleWidget ??
                          Semantics(
                            header: true,
                            child: Text(
                              widget.title,
                              textScaler: AppTextStyles.largeStyleTextScaler(
                                context,
                              ),
                              style: styles.largeTitle().copyWith(
                                color: colors.foreground,
                              ),
                            ),
                          ),
                      if (widget.subtitle != null)
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Semantics(
                            liveRegion: widget.subtitleHighlighted,
                            child: Text(
                              widget.subtitle!,
                              style: styles
                                  .body()
                                  .resized(
                                    15,
                                    line: 21,
                                    weight: widget.subtitleHighlighted
                                        ? FontWeight.w700
                                        : null,
                                  )
                                  .copyWith(
                                    color: widget.subtitleHighlighted
                                        ? colors.accentStrong
                                        : colors.mutedForeground,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              ...widget.slivers,
            ],
          ),
        ),
      ],
    );
  }
}

/// The counted actions that replace the tab bar in selection mode
/// (`.toolbar`, board C4): "Move 3 items", "Delete 3 items".
class AppSelectionToolbar extends StatelessWidget {
  const AppSelectionToolbar({required this.actions, super.key});

  /// Medium [AppButton]s; they share the width.
  final List<AppButton> actions;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.sidebar,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          8.h,
          16.w,
          MediaQuery.paddingOf(context).bottom + 8.h,
        ),
        child: Row(
          spacing: 10.w,
          children: <Widget>[
            for (final AppButton action in actions) Expanded(child: action),
          ],
        ),
      ),
    );
  }
}

/// The sign-in flow's step bar (`.seg`, board C4): "Step 2 of 3".
class AppStepBar extends StatelessWidget {
  const AppStepBar({required this.current, required this.total, super.key});

  /// 1-based.
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Semantics(
      label: t.common.stepOf(current: current, total: total),
      value: '$current',
      excludeSemantics: true,
      child: Row(
        spacing: 6.w,
        children: <Widget>[
          for (int i = 1; i <= total; i++)
            Expanded(
              child: Container(
                height: 4.h,
                decoration: ShapeDecoration(
                  color: i <= current ? colors.primary : colors.secondary,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
