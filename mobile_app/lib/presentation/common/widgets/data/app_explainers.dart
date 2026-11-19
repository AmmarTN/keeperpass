import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';

/// A numbered card (`.whatlist`, boards `Move-vault`, `Data`, `Help`): what
/// happens, in order. Each entry is its text (rich when names are set in
/// Space Mono).
class AppNumberedList extends StatelessWidget {
  const AppNumberedList({required this.items, this.footer, super.key});

  final List<Widget> items;

  /// A muted line under a hairline, closing the card ("Both are needed",
  /// board `S5-38`).
  final String? footer;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppSurface(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: <Widget>[
          for (int i = 0; i < items.length; i++)
            MergeSemantics(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.w,
                children: <Widget>[
                  Container(
                    width: 24.r,
                    height: 24.r,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: colors.primary15,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      '${i + 1}',
                      style: AppTextStyles(context)
                          .badge()
                          .resized(12, line: 16, weight: FontWeight.w800)
                          .copyWith(color: colors.accentStrong),
                    ),
                  ),
                  Expanded(
                    child: DefaultTextStyle.merge(
                      style: AppTextStyles(context)
                          .body()
                          .resized(15, line: 21)
                          .copyWith(color: colors.foreground),
                      child: items[i],
                    ),
                  ),
                ],
              ),
            ),
          if (footer != null)
            Container(
              margin: EdgeInsets.only(top: 2.h),
              padding: EdgeInsets.only(top: 12.h),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.border)),
              ),
              child: Text(
                footer!,
                style: AppTextStyles(
                  context,
                ).secondary().copyWith(color: colors.mutedForeground),
              ),
            ),
        ],
      ),
    );
  }
}

/// A quiet confirmation under a field (`.okm`): an accent tick and a muted
/// line — "The two secrets match."
class AppOkNote extends StatelessWidget {
  const AppOkNote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Semantics(
      liveRegion: true,
      child: Row(
        spacing: 6.w,
        children: <Widget>[
          AppIcon(
            AppIconName.check,
            size: AppIconSizes.sm,
            stroke: 2.25,
            color: colors.accentStrong,
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles(context)
                  .secondary()
                  .resized(13, line: 18, weight: FontWeight.w600)
                  .copyWith(color: colors.mutedForeground),
            ),
          ),
        ],
      ),
    );
  }
}

/// [name] with places to break a line after "/" and "-" (the board's
/// `overflow-wrap: anywhere` keeps words whole when it can, and a long file
/// name would otherwise break mid-word).
String breakableFileName(String name) =>
    name.replaceAllMapped(RegExp('[/-]'), (Match m) => '${m[0]}\u200B');

/// A file name that must not be misread (`.mono-card`): Space Mono on the
/// background colour, with its copy button.
class AppMonoCard extends StatelessWidget {
  const AppMonoCard({
    required this.text,
    required this.copyLabel,
    required this.onCopy,
    super.key,
  });

  final String text;

  /// "Copy file name".
  final String copyLabel;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.hairline),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 6.w, 12.h),
        child: Row(
          spacing: 10.w,
          children: <Widget>[
            Expanded(
              child: Text(
                breakableFileName(text),
                semanticsLabel: text,
                style: AppTextStyles(context)
                    .fileName()
                    .resized(13, line: 20)
                    .copyWith(color: colors.foreground),
              ),
            ),
            AppIconButton(
              icon: AppIconName.copy,
              semanticLabel: copyLabel,
              iconSize: 18,
              color: colors.mutedForeground,
              onPressed: onCopy,
            ),
          ],
        ),
      ),
    );
  }
}
