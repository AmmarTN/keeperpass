import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/utils/items/item_icon.dart';
import 'package:keeperpass/core/utils/items/item_sections.dart';
import 'package:keeperpass/core/utils/items/item_summary.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/copied_toast.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_menu.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_favorites_strip.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_item_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_swipe_actions.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/item_detail_page.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_sheets.dart';

/// The name a row shows; an unnamed item still needs one (web
/// `displayName`).
String rowName(VaultRow row) =>
    row.item.name.isEmpty ? t.vaultList.unnamed : row.item.name;

/// "janedoe-dev · Work": the first field that can be shown, then the vault.
String rowSubtitle(VaultRow row) => <String>[
  ?row.summary,
  if (row.vaultLabel.isNotEmpty) row.vaultLabel,
].join(' · ');

/// "Weak and reused password", for the red marker.
String? findingLabel(List<AuditType> findings) {
  final bool weak = findings.contains(AuditType.weakPassword);
  final bool reused = findings.contains(AuditType.reusedPassword);
  final bool compromised = findings.contains(AuditType.compromisedPassword);
  return switch ((weak, reused, compromised)) {
    (false, false, false) => null,
    (true, false, false) => t.vaultList.findingWeak,
    (false, true, false) => t.vaultList.findingReused,
    (false, false, true) => t.vaultList.findingCompromised,
    (true, true, false) => t.vaultList.findingWeakReused,
    (true, false, true) => t.vaultList.findingWeakCompromised,
    (false, true, true) => t.vaultList.findingReusedCompromised,
    (true, true, true) => t.vaultList.findingAll,
  };
}

/// "Copy password for GitHub".
String copyLabelFor(MainSecret secret, String name) => switch (secret.kind) {
  MainSecretKind.password => t.vaultList.copyPasswordFor(name: name),
  MainSecretKind.code => t.vaultList.copyCodeFor(name: name),
  MainSecretKind.cardNumber => t.vaultList.copyCardNumberFor(name: name),
};

/// The short name of what the copy button copies (swipe labels, toasts).
String secretLabel(MainSecretKind kind) => switch (kind) {
  MainSecretKind.password => t.vaultList.swipePassword,
  MainSecretKind.code => t.vaultList.swipeCode,
  MainSecretKind.cardNumber => t.vaultList.swipeCardNumber,
};

/// Copies [field] with a light haptic and the toast that says what went
/// where (web `ClipboardService`: "{field} copied", "From {item}").
Future<void> copyRowField(
  BuildContext context,
  VaultRow row,
  Field field, {
  required String fallbackLabel,
}) async {
  final AppToastHostState toasts = AppToastHost.of(context);
  final Copied? copied = await context.read<VaultListCubit>().copy(
    row.id,
    field,
  );
  if (copied == null) return;
  unawaited(AppHaptics.copy());
  toasts.show(
    copiedToast(
      title: t.vaultList.fieldCopied(
        field: field.name.isEmpty ? fallbackLabel : field.name,
      ),
      from: t.vaultList.copiedFrom(item: rowName(row)),
      clearsIn: copied.clearsIn,
    ),
  );
}

/// Opens an item over the tab bar, back to this list's title; its tags
/// filter this list.
void openRow(BuildContext context, VaultRow row) {
  final VaultListCubit list = context.read<VaultListCubit>();
  openItem(
    context,
    itemId: row.id,
    backLabel: scopeTitle(list.state),
    onShowTag: list.showTag,
  );
}

/// An item's tile (web `ItemRow`): a picked icon wins; then the site's
/// favicon on white, its first letter until it loads (and if none does);
/// then the glyph for what the item is.
class VaultItemTile extends StatelessWidget {
  const VaultItemTile(this.row, {this.size = AppTileSize.item, super.key});

  final VaultRow row;

  /// [AppTileSize.large] in the item screen's header.
  final AppTileSize size;

  @override
  Widget build(BuildContext context) {
    final String? picked = row.item.iconGlyph;
    if (picked != null && picked.isNotEmpty) {
      final int? codePoint = int.tryParse(picked, radix: 16);
      if (codePoint != null) {
        return AppIconTile(AppTileGlyph(codePoint), size: size);
      }
    }
    if (row.faviconUrls.isNotEmpty) {
      return _FaviconTile(
        urls: row.faviconUrls,
        letter: rowName(row).characters.first.toUpperCase(),
        size: size,
      );
    }
    return AppIconTile(
      AppTileGlyph(FaGlyphs.byName[itemIconName(row.item)] ?? FaGlyphs.note),
      size: size,
    );
  }
}

class _FaviconTile extends StatefulWidget {
  const _FaviconTile({
    required this.urls,
    required this.letter,
    required this.size,
  });

  final List<String> urls;
  final String letter;
  final AppTileSize size;

  @override
  State<_FaviconTile> createState() => _FaviconTileState();
}

class _FaviconTileState extends State<_FaviconTile> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final Widget letter = AppIconTile(
      AppTileLetter(widget.letter),
      size: widget.size,
      tone: AppTileTone.white,
    );
    if (_index >= widget.urls.length) return letter;
    // The favicon fills the tile less its padding (`.fav img`: 6 pt at
    // 40 pt, scaled with the tile).
    final double inset = 12 * widget.size.dimension / 40;
    final double size = (widget.size.dimension - inset).r;
    return Image.network(
      widget.urls[_index],
      width: size,
      height: size,
      fit: BoxFit.contain,
      // The letter shows until the icon has loaded.
      frameBuilder:
          (BuildContext context, Widget image, int? frame, bool synchronous) =>
              frame == null && !synchronous
              ? letter
              : AppIconTile(
                  AppTileChild(image),
                  size: widget.size,
                  tone: AppTileTone.white,
                ),
      errorBuilder: (BuildContext context, Object error, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _index++);
        });
        return letter;
      },
    );
  }
}

/// One item in the list: tap opens it, the trailing button copies its main
/// secret, long-press opens the quick sheet, swiping left copies (board
/// `U3-Vault-actions` 04) and swiping right stars it.
class VaultItemRow extends StatelessWidget {
  const VaultItemRow({
    required this.row,
    this.highlight = const <String>[],
    super.key,
  });

  final VaultRow row;
  final List<String> highlight;

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    final bool selecting = context.select(
      (VaultListCubit c) => c.state.selecting,
    );
    final bool selected = context.select(
      (VaultListCubit c) => c.state.selected.contains(row.id),
    );
    final String name = rowName(row);
    final MainSecret? secret = row.mainSecret;
    final Field? username = row.username;

    final Widget item = AppItemRow(
      tile: VaultItemTile(row),
      name: name,
      subtitle: rowSubtitle(row),
      favorite: row.favourite,
      findingLabel: findingLabel(row.findings),
      firstTag: row.item.tags.isEmpty ? null : row.item.tags.first,
      moreTags: math.max(row.item.tags.length - 1, 0),
      copyLabel: secret == null ? null : copyLabelFor(secret, name),
      onCopy: secret == null
          ? null
          : () => copyRowField(
              context,
              row,
              secret.field,
              fallbackLabel: secretLabel(secret.kind),
            ),
      onTap: selecting
          ? () => cubit.toggleSelected(row.id)
          : () => openRow(context, row),
      onLongPress: selecting ? null : () => showQuickSheet(context, row),
      selected: selecting ? selected : null,
      highlight: highlight,
    );
    if (selecting) return item;

    return AppSwipeActions(
      // A full swipe copies the main secret, when there is one.
      fullSwipe: secret != null,
      leadingAction: AppSwipeAction(
        icon: AppIconName.star,
        label: t.vaultList.favorite,
        semanticLabel: row.favourite
            ? t.vaultList.removeFromFavorites
            : t.vaultList.addToFavorites,
        onPressed: () => cubit.toggleFavourite(row.id),
      ),
      actions: <AppSwipeAction>[
        if (secret != null)
          AppSwipeAction(
            icon: AppIconName.copy,
            label: secretLabel(secret.kind),
            semanticLabel: switch (secret.kind) {
              MainSecretKind.password => t.vaultList.copyPassword,
              MainSecretKind.code => t.vaultList.copyCode,
              MainSecretKind.cardNumber => t.vaultList.copyCardNumber,
            },
            tone: AppSwipeTone.primary,
            onPressed: () => copyRowField(
              context,
              row,
              secret.field,
              fallbackLabel: secretLabel(secret.kind),
            ),
          ),
        if (username != null)
          AppSwipeAction(
            icon: AppIconName.userRound,
            label: t.vaultList.swipeUsername,
            semanticLabel: t.vaultList.copyUsername,
            tone: AppSwipeTone.accent,
            onPressed: () => copyRowField(
              context,
              row,
              username,
              fallbackLabel: t.vaultList.swipeUsername,
            ),
          ),
        AppSwipeAction(
          icon: AppIconName.ellipsis,
          label: t.vaultList.swipeMore,
          semanticLabel: t.vaultList.moreActions,
          tone: AppSwipeTone.neutral,
          onPressed: () => showQuickSheet(context, row),
        ),
      ],
      child: item,
    );
  }
}

/// A group of rows in the list card (`.lst`): built lazily, the card drawn
/// around the group, each row clipped at the card's corners.
class VaultRowsSliver extends StatelessWidget {
  const VaultRowsSliver({
    required this.rows,
    this.highlight = const <String>[],
    super.key,
  });

  final List<VaultRow> rows;
  final List<String> highlight;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double radius = AppRadius.xxl;
    final OutlinedBorder shape = AppRadius.shape(context, radius);
    return DecoratedSliver(
      decoration: ShapeDecoration(
        color: colors.card,
        shape: shape,
        shadows: <BoxShadow>[
          ...context.shadows.shadowXs,
          BoxShadow(color: colors.hairline, spreadRadius: 1),
        ],
      ),
      sliver: SliverList.builder(
        itemCount: rows.length,
        itemBuilder: (BuildContext context, int index) {
          final bool first = index == 0;
          final bool last = index == rows.length - 1;
          final BorderRadius corners = BorderRadius.vertical(
            top: Radius.circular(first ? radius.r : 0),
            bottom: Radius.circular(last ? radius.r : 0),
          );
          final Widget row = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!first)
                Padding(
                  padding: EdgeInsets.only(left: AppDividerInset.item.w),
                  child: SizedBox(
                    height: 1,
                    child: ColoredBox(color: colors.border),
                  ),
                ),
              VaultItemRow(
                key: ValueKey<String>(rows[index].id),
                row: rows[index],
                highlight: highlight,
              ),
            ],
          );
          return shape is RoundedSuperellipseBorder
              ? ClipRSuperellipse(borderRadius: corners, child: row)
              : ClipRRect(borderRadius: corners, child: row);
        },
      ),
    );
  }
}

/// A section's label ("TODAY"), with the sort button on the first one
/// (board `U3-Vault-home` 02: "sort lives on the first section header").
class VaultSectionHeader extends StatelessWidget {
  const VaultSectionHeader({
    required this.label,
    this.showSort = false,
    this.icon,
    super.key,
  });

  final String label;
  final bool showSort;
  final AppIconName? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h, bottom: 6.h),
      child: AppSectionLabel(
        label,
        icon: icon,
        trailing: showSort ? const _SortButton() : null,
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton();

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    final ItemSort sort = context.select((VaultListCubit c) => c.state.sort);
    return Builder(
      builder: (BuildContext anchor) => AppSortButton(
        label: sortLabel(sort),
        onPressed: () async {
          final ItemSort? picked = await showAppMenu<ItemSort>(
            anchor,
            heading: t.vaultList.sortHeading,
            selected: sort,
            items: <AppMenuItem<ItemSort>>[
              for (final ItemSort option in ItemSort.values)
                AppMenuItem<ItemSort>(value: option, label: sortLabel(option)),
            ],
          );
          if (picked != null) cubit.setSort(picked);
        },
      ),
    );
  }
}

String sortLabel(ItemSort sort) => switch (sort) {
  ItemSort.newestFirst => t.vaultList.newestFirst,
  ItemSort.oldestFirst => t.vaultList.oldestFirst,
  ItemSort.aToZ => t.vaultList.aToZ,
};

String sectionLabel(ItemSectionKind kind) => switch (kind) {
  ItemSectionKind.today => t.vaultList.today,
  ItemSectionKind.thisWeek => t.vaultList.thisWeek,
  ItemSectionKind.earlier => t.vaultList.earlier,
  ItemSectionKind.aToZ => t.vaultList.aToZ,
};

/// The Favorites strip (board `U3-Vault-home` 01): each card copies its
/// main secret.
class VaultFavoritesStrip extends StatelessWidget {
  const VaultFavoritesStrip({required this.rows, super.key});

  final List<VaultRow> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        VaultSectionHeader(
          label: t.vaultList.favorites,
          icon: AppIconName.star,
        ),
        AppFavoritesStrip(
          children: <Widget>[
            for (final VaultRow row in rows)
              AppFavoriteCard(
                key: ValueKey<String>(row.id),
                tile: VaultItemTile(row),
                name: rowName(row),
                subtitle: row.summary ?? row.vaultLabel,
                copyLabel: row.mainSecret == null
                    ? rowName(row)
                    : copyLabelFor(row.mainSecret!, rowName(row)),
                onCopy: () {
                  final MainSecret? secret = row.mainSecret;
                  if (secret == null) return;
                  copyRowField(
                    context,
                    row,
                    secret.field,
                    fallbackLabel: secretLabel(secret.kind),
                  );
                },
                onTap: () => openRow(context, row),
              ),
          ],
        ),
      ],
    );
  }
}
