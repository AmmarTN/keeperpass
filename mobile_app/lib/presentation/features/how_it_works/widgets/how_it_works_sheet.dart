import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_story_theme.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/features/how_it_works/widgets/story_illustrations.dart';

/// "How it works" (D7): the Story, three short pages in a tall sheet, drawn
/// as the story boards (`ALT-HW1-1-Story-First`, `ALT-HW1-2-Story-Last`;
/// step 2 per D8). Swipe down, Close or Got it closes it; step 3's
/// "Technical details" opens [onTechnicalDetails] (X5).
Future<void> showHowItWorks(
  BuildContext context, {
  required VoidCallback onTechnicalDetails,
}) {
  final bool reduceMotion = AppMotion.reduceMotion(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: context.story.scrim,
    elevation: 0,
    sheetAnimationStyle: AnimationStyle(
      duration: reduceMotion ? Duration.zero : AppMotion.slow,
      reverseDuration: reduceMotion ? Duration.zero : AppMotion.base,
      curve: AppMotion.easeOut,
    ),
    builder: (BuildContext sheetContext) =>
        HowItWorksSheet(onTechnicalDetails: onTechnicalDetails),
  );
}

class HowItWorksSheet extends StatefulWidget {
  const HowItWorksSheet({required this.onTechnicalDetails, super.key});

  final VoidCallback onTechnicalDetails;

  @override
  State<HowItWorksSheet> createState() => _HowItWorksSheetState();
}

class _HowItWorksSheetState extends State<HowItWorksSheet> {
  final PageController _pages = PageController();
  int _page = 0;

  static const int _count = 3;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _go(int page) {
    if (AppMotion.reduceMotion(context)) {
      _pages.jumpToPage(page);
    } else {
      _pages.animateToPage(
        page,
        duration: AppMotion.slow,
        curve: AppMotion.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppStoryTheme story = context.story;
    final MediaQueryData media = MediaQuery.of(context);
    final BorderRadius radius = BorderRadius.vertical(
      top: Radius.circular(38.r),
    );

    return LayoutBuilder(
      // The sheet's top sits 3 pt under the status bar (board: top 62).
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        height: constraints.maxHeight - 3.h,
        decoration: BoxDecoration(
          color: story.surface,
          borderRadius: radius,
          boxShadow: story.sheet,
        ),
        padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 0),
        child: Column(
          children: <Widget>[
            Container(
              width: 38.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: colors.mutedForeground.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(9.r),
              ),
            ),
            SizedBox(
              height: 44.h,
              child: Row(
                children: <Widget>[
                  if (_page > 0)
                    Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: _GhostBack(onTap: () => _go(_page - 1)),
                    ),
                  const Spacer(),
                  _CloseButton(onTap: () => Navigator.of(context).maybePop()),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pages,
                onPageChanged: (int page) => setState(() => _page = page),
                children: <Widget>[
                  _StoryPage(
                    index: 0,
                    picture: const StoryCloudPicture(),
                    pictureHeight: StoryCloudPicture.height,
                    title: t.howItWorks.step1Title,
                    body: t.howItWorks.step1Body,
                  ),
                  _StoryPage(
                    index: 1,
                    picture: const StorySecretPicture(),
                    pictureHeight: StorySecretPicture.height,
                    title: t.howItWorks.step2Title,
                    body: t.howItWorks.step2Body,
                  ),
                  _StoryPage(
                    index: 2,
                    picture: const StoryBothPicture(),
                    pictureHeight: StoryBothPicture.height,
                    title: t.howItWorks.step3Title,
                    body: t.howItWorks.step3Body,
                    extra: _TechnicalRow(onTap: widget.onTechnicalDetails),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12.h,
                bottom: media.padding.bottom > 0 ? media.padding.bottom : 20.h,
              ),
              child: _Cta(
                label: _page == _count - 1 ? t.common.gotIt : t.common.next,
                onTap: _page == _count - 1
                    ? () => Navigator.of(context).maybePop()
                    : () => _go(_page + 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryPage extends StatelessWidget {
  const _StoryPage({
    required this.index,
    required this.picture,
    required this.pictureHeight,
    required this.title,
    required this.body,
    this.extra,
  });

  final int index;
  final Widget picture;
  final double pictureHeight;
  final String title;
  final String body;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppStoryTheme story = context.story;
    final AppTextStyles styles = AppTextStyles(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 4.h),
          SizedBox(
            width: double.infinity,
            height: pictureHeight * MediaQuery.sizeOf(context).width / 393,
            child: picture,
          ),
          SizedBox(height: 6.h),
          _Dots(current: index),
          SizedBox(height: 22.h),
          Text(
            title,
            style: styles
                .largeTitle()
                .resized(28, line: 34)
                .copyWith(color: story.ink, letterSpacing: -0.03 * 28),
          ),
          SizedBox(height: 10.h),
          Text(
            body,
            style: styles
                .body()
                .resized(16, line: 24)
                .copyWith(color: colors.mutedForeground),
          ),
          if (extra != null) ...<Widget>[SizedBox(height: 20.h), extra!],
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

/// `.al-dots`: the current page is a 22 pt pill.
class _Dots extends StatelessWidget {
  const _Dots({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Semantics(
      label: t.common.stepOf(current: current + 1, total: 3),
      child: ExcludeSemantics(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6.w,
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              AnimatedContainer(
                duration: AppMotion.reduceMotion(context)
                    ? Duration.zero
                    : AppMotion.base,
                curve: AppMotion.easeOut,
                width: (i == current ? 22 : 7).r,
                height: 7.r,
                decoration: BoxDecoration(
                  color: i == current
                      ? colors.accentStrong
                      : context.story.separator,
                  borderRadius: BorderRadius.circular(9.r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// `.al-row`: "Technical details · Argon2id · AES-256 ›".
class _TechnicalRow extends StatelessWidget {
  const _TechnicalRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.r),
    );
    return AppPressable(
      onTap: onTap,
      shape: shape,
      child: Container(
        constraints: BoxConstraints(minHeight: 56.h),
        padding: EdgeInsets.only(left: 16.w, right: 14.w),
        decoration: ShapeDecoration(color: colors.secondary, shape: shape),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            AppIcon(
              AppIconName.info,
              size: 19,
              stroke: 2.1,
              color: colors.accentStrong,
            ),
            Expanded(
              child: Text(
                t.howItWorks.technicalDetails,
                style: styles
                    .body()
                    .resized(15, line: 20, weight: FontWeight.w800)
                    .copyWith(color: context.story.ink),
              ),
            ),
            Text(
              t.howItWorks.technicalSummary,
              style: styles
                  .secondary()
                  .resized(13, line: 18, weight: FontWeight.w700)
                  .copyWith(color: colors.mutedForeground),
            ),
            AppIcon(
              AppIconName.chevronRight,
              size: 18,
              stroke: 2.4,
              color: colors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}

/// `.al-cta`: the 58 pt pill with its accent shadow.
class _Cta extends StatelessWidget {
  const _Cta({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppPressable(
      onTap: onTap,
      shape: const StadiumBorder(),
      child: Container(
        height: 58.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: colors.primary,
          shape: const StadiumBorder(),
          shadows: context.story.cta,
        ),
        child: Text(
          label,
          style: AppTextStyles(context)
              .buttonLg()
              .resized(17, line: 22, weight: FontWeight.w800)
              .copyWith(color: colors.primaryForeground),
        ),
      ),
    );
  }
}

/// `.al-ghost`: "‹ Back".
class _GhostBack extends StatelessWidget {
  const _GhostBack({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppPressable(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 44.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppIcon(
                AppIconName.chevronLeft,
                size: 18,
                stroke: 2.5,
                color: colors.accentStrong,
              ),
              Text(
                t.common.back,
                style: AppTextStyles(context)
                    .button()
                    .resized(15, line: 20)
                    .copyWith(color: colors.accentStrong),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// `.al-x`: the round close button.
class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppPressable(
      onTap: onTap,
      semanticLabel: t.common.close,
      shape: const CircleBorder(),
      child: SizedBox.square(
        dimension: 44.r,
        child: Center(
          child: Container(
            width: 34.r,
            height: 34.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.secondary,
              shape: BoxShape.circle,
            ),
            child: AppIcon(
              AppIconName.x,
              size: 18,
              stroke: 2.4,
              color: colors.mutedForeground,
            ),
          ),
        ),
      ),
    );
  }
}
