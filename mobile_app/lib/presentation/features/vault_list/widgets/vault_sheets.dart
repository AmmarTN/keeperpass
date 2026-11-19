import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/item_summary.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet_parts.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_live_totp.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';
import 'package:keeperpass/presentation/features/vaults/pages/my_vaults_page.dart';

/// "GitHub, Slack and GitLab" — up to three names, else "5 items" (your
/// answer, Part 7).
String namesOf(List<VaultRow> rows) {
  final List<String> names = <String>[
    for (final VaultRow row in rows) rowName(row),
  ];
  return switch (names.length) {
    1 => names[0],
    2 => t.vaultList.listTwo(a: names[0], b: names[1]),
    3 => t.vaultList.listThree(a: names[0], b: names[1], c: names[2]),
    _ => t.vaultList.itemCount(n: names.length),
  };
}

/// The vault every row is in, or null when they come from several.
String? commonVaultLabel(List<VaultRow> rows) {
  final Set<String> labels = <String>{
    for (final VaultRow row in rows) row.vaultLabel,
  };
  return labels.length == 1 ? labels.first : null;
}

String _storage(BuildContext context) =>
    context.read<SessionCubit>().state.account?.provider.storageName ?? '';

// ---- The "Vaults" sheet

/// The scope sheet (board `U3-Vault-home` 01): All Vaults, Favorites,
/// Recently Used, each vault, Manage vaults.
Future<void> showScopeSheet(BuildContext context) {
  final VaultListCubit cubit = context.read<VaultListCubit>();
  final String storage = _storage(context);
  final NavigatorState tab = Navigator.of(context);
  return showAppSheet<void>(
    context,
    builder: (BuildContext sheet) => BlocProvider<VaultListCubit>.value(
      value: cubit,
      child: BlocBuilder<VaultListCubit, VaultListState>(
        builder: (BuildContext context, VaultListState state) {
          final VaultListView view = state.view;
          void pick(VaultScope scope, {String? vaultId}) {
            cubit.setScope(scope, vaultId: vaultId);
            Navigator.of(sheet).pop();
          }

          final AppColors colors = context.colors;
          return AppSheet(
            title: t.vaultList.scopeTitle,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12.h,
              children: <Widget>[
                AppInsetGroup.sheet(
                  children: <Widget>[
                    AppSheetRow(
                      leading: const AppIcon(AppIconName.layers),
                      label: t.vaultList.allVaults,
                      count: view.total,
                      selected: state.scope == VaultScope.all,
                      onTap: () => pick(VaultScope.all),
                    ),
                    AppSheetRow(
                      leading: const AppIcon(AppIconName.star),
                      label: t.vaultList.favorites,
                      count: view.favouriteCount,
                      selected: state.scope == VaultScope.favourites,
                      onTap: () => pick(VaultScope.favourites),
                    ),
                    AppSheetRow(
                      leading: const AppIcon(AppIconName.rotateCcwClock),
                      label: t.vaultList.recentlyUsed,
                      count: view.recentCount,
                      selected: state.scope == VaultScope.recent,
                      onTap: () => pick(VaultScope.recent),
                    ),
                  ],
                ),
                AppInsetGroup.sheet(
                  children: <Widget>[
                    for (final Vault vault in view.vaults)
                      AppSheetRow(
                        leading: FaGlyph(
                          FaGlyphs.vault,
                          size: 17,
                          color:
                              state.scope == VaultScope.vault &&
                                  state.vaultId == vault.id
                              ? colors.accentStrong
                              : colors.mutedForeground,
                        ),
                        label: vault.name,
                        count: view.vaultCounts[vault.id] ?? 0,
                        selected:
                            state.scope == VaultScope.vault &&
                            state.vaultId == vault.id,
                        onTap: () => pick(VaultScope.vault, vaultId: vault.id),
                      ),
                  ],
                ),
                AppInsetGroup.sheet(
                  children: <Widget>[
                    AppSheetRow(
                      leading: const AppIcon(AppIconName.settings2),
                      label: t.vaultList.manageVaults,
                      chevron: true,
                      onTap: () {
                        Navigator.of(sheet).pop();
                        tab.push(
                          MaterialPageRoute<void>(
                            builder: (_) =>
                                MyVaultsPage(backLabel: scopeTitle(state)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.w,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: AppIcon(
                          AppIconName.cloudCheck,
                          size: 16,
                          stroke: 2,
                          color: colors.accentStrong,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          t.vaultList.scopeNote(storage: storage),
                          style: AppTextStyles(
                            context,
                          ).secondary().copyWith(color: colors.mutedForeground),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          );
        },
      ),
    ),
  );
}

// ---- The quick sheet

/// Long-press (board `U3-Vault-actions` 04): the item, its fields as
/// tap-to-copy chips (the web's row chips), and every other action.
Future<void> showQuickSheet(BuildContext context, VaultRow row) {
  final VaultListCubit cubit = context.read<VaultListCubit>();
  final BuildContext list = context;
  return showAppSheet<void>(
    context,
    builder: (BuildContext sheet) => BlocProvider<VaultListCubit>.value(
      value: cubit,
      child: _QuickSheet(row: row, list: list),
    ),
  );
}

class _QuickSheet extends StatelessWidget {
  const _QuickSheet({required this.row, required this.list});

  final VaultRow row;

  /// The list's context, for what happens after the sheet closes.
  final BuildContext list;

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    // The row as it is now (favorite changes while the sheet is open).
    final VaultRow current = context.select(
      (VaultListCubit c) => c.state.view.rows.firstWhere(
        (VaultRow r) => r.id == row.id,
        orElse: () => row,
      ),
    );
    final Field? website = current.item.fields
        .where(
          (Field f) => f.type == FieldType.url && f.value.trim().isNotEmpty,
        )
        .firstOrNull;
    final NavigatorState navigator = Navigator.of(context);

    return Semantics(
      label: t.vaultList.quickActions(name: rowName(current)),
      child: AppSheet(
        showClose: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 14.h,
          children: <Widget>[
            AppQuickHeader(
              tile: VaultItemTile(current),
              name: rowName(current),
              subtitle: rowSubtitle(current),
              trailing: current.favourite
                  ? AppPill.vault(
                      t.vaultList.favorite,
                      tone: AppPillTone.accent,
                      leading: const FaGlyph(
                        FaGlyphs.favourite,
                        size: 11,
                        weight: FaWeight.solid,
                      ),
                    )
                  : null,
            ),
            if (current.item.fields.isNotEmpty) _FieldChips(row: current),
            AppInsetGroup(
              flat: true,
              children: <Widget>[
                if (website != null)
                  AppQuickActionRow(
                    icon: AppIconName.externalLink,
                    label: t.vaultList.openWebsite,
                    onTap: () {
                      navigator.pop();
                      cubit.openWebsite(website.value);
                    },
                  ),
                AppQuickActionRow(
                  icon: AppIconName.star,
                  label: current.favourite
                      ? t.vaultList.removeFromFavorites
                      : t.vaultList.addToFavorites,
                  onTap: () => cubit.toggleFavourite(current.id),
                ),
                AppQuickActionRow(
                  icon: AppIconName.folderInput,
                  label: t.vaultList.moveToVault,
                  onTap: () {
                    navigator.pop();
                    showMoveSheet(list, cubit, <VaultRow>[current]);
                  },
                ),
                AppQuickActionRow(
                  icon: AppIconName.circleCheck,
                  label: t.vaultList.select,
                  onTap: () {
                    navigator.pop();
                    cubit.startSelecting(current.id);
                  },
                ),
                AppQuickActionRow(
                  icon: AppIconName.trash,
                  label: t.vaultList.delete,
                  destructive: true,
                  onTap: () async {
                    navigator.pop();
                    if (await confirmDeleteItem(list, current)) {
                      await cubit.deleteItems(<String>[current.id]);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The fields as two columns of chips; a copied chip says "Copied" for 1 s.
class _FieldChips extends StatefulWidget {
  const _FieldChips({required this.row});

  final VaultRow row;

  @override
  State<_FieldChips> createState() => _FieldChipsState();
}

class _FieldChipsState extends State<_FieldChips> {
  int? _copied;
  Timer? _reset;

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  Future<void> _copy(int index, Field field) async {
    await copyRowField(
      context,
      widget.row,
      field,
      fallbackLabel: t.vaultList.unnamed,
    );
    if (!mounted) return;
    setState(() => _copied = index);
    _reset?.cancel();
    _reset = Timer(const Duration(seconds: 1), () {
      if (mounted) setState(() => _copied = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Field> fields = widget.row.item.fields;
    final String locale = LocaleSettings.currentLocale.languageCode;
    final List<Widget> chips = <Widget>[
      for (int i = 0; i < fields.length; i++)
        AppFieldChip(
          glyph: _glyphOf(fields[i]),
          label: _copied == i
              ? t.common.copied
              : (fields[i].name.isEmpty ? t.vaultList.unnamed : fields[i].name),
          semanticLabel: '${t.common.copy} ${fields[i].name}',
          value: _valueOf(fields[i], locale),
          onTap: () => _copy(i, fields[i]),
        ),
    ];
    return Column(
      spacing: 8.h,
      children: <Widget>[
        for (int i = 0; i < chips.length; i += 2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: <Widget>[
              Expanded(child: chips[i]),
              Expanded(
                child: i + 1 < chips.length
                    ? chips[i + 1]
                    : const SizedBox.shrink(),
              ),
            ],
          ),
      ],
    );
  }

  static int _glyphOf(Field field) {
    final String? picked = field.iconGlyph;
    final int? codePoint = picked == null
        ? null
        : int.tryParse(picked, radix: 16);
    return codePoint ?? FaGlyphs.byName[field.type.icon] ?? FaGlyphs.note;
  }

  /// Secrets masked (web: "Chips always mask secrets"), a 2FA field as its
  /// live code.
  static Widget _valueOf(Field field, String locale) {
    if (field.value.isEmpty) return Text(t.common.empty);
    if (field.type == FieldType.totp) return _LiveCode(secret: field.value);
    if (field.isSecret) {
      return Text(maskFieldValue(field.value.split('\n').first));
    }
    return Text(fieldSummaryText(field, locale: locale));
  }
}

/// The current 2FA code and its ring, ticking each second.
class _LiveCode extends StatelessWidget {
  const _LiveCode({required this.secret});

  final String secret;

  @override
  Widget build(BuildContext context) {
    return AppLiveTotp(
      secret: secret,
      builder: (BuildContext context, String? code, int secondsLeft) {
        if (code == null) return const Text('—');
        // `.mono` in the chip, split in halves as the web shows it.
        return RepaintBoundary(
          child: Semantics(
            label: t.totp.secondsLeft(count: secondsLeft),
            child: Row(
              spacing: 8.w,
              children: <Widget>[
                Text(
                  splitTotpCode(code),
                  style: AppTextStyles(context)
                      .fileName()
                      .resized(15, line: 20, weight: FontWeight.w700)
                      .copyWith(color: context.colors.foreground),
                ),
                ExcludeSemantics(
                  child: AppTotpRing(secondsLeft: secondsLeft, size: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---- Delete

/// One item, from the quick sheet (board `U3-Item-detail`: "Delete Item").
Future<bool> confirmDeleteItem(BuildContext context, VaultRow row) =>
    showAppDialog(
      context,
      icon: AppIconName.trash,
      tone: AppDialogTone.solid,
      title: t.vaultList.deleteItemTitle,
      message: t.vaultList.deleteItemConfirm(name: rowName(row)),
      confirmLabel: t.vaultList.deleteItemAction,
    );

/// Several, from selection (board `U3-Vault-actions` 05): names what goes
/// and from where — the one solid red button.
Future<bool> confirmDeleteItems(BuildContext context, List<VaultRow> rows) {
  final int n = rows.length;
  final String names = namesOf(rows);
  final String? vault = commonVaultLabel(rows);
  return showAppDialog(
    context,
    icon: AppIconName.trash,
    tone: AppDialogTone.solid,
    title: t.vaultList.deleteTitle(n: n),
    message: vault == null
        ? t.vaultList.deleteFromVaults(n: n, names: names)
        : t.vaultList.deleteFromVault(n: n, names: names, vault: vault),
    confirmLabel: t.vaultList.deleteItems(n: n),
  );
}

// ---- Move

/// Picks a destination (boards `U3-Vault-actions` 06, `U3-Generate-move`):
/// one tap moves; the vault every item is already in is marked Current and
/// can't be picked; New vault… makes one and moves into it. With a single
/// vault it explains itself and offers to make a second.
Future<void> showMoveSheet(
  BuildContext context,
  ItemMover mover,
  List<VaultRow> rows,
) {
  final BuildContext origin = context;
  return showAppSheet<void>(
    context,
    builder: (BuildContext sheet) =>
        _MoveSheet(mover: mover, rows: rows, origin: origin),
  );
}

/// What the Move sheet needs from the screen that opens it — the list
/// (selection, quick sheet) or an item's More menu.
abstract interface class ItemMover {
  List<Vault> get vaults;

  /// How many items each vault holds.
  Map<String, int> get vaultCounts;

  /// False when nothing moved.
  Future<bool> moveItems(List<String> itemIds, String vaultId);

  /// "New vault…": null when nothing changed.
  Future<Vault?> moveItemsToNewVault(List<String> itemIds, String name);
}

class _MoveSheet extends StatelessWidget {
  const _MoveSheet({
    required this.mover,
    required this.rows,
    required this.origin,
  });

  final ItemMover mover;
  final List<VaultRow> rows;

  /// The opening screen's context, for the toast after the sheet closes.
  final BuildContext origin;

  @override
  Widget build(BuildContext context) {
    final List<Vault> vaults = mover.vaults;
    final Map<String, int> counts = mover.vaultCounts;
    final NavigatorState navigator = Navigator.of(context);
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool one = rows.length == 1;
    final Set<String> from = <String>{
      for (final VaultRow row in rows) row.item.vaultId,
    };
    final String? current = from.length == 1 ? from.first : null;
    final List<String> ids = <String>[for (final VaultRow row in rows) row.id];

    Future<void> moveTo(Vault vault) async {
      navigator.pop();
      if (await mover.moveItems(ids, vault.id) && origin.mounted) {
        showMovedToast(origin, rows, vault.name);
      }
    }

    Future<void> newVault() async {
      navigator.pop();
      final String? name = await showNewVaultSheet(origin, vaults);
      if (name == null) return;
      final Vault? vault = await mover.moveItemsToNewVault(ids, name);
      if (vault != null && origin.mounted) {
        showMovedToast(origin, rows, vault.name);
      }
    }

    if (vaults.length < 2) {
      return AppSheet(
        title: one
            ? t.vaultList.moveToVaultTitle
            : t.vaultList.moveItemsTitle(n: rows.length),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 6.h),
            const Center(
              child: AppIconTile(
                AppTileGlyph(FaGlyphs.vault),
                size: AppTileSize.empty,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              one ? t.vaultList.noOtherVaultOne : t.vaultList.noOtherVaultMany,
              textAlign: TextAlign.center,
              style: styles
                  .bodyStrong()
                  .resized(17, line: 24, weight: FontWeight.w700)
                  .copyWith(color: colors.foreground),
            ),
            SizedBox(height: 8.h),
            Text(
              t.vaultList.noOtherVaultDetail,
              textAlign: TextAlign.center,
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            ),
            SizedBox(height: 18.h),
            AppButton(
              label: t.vaultList.createAVault,
              icon: AppIconName.plus,
              onPressed: newVault,
            ),
            SizedBox(height: 8.h),
            AppButton(
              label: t.common.cancel,
              variant: AppButtonVariant.secondary,
              onPressed: navigator.pop,
            ),
            SizedBox(height: 4.h),
          ],
        ),
      );
    }

    return AppSheet(
      title: one
          ? t.vaultList.moveToVaultTitle
          : t.vaultList.moveItemsTitle(n: rows.length),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              one
                  ? '${t.vaultList.moveDescription} '
                        '${t.vaultList.moveLine(n: 1, names: namesOf(rows))}'
                  : t.vaultList.moveLine(n: rows.length, names: namesOf(rows)),
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            ),
          ),
          AppInsetGroup.sheet(
            children: <Widget>[
              for (final Vault vault in vaults)
                if (vault.id == current)
                  Opacity(
                    opacity: 0.5,
                    child: AppSheetRow(
                      leading: FaGlyph(
                        FaGlyphs.vault,
                        size: 17,
                        color: colors.mutedForeground,
                      ),
                      label: vault.name,
                      trailingText: t.vaultList.current,
                      onTap: null,
                    ),
                  )
                else
                  AppSheetRow(
                    leading: FaGlyph(
                      FaGlyphs.vault,
                      size: 17,
                      color: colors.accentStrong,
                    ),
                    label: vault.name,
                    count: counts[vault.id] ?? 0,
                    onTap: () => moveTo(vault),
                  ),
              AppSheetRow(
                leading: AppIcon(
                  AppIconName.plus,
                  stroke: 2,
                  color: colors.accentStrong,
                ),
                label: t.vaultList.newVaultOption,
                onTap: newVault,
              ),
            ],
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}

/// "Moved 3 items to My Vault" (board `U3-Vault-actions` 06).
void showMovedToast(BuildContext context, List<VaultRow> rows, String vault) {
  final int n = rows.length;
  AppToastHost.of(context).show(
    AppToastData(
      icon: AppIconName.folderInput,
      title: t.vaultList.movedTitle(n: n, names: namesOf(rows), vault: vault),
      detail: t.vaultList.movedDetail(n: n),
    ),
  );
}

// ---- New vault

/// "New Vault" (board `Vaults`): a name only; a name already in use is
/// caught as it is typed (web `CreateVaultDialog`). Resolves to the name.
Future<String?> showNewVaultSheet(BuildContext context, List<Vault> vaults) =>
    showAppSheet<String>(
      context,
      builder: (BuildContext sheet) => _NewVaultSheet(vaults: vaults),
    );

class _NewVaultSheet extends StatefulWidget {
  const _NewVaultSheet({required this.vaults});

  final List<Vault> vaults;

  @override
  State<_NewVaultSheet> createState() => _NewVaultSheetState();
}

class _NewVaultSheetState extends State<_NewVaultSheet> {
  final TextEditingController _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  String get _trimmed => _name.text.trim();

  bool get _duplicate =>
      _trimmed.isNotEmpty && widget.vaults.any((Vault v) => v.name == _trimmed);

  bool get _canCreate => _trimmed.isNotEmpty && !_duplicate;

  void _create() {
    if (!_canCreate) return;
    AppHaptics.selection();
    Navigator.of(context).pop(_trimmed);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppSheet(
      title: t.vaultList.newVaultTitle,
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14.h,
        children: <Widget>[
          Text(
            t.vaultList.newVaultBody,
            style: AppTextStyles(context)
                .body()
                .resized(15, line: 22)
                .copyWith(color: colors.mutedForeground),
          ),
          AppTextField(
            controller: _name,
            label: t.vaultList.vaultName,
            autofocus: true,
            textInputAction: TextInputAction.done,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(InputLimits.vaultName),
            ],
            errorText: _duplicate ? t.vaultList.duplicateVault : null,
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _create(),
          ),
          AppButton(
            label: t.createVault.create,
            onPressed: _canCreate ? _create : null,
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
