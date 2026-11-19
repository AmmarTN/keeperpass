import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// Pill colours.
enum AppPillTone {
  /// Neutral fill, foreground text (`.pill`, `.vp`).
  neutral,

  /// Neutral fill, muted text (`.cnt`).
  muted,

  /// Accent tint, accent-strong text (`.cbadge`, `.newb`, `.band.ok`, "Last used").
  accent,

  /// Amber tint (`.band.warn`).
  warning,

  /// Red tint (`.band.bad`, `.cnt` flagged, `.mk`).
  destructive,

  /// Solid accent (`.pill` "Fill").
  solid,
}

/// Every pill on the boards: counts, "Default" and "New" badges, health bands,
/// the vault pill, status pills and the finding marker.
class AppPill extends StatelessWidget {
  const AppPill({
    this.label,
    this.leading,
    this.trailing,
    this.tone = AppPillTone.neutral,
    this.height = 24,
    this.horizontalPadding = 10,
    this.gap = 6,
    this.minWidth,
    this.textStyle,
    this.semanticLabel,
    super.key,
  });

  /// `.cnt` — a count beside a title (flagged counts in red).
  factory AppPill.count(int count, {bool flagged = false, Key? key}) => AppPill(
    key: key,
    label: '$count',
    tone: flagged ? AppPillTone.destructive : AppPillTone.muted,
    height: 22,
    horizontalPadding: 7,
    minWidth: 24,
  );

  /// `.cbadge` — "Default", "Current Version".
  factory AppPill.badge(String label, {Key? key}) => AppPill(
    key: key,
    label: label,
    tone: AppPillTone.accent,
    height: 22,
    horizontalPadding: 9,
    textStyle: _Weight.w800(11),
  );

  /// `.newb` — "New".
  factory AppPill.newBadge(String label, {Key? key}) => AppPill(
    key: key,
    label: label,
    tone: AppPillTone.accent,
    height: 20,
    horizontalPadding: 8,
    textStyle: _Weight.w800(11),
  );

  /// `.band` — the health band (Strong · Needs work · At risk).
  factory AppPill.band(
    String label, {
    required AppPillTone tone,
    required AppIconName icon,
    Key? key,
  }) => AppPill(
    key: key,
    label: label,
    tone: tone,
    height: 26,
    leading: _PillIcon(icon, size: 14, stroke: 2.25),
  );

  /// `.vp` — the vault an item lives in, or "Favorite".
  factory AppPill.vault(
    String label, {
    Widget? leading,
    AppPillTone tone = AppPillTone.neutral,
    Key? key,
  }) =>
      AppPill(key: key, label: label, tone: tone, height: 26, leading: leading);

  /// `.mk` — the finding marker after an item's name.
  factory AppPill.finding({required String semanticLabel, Key? key}) => AppPill(
    key: key,
    tone: AppPillTone.destructive,
    height: 18,
    minWidth: 22,
    horizontalPadding: 0,
    semanticLabel: semanticLabel,
    leading: const _PillIcon(AppIconName.shieldAlert, size: 12, stroke: 2.25),
  );

  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final AppPillTone tone;
  final double height;
  final double horizontalPadding;
  final double gap;
  final double? minWidth;

  /// Defaults to 12 pt bold (`.pill`).
  final TextStyle? Function(BuildContext context)? textStyle;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final (Color background, Color foreground) = switch (tone) {
      AppPillTone.neutral => (colors.secondary, colors.foreground),
      AppPillTone.muted => (colors.secondary, colors.mutedForeground),
      AppPillTone.accent => (colors.primary15, colors.accentStrong),
      AppPillTone.warning => (colors.warningTint, colors.warningStrong),
      AppPillTone.destructive => (
        colors.destructiveTint,
        colors.destructiveStrong,
      ),
      AppPillTone.solid => (colors.primary, colors.primaryForeground),
    };
    final TextStyle style =
        (textStyle?.call(context) ??
                AppTextStyles(context).badge().resized(12, line: 16))
            .copyWith(color: foreground);

    final Widget pill = Container(
      height: height.r,
      constraints: BoxConstraints(minWidth: (minWidth ?? 0).r),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      decoration: ShapeDecoration(
        color: background,
        shape: const StadiumBorder(),
      ),
      child: IconTheme.merge(
        data: IconThemeData(color: foreground),
        child: DefaultTextStyle.merge(
          style: style,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: gap.w,
            children: <Widget>[
              ?leading,
              if (label != null) Text(label!, maxLines: 1, softWrap: false),
              ?trailing,
            ],
          ),
        ),
      ),
    );

    if (semanticLabel == null) return pill;
    return Semantics(label: semanticLabel, excludeSemantics: true, child: pill);
  }
}

class _PillIcon extends StatelessWidget {
  const _PillIcon(this.icon, {required this.size, required this.stroke});

  final AppIconName icon;
  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) =>
      AppIcon(icon, size: size, stroke: stroke);
}

abstract final class _Weight {
  static TextStyle? Function(BuildContext) w800(double size) =>
      (BuildContext context) => AppTextStyles(
        context,
      ).badge().resized(size, line: 16, weight: FontWeight.w800);
}
