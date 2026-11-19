import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/core/utils/items/item_icon.dart';
import 'package:keeperpass/core/utils/items/item_templates.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/edit_labels.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/edit_sheets.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/field_editor.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/new_item_sheet.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/tag_editor.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/item_detail_page.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// "+" in the Vault header (board `S3-37`): the vault in view, else your
/// own (your answer, Part 9), and a template; then the new item in edit
/// mode. After Save it opens like any item, back to [backLabel].
Future<void> openNewItem(
  BuildContext context, {
  required List<Vault> vaults,
  required String? vaultInView,
  required String backLabel,
  ValueChanged<String>? onShowTag,
}) async {
  if (vaults.isEmpty) return;
  final String initial = vaults.any((Vault v) => v.id == vaultInView)
      ? vaultInView!
      : vaults
            .firstWhere(
              (Vault v) => v.id == kPersonalVaultId,
              orElse: () => vaults.first,
            )
            .id;
  final ({String vaultId, ItemTemplate template})? choice =
      await showNewItemSheet(context, vaults: vaults, initialVaultId: initial);
  if (choice == null || !context.mounted) return;
  await openNewItemFrom(
    context,
    vaultId: choice.vaultId,
    template: choice.template,
    backLabel: backLabel,
    onShowTag: onShowTag,
  );
}

/// The new item in edit mode, already on [template] — what choosing a
/// template in New Vault Item opens, and what Codes' "Create an
/// Authenticator item" opens directly (your answer, Part 10). A typed
/// [setupKey] (Part 15) is already in its first 2FA field.
Future<void> openNewItemFrom(
  BuildContext context, {
  required String vaultId,
  required ItemTemplate template,
  required String backLabel,
  ValueChanged<String>? onShowTag,
  String? setupKey,
}) => Navigator.of(context, rootNavigator: true).push(
  MaterialPageRoute<void>(
    fullscreenDialog: true,
    builder: (_) => EditItemPage.newItem(
      vaultId: vaultId,
      template: template,
      backLabel: backLabel,
      onShowTag: onShowTag,
      setupKey: setupKey,
    ),
  ),
);

/// What Save in Edit leaves behind: the item, its name, and its audit
/// running (a fix's toast waits for it — Part 11).
class EditSaved {
  const EditSaved({
    required this.itemId,
    required this.name,
    required this.recheck,
  });

  final String itemId;
  final String name;
  final Future<bool> recheck;
}

/// Edit on an item (and "Fix it in Edit"): over everything, Cancel and
/// Save in the bar. [focusField] (the field's position in the item) is
/// scrolled into view and drawn focused — "Fix it in Edit" passes the 2FA
/// field it came for (your answer, Part 10). With [generate], that field's
/// Generate sheet is already up instead ("Change password", board
/// `Fix-finding`). Null unless it was saved. Edit opens at once while the
/// check for a newer version runs alongside (your answer, 2026-11-05:
/// Dropbox's answer took 0.3–1.8 s on the phone); a newer version brings
/// "Your Vault Changed" over Edit (board `Sync-states`), and Save checks
/// again before writing. A newer version already known asks first, and Edit
/// does not open.
Future<EditSaved?> openEditItem(
  BuildContext context,
  String itemId, {
  int? focusField,
  bool generate = false,
}) async {
  final NavigatorState navigator = Navigator.of(context, rootNavigator: true);
  final SyncCubit? sync = context.read<SyncCubit?>();
  if (sync != null) {
    if (sync.state.phase == SyncPhase.conflict) {
      await sync.checkBeforeEditing();
      return null;
    }
    unawaited(sync.checkBeforeEditing());
  }
  return navigator.push(
    MaterialPageRoute<EditSaved>(
      fullscreenDialog: true,
      builder: (_) => EditItemPage.edit(
        itemId: itemId,
        focusField: focusField,
        generate: generate,
      ),
    ),
  );
}

/// The edit screen with its own cubit.
class EditItemPage extends StatelessWidget {
  const EditItemPage.newItem({
    required String this.vaultId,
    required ItemTemplate this.template,
    required this.backLabel,
    this.onShowTag,
    this.setupKey,
    super.key,
  }) : itemId = null,
       focusField = null,
       generate = false;

  const EditItemPage.edit({
    required String this.itemId,
    this.focusField,
    this.generate = false,
    super.key,
  }) : vaultId = null,
       template = null,
       backLabel = '',
       onShowTag = null,
       setupKey = null;

  final String? itemId;
  final int? focusField;
  final bool generate;
  final String? vaultId;
  final ItemTemplate? template;
  final String backLabel;
  final ValueChanged<String>? onShowTag;

  /// A new item's first 2FA field's key (a typed key from Codes, Part 15).
  final String? setupKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditItemCubit>(
      create: (_) {
        final EditItemCubit cubit = getIt<EditItemCubit>();
        final ItemTemplate? template = this.template;
        if (template == null) {
          cubit.startEdit(itemId!);
        } else {
          cubit.startNew(
            vaultId: vaultId!,
            icon: template.icon,
            fields: <({FieldType type, String name})>[
              for (final TemplateField field in template.fields)
                (type: field.type, name: templateFieldName(field)),
            ],
          );
          final String? key = setupKey;
          final EditableField? totp = cubit.state.fields
              .where((EditableField f) => f.type == FieldType.totp)
              .firstOrNull;
          if (key != null && totp != null) cubit.setFieldValue(totp.key, key);
        }
        return cubit;
      },
      child: EditItemScreen(
        backLabel: backLabel,
        onShowTag: onShowTag,
        focusField: focusField,
        generate: generate,
      ),
    );
  }
}

/// New item and Edit item (boards `S3-38` … `S3-51`).
class EditItemScreen extends StatefulWidget {
  const EditItemScreen({
    this.backLabel = '',
    this.onShowTag,
    this.focusField,
    this.generate = false,
    super.key,
  });

  /// After a new item is saved, its screen goes back to this title.
  final String backLabel;
  final ValueChanged<String>? onShowTag;

  /// The field (by position) to bring into view, drawn focused.
  final int? focusField;

  /// Open [focusField]'s Generate sheet instead of drawing it focused.
  final bool generate;

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen>
    with ToastsOverTabBar<EditItemScreen> {
  final TextEditingController _name = TextEditingController();

  /// The field just added, whose value takes the focus.
  int? _focusKey;

  /// Set once leaving is decided (saved, or discarded).
  bool _leaving = false;

  /// The field "Fix it in Edit" came for, and whether it still looks
  /// focused (until the screen is first touched).
  int? _anchorKey;
  bool _highlighted = false;
  final GlobalKey _anchor = GlobalKey();

  @override
  void initState() {
    super.initState();
    final EditItemState state = context.read<EditItemCubit>().state;
    _name.text = state.name;
    final int? index = widget.focusField;
    if (index != null && index >= 0 && index < state.fields.length) {
      _anchorKey = state.fields[index].key;
      _highlighted = !widget.generate;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final BuildContext? field = _anchor.currentContext;
        if (field == null || !field.mounted) return;
        // Change password scrolls only when the field is out of view, so
        // the screen opens as board `S4-21` draws it.
        Scrollable.ensureVisible(
          field,
          alignment: widget.generate ? 1 : 0.3,
          alignmentPolicy: widget.generate
              ? ScrollPositionAlignmentPolicy.keepVisibleAtEnd
              : ScrollPositionAlignmentPolicy.explicit,
          duration: AppMotion.reduceMotion(field)
              ? Duration.zero
              : AppMotion.slow,
          curve: AppMotion.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  String _itemName(EditItemState state) =>
      state.name.trim().isEmpty ? t.editItem.newItem : state.name.trim();

  Future<void> _save() async {
    final EditItemCubit cubit = context.read<EditItemCubit>();
    final bool isNew = cubit.state.isNew;
    final String? id = await cubit.save();
    if (id == null || !mounted) return;
    _leaving = true;
    final NavigatorState navigator = Navigator.of(context);
    if (isNew) {
      // A new item opens like any other (web: to the item's view).
      unawaited(
        navigator.pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => ItemDetailPage(
              itemId: id,
              backLabel: widget.backLabel,
              onShowTag: widget.onShowTag,
            ),
          ),
        ),
      );
    } else {
      navigator.pop(
        EditSaved(
          itemId: id,
          name: _itemName(cubit.state),
          recheck: cubit.recheck,
        ),
      );
    }
  }

  /// Cancel or back with changes asks first (board `S3-45`); a new item
  /// only once something was typed (your answer, Part 9).
  Future<void> _confirmLeave() async {
    final EditItemState state = context.read<EditItemCubit>().state;
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.undo2,
      tone: AppDialogTone.tint,
      title: state.isNew ? t.editItem.discardNewTitle : t.editItem.discardTitle,
      message: state.isNew
          ? t.editItem.discardNewBody
          : t.editItem.discardBody(
              name: state.startName.isEmpty
                  ? t.editItem.newItem
                  : state.startName,
            ),
      confirmLabel: t.editItem.discard,
    );
    if (!confirmed || !mounted) return;
    setState(() => _leaving = true);
    Navigator.of(context).pop();
  }

  Future<void> _addField() async {
    final FieldType? type = await showAddFieldSheet(context);
    if (type == null || !mounted) return;
    final int key = context.read<EditItemCubit>().addField(
      type,
      fieldTypeLabel(type),
    );
    setState(() => _focusKey = key);
  }

  Future<void> _changeIcon(VaultRow preview) async {
    final EditItemCubit cubit = context.read<EditItemCubit>();
    final IconChoice? choice = await showIconPicker(
      context,
      catalog: cubit.iconCatalog(),
      current: cubit.state.iconGlyph,
      defaultTile: VaultItemTile(
        _previewRow(cubit.state, glyph: false),
        size: AppTileSize.small,
      ),
    );
    if (choice != null) cubit.setIcon(choice.glyph);
  }

  /// The item as its tile would draw it now.
  VaultRow _previewRow(EditItemState state, {bool glyph = true}) {
    final VaultItem item = VaultItem(
      id: state.itemId,
      vaultId: state.vaultId,
      name: state.name.trim(),
      icon: state.icon,
      iconGlyph: glyph ? state.iconGlyph : null,
      fields: <Field>[for (final EditableField f in state.fields) f.toField()],
      updated: DateTime.now().toUtc(),
    );
    return VaultRow(
      item: item,
      vaultLabel: '',
      favourite: false,
      findings: const [],
      mainSecret: null,
      username: null,
      summary: null,
      faviconUrls: itemFaviconUrls(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final EditItemCubit cubit = context.read<EditItemCubit>();
    final EditItemState state = context.watch<EditItemCubit>().state;
    final EdgeInsets insets = MediaQuery.paddingOf(context);
    final VaultRow preview = _previewRow(state);

    return MultiBlocListener(
      listeners: <BlocListener<EditItemCubit, EditItemState>>[
        BlocListener<EditItemCubit, EditItemState>(
          listenWhen: (EditItemState a, EditItemState b) => !a.gone && b.gone,
          // Deleted elsewhere: back to the item screen, which says so.
          listener: (BuildContext context, _) {
            setState(() => _leaving = true);
            Navigator.of(context).maybePop();
          },
        ),
        BlocListener<EditItemCubit, EditItemState>(
          // Started over from the latest item ("Load the latest"): the
          // name box shows it too; the fields are new editors.
          listenWhen: (EditItemState a, EditItemState b) =>
              !identical(a.startFields, b.startFields),
          listener: (_, EditItemState state) => _name.text = state.name,
        ),
      ],
      child: PopScope<Object?>(
        canPop: _leaving || !state.changed,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (!didPop) _confirmLeave();
        },
        child: Scaffold(
          backgroundColor: colors.background,
          body: Listener(
            onPointerDown: (_) {
              if (_highlighted) setState(() => _highlighted = false);
            },
            child: Padding(
              padding: EdgeInsets.only(top: insets.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppCompactBar(
                    slotWidth: 96,
                    title: state.isNew
                        ? t.editItem.newItem
                        : t.editItem.editItem,
                    leading: AppLinkButton.bar(
                      label: t.common.cancel,
                      weight: FontWeight.w400,
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    trailing: AppLinkButton.bar(
                      label: t.common.save,
                      weight: FontWeight.w800,
                      onPressed: state.canSave ? _save : null,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        12.h,
                        16.w,
                        insets.bottom + 40.h,
                      ),
                      children: <Widget>[
                        _IconButton(
                          tile: VaultItemTile(preview, size: AppTileSize.large),
                          onTap: () => _changeIcon(preview),
                        ),
                        SizedBox(height: 14.h),
                        AppTextField(
                          controller: _name,
                          label: t.editItem.name,
                          placeholder: t.editItem.namePlaceholder,
                          large: true,
                          autofocus: state.isNew,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(
                              InputLimits.itemName,
                            ),
                          ],
                          onChanged: cubit.setName,
                        ),
                        AppSectionLabel(
                          t.itemDetail.fields,
                          icon: AppIconName.textCursorInput,
                        ),
                        if (state.fields.isEmpty)
                          _NoFields(onAdd: _addField)
                        else
                          AppInsetGroup(
                            children: <Widget>[
                              for (final EditableField field in state.fields)
                                FieldEditor(
                                  key: field.key == _anchorKey
                                      ? _anchor
                                      : ValueKey<int>(field.key),
                                  field: field,
                                  itemName: _itemName(state),
                                  autofocus: field.key == _focusKey,
                                  highlighted:
                                      _highlighted && field.key == _anchorKey,
                                  autoGenerate:
                                      widget.generate &&
                                      field.key == _anchorKey,
                                  findings: context
                                      .read<EditItemCubit>()
                                      .findingsOn(field.key),
                                ),
                              _AddFieldRow(onTap: _addField),
                            ],
                          ),
                        AppSectionLabel(t.editItem.tags, icon: AppIconName.tag),
                        TagEditor(
                          tags: state.tags,
                          known: state.knownTags,
                          onAdd: cubit.addTag,
                          onRemove: cubit.removeTag,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The item's tile with a pencil, and "Change icon" (board `S3-38`).
class _IconButton extends StatelessWidget {
  const _IconButton({required this.tile, required this.onTap});

  final Widget tile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Center(
      child: AppPressable(
        onTap: onTap,
        semanticLabel: t.editItem.changeIcon,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                tile,
                Positioned(
                  right: -6.r,
                  bottom: -6.r,
                  child: Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: ShapeDecoration(
                      color: colors.card,
                      shape: const CircleBorder(),
                      shadows: <BoxShadow>[
                        BoxShadow(color: colors.hairline, spreadRadius: 1.r),
                        ...context.shadows.shadowXs,
                      ],
                    ),
                    child: Center(
                      child: AppIcon(
                        AppIconName.pencil,
                        size: 13,
                        stroke: 2,
                        color: colors.foreground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              t.editItem.changeIcon,
              style: AppTextStyles(context)
                  .button()
                  .resized(14, line: 20, weight: FontWeight.w700)
                  .copyWith(color: colors.accentStrong),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Add field" closing the list (`.eadd`).
class _AddFieldRow extends StatelessWidget {
  const _AddFieldRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppPressable(
      onTap: onTap,
      child: SizedBox(
        height: 54.h,
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 16.w),
          child: Row(
            spacing: 12.w,
            children: <Widget>[
              SizedBox(
                width: 30.w,
                child: Center(
                  child: AppIcon(
                    AppIconName.plus,
                    size: 20,
                    stroke: 2.25,
                    color: colors.accentStrong,
                  ),
                ),
              ),
              Text(
                t.editItem.addField,
                style: AppTextStyles(context)
                    .button()
                    .resized(15, line: 20, weight: FontWeight.w700)
                    .copyWith(color: colors.accentStrong),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom's empty list (board `S3-39`): one clear way to add a field.
class _NoFields extends StatelessWidget {
  const _NoFields({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return AppSurface(
      radius: AppRadius.xxl,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 26.h, 20.w, 22.h),
        child: Column(
          spacing: 6.h,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Container(
                width: 48.r,
                height: 48.r,
                decoration: ShapeDecoration(
                  color: colors.primary15,
                  shape: AppRadius.shape(context, 14),
                ),
                child: Center(
                  child: AppIcon(
                    AppIconName.textCursorInput,
                    size: 22,
                    stroke: 1.75,
                    color: colors.accentStrong,
                  ),
                ),
              ),
            ),
            Text(
              t.editItem.noFieldsTitle,
              textAlign: TextAlign.center,
              style: styles
                  .bodyStrong()
                  .resized(16, line: 22, weight: FontWeight.w700)
                  .copyWith(color: colors.foreground),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 270.w),
              child: Text(
                t.editItem.noFieldsBody,
                textAlign: TextAlign.center,
                style: styles.secondary().copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: AppButton(
                label: t.editItem.addField,
                icon: AppIconName.plus,
                size: AppButtonSize.medium,
                expand: false,
                horizontalPadding: 20,
                onPressed: onAdd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
