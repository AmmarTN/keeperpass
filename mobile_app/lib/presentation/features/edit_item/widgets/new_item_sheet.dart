import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/items/item_templates.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet_parts.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_segmented_control.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/edit_labels.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/edit_sheets.dart';

/// Up to this many vaults are picked with segments; more open a list (your
/// answer, Part 9).
const int kVaultSegmentsMax = 3;

/// "New Vault Item" (board `S3-37`): the vault — the one in view, else your
/// own — and nine templates; choosing one starts the item. Resolves to the
/// vault and template, or null when closed.
Future<({String vaultId, ItemTemplate template})?> showNewItemSheet(
  BuildContext context, {
  required List<Vault> vaults,
  required String initialVaultId,
}) => showAppSheet<({String vaultId, ItemTemplate template})>(
  context,
  builder: (_) => _NewItemSheet(vaults: vaults, initialVaultId: initialVaultId),
);

class _NewItemSheet extends StatefulWidget {
  const _NewItemSheet({required this.vaults, required this.initialVaultId});

  final List<Vault> vaults;
  final String initialVaultId;

  @override
  State<_NewItemSheet> createState() => _NewItemSheetState();
}

class _NewItemSheetState extends State<_NewItemSheet> {
  late String _vaultId = widget.initialVaultId;

  Future<void> _pickVault() async {
    final String? picked = await showAppSheet<String>(
      context,
      builder: (BuildContext sheet) => AppSheet(
        title: t.editItem.vault,
        child: AppInsetGroup.sheet(
          children: <Widget>[
            for (final Vault vault in widget.vaults)
              AppSheetRow(
                leading: FaGlyph(
                  FaGlyphs.vault,
                  size: 17,
                  color: context.colors.accentStrong,
                ),
                label: vault.name,
                selected: vault.id == _vaultId,
                onTap: () => Navigator.of(sheet).pop(vault.id),
              ),
          ],
        ),
      ),
    );
    if (picked != null && mounted) setState(() => _vaultId = picked);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final List<Vault> vaults = widget.vaults;
    final Vault current = vaults.firstWhere(
      (Vault v) => v.id == _vaultId,
      orElse: () => vaults.first,
    );

    return AppSheet(
      title: t.editItem.newVaultItem,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10.h,
        children: <Widget>[
          // With one vault there is nothing to choose.
          if (vaults.length > 1) ...<Widget>[
            _Label(t.editItem.vault),
            if (vaults.length <= kVaultSegmentsMax)
              AppSegmentedControl<String>(
                semanticLabel: t.editItem.vault,
                segments: <AppSegment<String>>[
                  for (final Vault vault in vaults)
                    AppSegment<String>(vault.id, vault.name),
                ],
                selected: current.id,
                onChanged: (String id) => setState(() => _vaultId = id),
              )
            else
              _VaultButton(name: current.name, onTap: _pickVault),
          ],
          Padding(
            padding: EdgeInsets.only(top: vaults.length > 1 ? 6.h : 0),
            child: _Label(t.editItem.template),
          ),
          _TemplateGrid(
            onPick: (ItemTemplate template) => Navigator.of(
              context,
            ).pop((vaultId: current.id, template: template)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              t.editItem.templateNote,
              textAlign: TextAlign.center,
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            ),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}

/// `.sl`: the uppercase label above a choice.
class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: AppTextStyles(
      context,
    ).sectionLabel().copyWith(color: context.colors.mutedForeground),
  );
}

/// The chosen vault when there are too many for segments.
class _VaultButton extends StatelessWidget {
  const _VaultButton({required this.name, required this.onTap});

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final BorderRadius radius = BorderRadius.circular(12.r);
    return AppPressable(
      onTap: onTap,
      semanticLabel: '${t.editItem.vault}: $name',
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: Container(
        height: 48.h,
        padding: EdgeInsets.only(left: 14.w, right: 12.w),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: radius,
          border: Border.all(color: colors.hairline),
        ),
        child: Row(
          spacing: 10.w,
          children: <Widget>[
            FaGlyph(FaGlyphs.vault, size: 17, color: colors.accentStrong),
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(
                  context,
                ).body().copyWith(color: colors.foreground),
              ),
            ),
            AppIcon(
              AppIconName.chevronDown,
              size: 16,
              stroke: 2.25,
              color: colors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}

/// `.tgrid` of `.ttile`s, three across.
class _TemplateGrid extends StatelessWidget {
  const _TemplateGrid({required this.onPick});

  final ValueChanged<ItemTemplate> onPick;

  @override
  Widget build(BuildContext context) => TileGrid(
    columns: 3,
    count: kItemTemplates.length,
    cell: (int i, double width) => _TemplateTile(
      template: kItemTemplates[i],
      width: width,
      onTap: () => onPick(kItemTemplates[i]),
    ),
  );
}

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.width,
    required this.onTap,
  });

  final ItemTemplate template;

  /// The cell's width, for the label.
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final BorderRadius radius = BorderRadius.circular(14.r);
    return AppPressable(
      onTap: onTap,
      semanticLabel: '${templateLabel(template)}, ${templateHint(template)}',
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: Container(
        constraints: BoxConstraints(minHeight: 112.h),
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
            AppIconTile(
              AppTileGlyph(FaGlyphs.byName[template.icon] ?? FaGlyphs.note),
              size: AppTileSize.card,
            ),
            TileLabel(
              templateLabel(template),
              maxWidth: width - 8.w - 2,
              style: styles
                  .badge()
                  .resized(12, line: 15, weight: FontWeight.w700)
                  .copyWith(color: colors.foreground),
            ),
            Text(
              templateHint(template),
              textAlign: TextAlign.center,
              style: styles
                  .badge()
                  .resized(11, line: 14, weight: FontWeight.w600)
                  .copyWith(color: colors.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}
