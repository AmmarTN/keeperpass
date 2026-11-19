import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/text/tag_color.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_spacing.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/theme/app_theme_data.dart';

/// Debug builds only (see the router): every colour, text style, shadow,
/// radius and a sample of icons, in a Light and a Dark panel like the design
/// boards. Labels are token names for developers, not user-facing copy.
@RoutePage()
class DesignTokensPage extends StatelessWidget {
  const DesignTokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design tokens')),
      body: ListView(
        children: const <Widget>[
          _ThemePanel(brightness: Brightness.light),
          _ThemePanel(brightness: Brightness.dark),
        ],
      ),
    );
  }
}

class _ThemePanel extends StatelessWidget {
  const _ThemePanel({required this.brightness});

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppThemeData.getAppThemeData(
        brightness: brightness,
        context: context,
      ),
      child: Builder(
        builder: (BuildContext context) {
          final AppColors colors = context.colors;
          final AppTextStyles styles = AppTextStyles(context);

          return Container(
            color: colors.background,
            padding: EdgeInsets.all(AppSpacing.md.r),
            child: DefaultTextStyle(
              style: styles.body().copyWith(color: colors.foreground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    brightness == Brightness.light ? 'Light' : 'Dark',
                    style: styles.largeTitle(),
                    textScaler: AppTextStyles.largeStyleTextScaler(context),
                  ),
                  const _Section('Colours'),
                  for (final MapEntry<String, Color> token
                      in colors.tokens.entries)
                    _ColorRow(name: token.key, color: token.value),
                  const _Section('Tag colours (tag-color.ts)'),
                  Wrap(
                    spacing: AppSpacing.xs.w,
                    runSpacing: AppSpacing.xs.h,
                    children: <Widget>[
                      for (final TagColor tag in TagColor.values)
                        _TagChip(label: tag.name, color: colors.tag(tag)),
                    ],
                  ),
                  const _Section('Text styles'),
                  ..._textStyles(styles).entries.map(
                    (MapEntry<String, TextStyle> s) => Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.xs.h),
                      child: Text(
                        '${s.key} — KeeperPass 482 913',
                        style: s.value,
                      ),
                    ),
                  ),
                  const _Section('Shadows'),
                  Wrap(
                    spacing: AppSpacing.md.w,
                    runSpacing: AppSpacing.md.h,
                    children: <Widget>[
                      for (final MapEntry<String, List<BoxShadow>> s
                          in context.shadows.tokens.entries)
                        Container(
                          width: 150.w,
                          height: 64.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colors.card,
                            borderRadius: BorderRadius.circular(
                              AppRadius.xxl.r,
                            ),
                            boxShadow: s.value,
                          ),
                          child: Text(s.key, style: styles.secondary()),
                        ),
                    ],
                  ),
                  const _Section('Radii'),
                  Wrap(
                    spacing: AppSpacing.md.w,
                    children: <Widget>[
                      for (final (String name, double radius)
                          in <(String, double)>[
                            ('lg 8', AppRadius.lg),
                            ('xl 12', AppRadius.xl),
                            ('xxl 16', AppRadius.xxl),
                            ('full', AppRadius.full),
                          ])
                        Container(
                          width: 72.r,
                          height: 48.r,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            color: colors.primary15,
                            shape: AppRadius.shape(context, radius),
                          ),
                          child: Text(name, style: styles.secondary()),
                        ),
                    ],
                  ),
                  const _Section('Lucide — 14 · 16 · 20 · 24'),
                  for (final double size in <double>[
                    AppIconSizes.xs,
                    AppIconSizes.sm,
                    AppIconSizes.md,
                    AppIconSizes.lg,
                  ])
                    Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.xs.h),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 64.w,
                            child: Text(
                              '${size.toInt()} · ${AppIconSizes.strokeFor(size)}',
                              style: styles.secondary(),
                            ),
                          ),
                          for (final AppIconName icon in const <AppIconName>[
                            AppIconName.layers,
                            AppIconName.timer,
                            AppIconName.wandSparkles,
                            AppIconName.shieldCheck,
                            AppIconName.settings,
                            AppIconName.lockKeyhole,
                            AppIconName.copy,
                            AppIconName.search,
                          ])
                            Padding(
                              padding: EdgeInsets.only(right: AppSpacing.sm.w),
                              child: AppIcon(
                                icon,
                                size: size,
                                color: colors.foreground,
                              ),
                            ),
                        ],
                      ),
                    ),
                  const _Section('Font Awesome — Light · Solid'),
                  for (final FaWeight weight in FaWeight.values)
                    Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.xs.h),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 64.w,
                            child: Text(weight.name, style: styles.secondary()),
                          ),
                          for (final int glyph in const <int>[
                            FaGlyphs.tag,
                            FaGlyphs.favourite,
                            FaGlyphs.password,
                            FaGlyphs.web,
                            FaGlyphs.vault,
                            FaGlyphs.copy,
                            FaGlyphs.weak,
                            FaGlyphs.compromised,
                          ])
                            Padding(
                              padding: EdgeInsets.only(right: AppSpacing.sm.w),
                              child: FaGlyph(
                                glyph,
                                size: 20,
                                weight: weight,
                                color: colors.accentStrong,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Map<String, TextStyle> _textStyles(AppTextStyles s) => <String, TextStyle>{
    'display': s.display(),
    'stat': s.stat(),
    'largeTitle': s.largeTitle(),
    'itemTitle': s.itemTitle(),
    'appBarTitle': s.appBarTitle(),
    'title': s.title(),
    'navTitle': s.navTitle(),
    'rowTitle': s.rowTitle(),
    'body': s.body(),
    'bodyStrong': s.bodyStrong(),
    'buttonLg': s.buttonLg(),
    'button': s.button(),
    'formLabel': s.formLabel(),
    'secondary': s.secondary(),
    'fieldLabel': s.fieldLabel(),
    'sectionLabel': s.sectionLabel(),
    'badge': s.badge(),
    'tabLabel': s.tabLabel(),
    'secret': s.secret(),
    'code': s.code(),
    'codeLg': s.codeLg(),
    'generated': s.generated(),
    'largeType': s.largeType(),
    'fileName': s.fileName(),
  };
}

class _Section extends StatelessWidget {
  const _Section(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.xl.h, bottom: AppSpacing.xs.h),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles(
          context,
        ).sectionLabel().copyWith(color: context.colors.mutedForeground),
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final String argb = color
        .toARGB32()
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.xxs.h),
      child: Row(
        children: <Widget>[
          Container(
            width: 28.r,
            height: 28.r,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppRadius.lg.r),
              border: Border.all(color: context.colors.hairline),
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          Expanded(child: Text(name)),
          Text('#$argb', style: AppTextStyles(context).fileName()),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm.w,
        vertical: AppSpacing.xxs.h,
      ),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FaGlyph(FaGlyphs.tag, size: 12, color: color),
          SizedBox(width: AppSpacing.xxs.w),
          Text(
            label,
            style: AppTextStyles(context).badge().copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
