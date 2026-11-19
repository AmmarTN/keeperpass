import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';

/// A banner's tone (board C6): red for a real failure, amber when something
/// needs attention, neutral for conditions, accent for information.
enum AppBannerTone {
  error,
  warning,
  neutral,

  /// Neutral inside a card-coloured surface (`.ban.neu2`, the Welcome dock):
  /// the background colour and the hairline, no shadow.
  neutralOnCard,
  info,
}

/// A banner (`.ban`, `.warnc`): an icon, a title and a line, and optional
/// actions (`AppSmallButton`s). The info tone is a single line.
class AppBanner extends StatelessWidget {
  const AppBanner({
    required this.tone,
    required this.icon,
    required this.title,
    this.body,
    this.actions = const <Widget>[],
    this.footer,
    this.busy = false,
    super.key,
  });

  final AppBannerTone tone;
  final AppIconName icon;
  final String title;
  final String? body;
  final List<Widget> actions;

  /// Full width under the text, 6 pt below it: the consent an existing
  /// vault needs (`.warnc` › `.ack`, board `S5-26`).
  final Widget? footer;

  /// A spinner in place of the icon: "Trying again…" (board `Sync-states`).
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    // The info tone is one line, unless it has a body (`.bcol`: the earlier
    // version's date and what it is, board `S3-25`).
    final bool info = tone == AppBannerTone.info && body == null;
    final OutlinedBorder shape = AppRadius.shape(context, AppRadius.xxl);

    final (
      Color background,
      Color iconColor,
      Color titleColor,
      Color bodyColor,
    ) = switch (tone) {
      AppBannerTone.error => (
        colors.destructiveTint,
        colors.destructiveStrong,
        colors.destructiveStrong,
        colors.foreground,
      ),
      AppBannerTone.warning => (
        colors.warningTint,
        colors.warningStrong,
        colors.foreground,
        colors.foreground,
      ),
      AppBannerTone.neutral => (
        colors.card,
        colors.mutedForeground,
        colors.foreground,
        colors.mutedForeground,
      ),
      AppBannerTone.neutralOnCard => (
        colors.background,
        colors.mutedForeground,
        colors.foreground,
        colors.mutedForeground,
      ),
      AppBannerTone.info => (
        colors.primary10,
        colors.accentStrong,
        colors.foreground,
        colors.mutedForeground,
      ),
    };
    final List<BoxShadow>? shadows = switch (tone) {
      AppBannerTone.neutral => <BoxShadow>[
        ...context.shadows.shadowXs,
        BoxShadow(color: colors.hairline, spreadRadius: 1.r),
      ],
      AppBannerTone.neutralOnCard => <BoxShadow>[
        BoxShadow(color: colors.hairline, spreadRadius: 1.r),
      ],
      _ => null,
    };

    return Semantics(
      liveRegion: true,
      container: true,
      child: Container(
        padding: tone == AppBannerTone.info
            ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h)
            : EdgeInsets.all(14.r),
        decoration: ShapeDecoration(
          color: background,
          shape: tone == AppBannerTone.info
              ? AppRadius.shape(
                  context,
                  AppRadius.xxl,
                  side: BorderSide(color: colors.primary30, width: 1.r),
                )
              : shape,
          shadows: shadows,
        ),
        child: _withFooter(
          Row(
            crossAxisAlignment: tone == AppBannerTone.info
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            spacing: 12.w,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: info ? 0 : 1.h),
                child: busy
                    ? const RepaintBoundary(child: AppSpinner(size: 22))
                    : AppIcon(
                        icon,
                        size: tone == AppBannerTone.info ? AppIconSizes.md : 22,
                        stroke: 1.75,
                        color: iconColor,
                      ),
              ),
              Expanded(
                child: info
                    ? Text(
                        title,
                        style: styles
                            .formLabel()
                            .resized(14, line: 20, weight: FontWeight.w400)
                            .copyWith(color: titleColor),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: <Widget>[
                          Text(
                            title,
                            style: styles.button().copyWith(color: titleColor),
                          ),
                          if (body != null)
                            Text(
                              body!,
                              style: styles
                                  .formLabel()
                                  .resized(
                                    14,
                                    line: 20,
                                    weight: FontWeight.w400,
                                  )
                                  .copyWith(color: bodyColor),
                            ),
                          if (actions.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: actions,
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _withFooter(Widget row) => footer == null
      ? row
      : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 6.h,
          children: <Widget>[row, footer!],
        );
}
