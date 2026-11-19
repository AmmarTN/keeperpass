import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/icons/icon_catalog.dart';
import 'package:keeperpass/core/utils/text/country_codes.dart';
import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_search_field.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/edit_labels.dart';

/// The glyph a type stands for (web `FieldDefinition.icon`).
int typeGlyph(FieldType type) => FaGlyphs.byName[type.icon] ?? FaGlyphs.note;

// ---- Add field

/// "Add Field" (board `S3-40`): all 16 types in the web's order, four
/// across. Resolves to the type, or null when closed.
Future<FieldType?> showAddFieldSheet(BuildContext context) =>
    showAppSheet<FieldType>(
      context,
      builder: (BuildContext sheet) => AppSheet(
        title: t.editItem.addFieldTitle,
        child: Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: TileGrid(
            columns: 4,
            count: FieldType.values.length,
            cell: (int i, double width) => _TypeTile(
              type: FieldType.values[i],
              width: width,
              onTap: () => Navigator.of(sheet).pop(FieldType.values[i]),
            ),
          ),
        ),
      ),
    );

/// Rows of [columns] equal cells, 8 pt apart, as tall as the tallest in
/// the row; [cell] gets the cell's width.
class TileGrid extends StatelessWidget {
  const TileGrid({
    required this.columns,
    required this.count,
    required this.cell,
    super.key,
  });

  final int columns;
  final int count;
  final Widget Function(int index, double width) cell;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double gap = 8.w;
      final double width =
          (constraints.maxWidth - gap * (columns - 1)) / columns;
      return Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.h,
        children: <Widget>[
          for (int i = 0; i < count; i += columns)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: gap,
                children: <Widget>[
                  for (int j = i; j < i + columns; j++)
                    Expanded(
                      child: j < count ? cell(j, width) : const SizedBox(),
                    ),
                ],
              ),
            ),
        ],
      );
    },
  );
}

/// `.ttile` (84 pt): the type's tile and its name.
class _TypeTile extends StatelessWidget {
  const _TypeTile({
    required this.type,
    required this.width,
    required this.onTap,
  });

  final FieldType type;

  /// The cell's width, for the label.
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final BorderRadius radius = BorderRadius.circular(14.r);
    return AppPressable(
      onTap: onTap,
      semanticLabel: fieldTypeLabel(type),
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: Container(
        constraints: BoxConstraints(minHeight: 84.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: radius,
          border: Border.all(color: colors.hairline),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.h,
          children: <Widget>[
            AppIconTile(AppTileGlyph(typeGlyph(type)), size: AppTileSize.card),
            TileLabel(
              fieldTypeLabel(type),
              maxWidth: width - 8.w - 2,
              style: AppTextStyles(context)
                  .badge()
                  .resized(12, line: 15, weight: FontWeight.w700)
                  .copyWith(color: colors.foreground),
            ),
          ],
        ),
      ),
    );
  }
}

/// A tile's centred label that wraps between words only: a word wider
/// than [maxWidth] ("Authenticator") shrinks the text instead of breaking.
class TileLabel extends StatelessWidget {
  const TileLabel(
    this.text, {
    required this.style,
    required this.maxWidth,
    super.key,
  });

  final String text;
  final TextStyle style;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    double widest = 0;
    for (final String word in text.split(' ')) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: word, style: style),
        textDirection: TextDirection.ltr,
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      if (painter.width > widest) widest = painter.width;
      painter.dispose();
    }
    final double fit = widest > maxWidth ? maxWidth / widest : 1;
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style.copyWith(fontSize: style.fontSize! * fit),
    );
  }
}

// ---- Choose icon

/// What the icon picker returns: a code point, or null for the default.
class IconChoice {
  const IconChoice(this.glyph);

  final String? glyph;
}

/// "Choose Icon" (boards `S3-42`, `S3-43`; web `IconPickerDialog`): the
/// Popular set until something is typed, then the catalogue searched like
/// fontawesome.com; "Use default icon" goes back to [defaultTile]. Null
/// when closed.
Future<IconChoice?> showIconPicker(
  BuildContext context, {
  required Future<List<CatalogIcon>> catalog,
  required String? current,
  required Widget defaultTile,
}) => showAppSheet<IconChoice>(
  context,
  builder: (_) =>
      _IconPicker(catalog: catalog, current: current, defaultTile: defaultTile),
);

class _IconPicker extends StatefulWidget {
  const _IconPicker({
    required this.catalog,
    required this.current,
    required this.defaultTile,
  });

  final Future<List<CatalogIcon>> catalog;
  final String? current;
  final Widget defaultTile;

  @override
  State<_IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<_IconPicker> {
  final TextEditingController _query = TextEditingController();
  List<CatalogIcon> _all = const <CatalogIcon>[];

  @override
  void initState() {
    super.initState();
    widget.catalog.then((List<CatalogIcon> all) {
      if (mounted) setState(() => _all = all);
    });
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String query = _query.text;
    final bool searching = foldText(query).isNotEmpty;
    final List<CatalogIcon> shown = searching
        ? searchIconCatalog(_all, query)
        : popularIcons(_all);
    final NavigatorState navigator = Navigator.of(context);

    return AppSheet(
      title: t.editItem.chooseIcon,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10.h,
        children: <Widget>[
          AppSearchField(
            controller: _query,
            placeholder: t.editItem.searchIcons,
            onChanged: (_) => setState(() {}),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              (searching
                      ? t.editItem.iconMatches(n: shown.length)
                      : t.editItem.popular)
                  .toUpperCase(),
              style: styles.sectionLabel().copyWith(
                color: colors.mutedForeground,
              ),
            ),
          ),
          if (searching && shown.isEmpty)
            Text(
              t.editItem.noIcons(search: query.trim()),
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            )
          else
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 280.h),
              child: SingleChildScrollView(
                child: TileGrid(
                  columns: 6,
                  count: shown.length,
                  cell: (int i, _) => _IconCell(
                    icon: shown[i],
                    selected: shown[i].unicode == widget.current,
                    onTap: () => navigator.pop(IconChoice(shown[i].unicode)),
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
            child: AppInsetGroup.sheet(
              children: <Widget>[
                AppPressable(
                  onTap: () => navigator.pop(const IconChoice(null)),
                  selected: widget.current == null,
                  child: SizedBox(
                    height: 52.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        spacing: 12.w,
                        children: <Widget>[
                          widget.defaultTile,
                          Expanded(
                            child: Text(
                              t.editItem.useDefaultIcon,
                              style: styles.body().copyWith(
                                color: colors.foreground,
                              ),
                            ),
                          ),
                          if (widget.current == null)
                            AppIcon(
                              AppIconName.check,
                              size: 18,
                              stroke: 2.5,
                              color: colors.accentStrong,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// `.ic`: one catalogue icon, 48 pt tall, in Light (plan O9).
class _IconCell extends StatelessWidget {
  const _IconCell({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final CatalogIcon icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final BorderRadius radius = BorderRadius.circular(12.r);
    return AppPressable(
      onTap: onTap,
      semanticLabel: icon.label,
      selected: selected,
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: selected ? colors.primary15 : colors.background,
          borderRadius: radius,
          border: Border.all(
            color: selected ? colors.primary30 : colors.hairline,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: FaGlyph(
            icon.codePoint,
            size: 18,
            color: selected ? colors.accentStrong : colors.foreground,
          ),
        ),
      ),
    );
  }
}

// ---- Country code

/// The phone's country code (web country combobox): searched by the name
/// in the app language or in English, the dial code or the ISO code,
/// accents aside. Null when closed.
Future<Country?> showCountryPicker(
  BuildContext context, {
  required Future<Map<String, dynamic>> names,
}) => showAppSheet<Country>(
  context,
  builder: (_) => _CountryPicker(names: names),
);

/// The web's `countryFilter`.
bool countryMatches(Country country, String localizedName, String search) {
  final String query = foldText(search);
  if (query.isEmpty) return true;
  return foldText(country.name).contains(query) ||
      foldText(localizedName).contains(query) ||
      country.dial
          .replaceFirst('+', '')
          .startsWith(query.replaceFirst('+', '')) ||
      foldText(country.iso) == query;
}

class _CountryPicker extends StatefulWidget {
  const _CountryPicker({required this.names});

  final Future<Map<String, dynamic>> names;

  @override
  State<_CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<_CountryPicker> {
  final TextEditingController _query = TextEditingController();
  Map<String, dynamic> _names = const <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    widget.names.then((Map<String, dynamic> names) {
      if (mounted) setState(() => _names = names);
    });
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String locale = LocaleSettings.currentLocale.languageCode;
    final List<(Country, String)> shown = <(Country, String)>[
      for (final Country country in kCountries)
        if (countryMatches(
          country,
          countryName(country, locale, _names),
          _query.text,
        ))
          (country, countryName(country, locale, _names)),
    ];

    return AppSheet(
      title: t.common.countryCode,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10.h,
        children: <Widget>[
          AppSearchField(
            controller: _query,
            placeholder: t.editItem.searchCountries,
            onChanged: (_) => setState(() {}),
          ),
          SizedBox(
            height: 360.h,
            child: shown.isEmpty
                ? Text(
                    t.editItem.noCountryMatch,
                    style: styles.secondary().copyWith(
                      color: colors.mutedForeground,
                    ),
                  )
                : ListView.builder(
                    itemCount: shown.length,
                    itemExtent: 48.h,
                    itemBuilder: (BuildContext context, int i) {
                      final (Country country, String name) = shown[i];
                      return AppPressable(
                        onTap: () => Navigator.of(context).pop(country),
                        semanticLabel: '$name, ${country.dial}',
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            spacing: 10.w,
                            children: <Widget>[
                              ExcludeSemantics(
                                child: Text(
                                  country.flag,
                                  style: TextStyle(fontSize: 18.r),
                                ),
                              ),
                              SizedBox(
                                width: 52.w,
                                child: Text(
                                  country.dial,
                                  style: styles.body().copyWith(
                                    color: colors.mutedForeground,
                                    fontFeatures: const <FontFeature>[
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: styles.body().copyWith(
                                    color: colors.foreground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
