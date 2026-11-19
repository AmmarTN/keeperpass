import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:keeperpass/core/utils/items/card_face.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_card_network_logo.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// Height of the bar under the status bar (`height:44px`).
const double kItemBarHeight = 44;

/// Where the name starts below the scroll view's top: the header's 6 pt,
/// the tile or card face, and 14 pt (`h1 {margin:14px 0 0}`).
double itemNameTop(bool cardFace) =>
    6.h + (cardFace ? 188.r : AppTileSize.large.dimension.r) + 14.h;

/// The item's header (`.hero3`, board `S3-19`): a soft pool of the accent
/// behind its tile — or its card face — the name, the vault and when it
/// changed, then its tags.
class ItemHeader extends StatelessWidget {
  const ItemHeader({
    required this.row,
    required this.updated,
    this.onTag,
    super.key,
  });

  final VaultRow row;

  /// "Updated 4 minutes ago"; null until the relative times are loaded.
  final String? updated;

  /// A tag chip filters the vault by it; null leaves the chips inert.
  final ValueChanged<String>? onTag;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final CardFace? face = cardFaceOf(row.item);

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        // `.glow`: 460 × 400 from 190 pt above, centred.
        Positioned(
          top: -190.h,
          left: -120.w,
          right: -120.w,
          height: 400.h,
          child: Center(
            child: SizedBox(
              width: 460.w,
              height: 400.h,
              child: IgnorePointer(
                child: RepaintBoundary(
                  child: CustomPaint(painter: _GlowPainter(colors.glow)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: face == null
                    ? VaultItemTile(row, size: AppTileSize.large)
                    : ItemCardFace(face, row: row),
              ),
              SizedBox(height: 14.h),
              Semantics(
                header: true,
                child: Text(
                  rowName(row),
                  textAlign: TextAlign.center,
                  style: styles
                      .itemTitle()
                      .resized(26, line: 32, tracking: -0.015)
                      .copyWith(color: colors.foreground),
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8.w,
                runSpacing: 6.h,
                children: <Widget>[
                  AppPill.vault(
                    row.vaultLabel,
                    leading: FaGlyph(
                      FaGlyphs.vault,
                      size: 11,
                      color: colors.mutedForeground,
                    ),
                  ),
                  if (updated != null)
                    Text(
                      updated!,
                      style: styles.secondary().copyWith(
                        color: colors.mutedForeground,
                      ),
                    ),
                ],
              ),
              if (row.item.tags.isNotEmpty) ...<Widget>[
                SizedBox(height: 14.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: <Widget>[
                    for (final String tag in row.item.tags)
                      onTag == null
                          ? AppTagChip(tag)
                          : AppPressable(
                              onTap: () => onTag!(tag),
                              semanticLabel: t.itemDetail.showTagged(tag: tag),
                              shape: const StadiumBorder(),
                              child: AppTagChip(tag),
                            ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// `radial-gradient(closest-side, var(--glow), transparent)` on a 460 × 400
/// box: an ellipse fading out to its edges.
class _GlowPainter extends CustomPainter {
  _GlowPainter(this.glow);

  final Color glow;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Rect circle = Rect.fromCircle(center: Offset.zero, radius: radius);
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2)
      ..scale(1, size.height / size.width)
      ..drawCircle(
        Offset.zero,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: <Color>[glow, glow.withValues(alpha: 0)],
          ).createShader(circle),
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_GlowPainter old) => old.glow != glow;
}

/// A card item's face instead of its tile (`.cardface`, board `S3-29`):
/// the network's logo where the board writes its name (your answers,
/// 2026-11-05: the real logo, at the top left so the holder keeps its room),
/// number masked in its groups, holder and expiry. At the top right, the
/// item's own icon when it has one, as in the list (your answer, 2026-11-05:
/// the issuer's logo, from a picked icon or the item's website), else the
/// card symbol.
class ItemCardFace extends StatelessWidget {
  const ItemCardFace(this.face, {this.row, super.key});

  final CardFace face;

  /// The item, for its own icon; without it the card symbol shows.
  final VaultRow? row;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String locale = LocaleSettings.currentLocale.languageCode;
    final String? brand = face.brand?.label;
    final ({int year, int month})? expiry = face.expiry;
    final String number = face.number.formatted.replaceAll(RegExp(r'\S'), '•');

    String spoken = brand == null
        ? t.itemDetail.cardFace
        : t.itemDetail.cardFaceBrand(brand: brand);
    if (expiry != null) {
      String month;
      try {
        month = DateFormat.yMMMM(
          locale,
        ).format(DateTime(expiry.year, expiry.month));
      } on Exception {
        month = '${expiry.month}/${expiry.year}';
      }
      spoken = '$spoken, ${t.itemDetail.cardExpires(date: month)}';
    }

    return Semantics(
      container: true,
      label: spoken,
      image: true,
      excludeSemantics: true,
      child: Container(
        width: 300.r,
        height: 188.r,
        padding: EdgeInsets.symmetric(horizontal: 22.r, vertical: 20.r),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const <double>[0, 0.6],
            colors: <Color>[
              Color.alphaBlend(colors.primary30, colors.card),
              Color.alphaBlend(colors.primary10, colors.card),
            ],
          ),
          shape: AppRadius.shape(context, 18),
          shadows: <BoxShadow>[
            BoxShadow(color: colors.hairline, spreadRadius: 1.r),
            ...context.shadows.lift,
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (face.brand case final CardBrand network)
                  AppCardNetworkLogo(network),
                const Spacer(),
                if (row case final VaultRow item when _hasOwnIcon(item))
                  VaultItemTile(item, size: AppTileSize.small)
                else
                  FaGlyph(
                    FaGlyphs.credit,
                    size: 22,
                    color: colors.accentStrong,
                  ),
              ],
            ),
            Text(
              number,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: styles
                  .secret()
                  .resized(19, line: 24, tracking: 0.05)
                  .copyWith(color: colors.foreground),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 12.w,
              children: <Widget>[
                Expanded(
                  child: Text(
                    (face.holder ?? '').toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles
                        .badge()
                        .resized(12, line: 16, weight: FontWeight.w800)
                        .copyWith(
                          color: colors.foreground,
                          letterSpacing: 12 * 0.08,
                        ),
                  ),
                ),
                if (expiry != null)
                  Text(
                    '${expiry.month.toString().padLeft(2, '0')}/'
                    '${(expiry.year % 100).toString().padLeft(2, '0')}',
                    style: styles
                        .secret()
                        .resized(13, line: 18)
                        .copyWith(color: colors.foreground),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The bar over the item (board `S3-19`): back with the list's title, then
/// favorite, Edit and more. It turns solid with a hairline once content
/// scrolls under it, and the name fades into it as the header's name
/// scrolls away.
class ItemBar extends StatelessWidget {
  const ItemBar({
    required this.offset,
    required this.nameTop,
    required this.backLabel,
    required this.name,
    this.favourite,
    this.onFavourite,
    this.onEdit,
    this.onMore,
    super.key,
  });

  /// How far the content has scrolled.
  final ValueListenable<double> offset;

  /// Where the header's name starts (see [itemNameTop]).
  final double nameTop;
  final String backLabel;
  final String? name;

  /// Null for the "gone" screen, which only has Back.
  final bool? favourite;
  final VoidCallback? onFavourite;
  final VoidCallback? onEdit;

  /// Opens the menu next to the button (its context anchors it).
  final void Function(BuildContext anchor)? onMore;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool reduceMotion = AppMotion.reduceMotion(context);
    final Widget actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (favourite != null)
          _BarButton(
            label: favourite!
                ? t.vaultList.removeFromFavorites
                : t.vaultList.addToFavorites,
            selected: favourite!,
            onTap: onFavourite,
            child: FaGlyph(
              FaGlyphs.favourite,
              size: 19,
              weight: favourite! ? FaWeight.solid : FaWeight.light,
              color: favourite! ? colors.accentStrong : colors.foreground,
            ),
          ),
        if (onEdit != null)
          AppLinkButton(
            label: t.itemDetail.edit,
            onPressed: onEdit,
            fontSize: 17,
            weight: FontWeight.w600,
            horizontalPadding: 6,
          ),
        if (onMore != null)
          Builder(
            builder: (BuildContext anchor) => _BarButton(
              label: t.itemDetail.moreOptions,
              onTap: () => onMore!(anchor),
              child: Container(
                width: 28.r,
                height: 28.r,
                decoration: ShapeDecoration(
                  color: colors.secondary,
                  shape: const CircleBorder(),
                ),
                child: Center(
                  child: AppIcon(
                    AppIconName.ellipsis,
                    size: 18,
                    stroke: 2.25,
                    color: colors.foreground,
                  ),
                ),
              ),
            ),
          ),
      ],
    );

    return ValueListenableBuilder<double>(
      valueListenable: offset,
      builder: (BuildContext context, double scrolled, Widget? child) {
        final double progress = ((scrolled - nameTop) / 32.h).clamp(0, 1);
        return DecoratedBox(
          decoration: BoxDecoration(
            color: scrolled > 0 ? colors.background : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: scrolled > 0 ? colors.border : Colors.transparent,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: SizedBox(
              height: kItemBarHeight.h,
              child: Padding(
                padding: EdgeInsets.only(left: 2.w, right: 4.w),
                child: Row(
                  children: <Widget>[
                    AppLinkButton.back(
                      label: backLabel,
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    Expanded(
                      child: name == null
                          ? const SizedBox.shrink()
                          : Opacity(
                              opacity: reduceMotion
                                  ? (progress >= 1 ? 1 : 0)
                                  : progress,
                              child: Text(
                                name!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles(
                                  context,
                                ).navTitle().copyWith(color: colors.foreground),
                              ),
                            ),
                    ),
                    child!,
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: actions,
    );
  }
}

/// `.ib`: a 44 pt bar button.
class _BarButton extends StatelessWidget {
  const _BarButton({
    required this.label,
    required this.child,
    this.onTap,
    this.selected,
  });

  final String label;
  final Widget child;
  final VoidCallback? onTap;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      semanticLabel: label,
      toggled: selected,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: SizedBox.square(
        dimension: 44.r,
        child: Center(child: child),
      ),
    );
  }
}

/// Whether the item has an icon of its own: a picked one, or its website's.
bool _hasOwnIcon(VaultRow row) =>
    (row.item.iconGlyph?.isNotEmpty ?? false) || row.faviconUrls.isNotEmpty;
