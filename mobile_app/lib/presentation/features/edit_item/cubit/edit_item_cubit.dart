import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/item_edit_dto.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/common/get_country_names.dart';
import 'package:keeperpass/core/usecases/common/get_icon_catalog.dart';
import 'package:keeperpass/core/usecases/items/create_item.dart';
import 'package:keeperpass/core/usecases/items/update_item.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/audit/audit.dart';
import 'package:keeperpass/core/utils/audit/report.dart';
import 'package:keeperpass/core/utils/icons/icon_catalog.dart';
import 'package:keeperpass/core/utils/items/field_editing.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:uuid/uuid.dart';

part 'edit_item_cubit.freezed.dart';
part 'edit_item_state.dart';

/// New item and Edit item (boards `U3-New-item`, `U3-Edit-item`,
/// `U3-Edit-fields`; web `ItemView` edit mode and `ItemDraftStore`): the
/// item is staged here, and only Save writes it — with history, registered
/// tags, a fresh password check and the vault saved.
@injectable
class EditItemCubit extends Cubit<EditItemState> {
  EditItemCubit(
    this._vault,
    this._sync,
    this._audit,
    this._createItem,
    this._updateItem,
    this._getIconCatalog,
    this._getCountryNames,
  ) : super(const EditItemState()) {
    _changes = _vault.changes.listen((_) => _watch());
  }

  final VaultSessionService _vault;
  final SyncCubit _sync;
  final AuditCubit _audit;
  final CreateItem _createItem;
  final UpdateItem _updateItem;
  final GetIconCatalog _getIconCatalog;
  final GetCountryNames _getCountryNames;

  late final StreamSubscription<VaultSnapshot?> _changes;
  int _nextKey = 0;

  /// The vault's reload count when this item was read (see [_watch]).
  int _reloadsSeen = 0;
  List<CatalogIcon>? _catalog;
  Map<String, dynamic>? _countryNames;

  /// A new item in [vaultId] from a template whose fields are already
  /// named in the app language (web `ItemDraftStore.start`).
  void startNew({
    required String vaultId,
    required String icon,
    required List<({FieldType type, String name})> fields,
  }) {
    final List<EditableField> staged = <EditableField>[
      for (final ({FieldType type, String name}) f in fields)
        _blank(f.type, f.name),
    ];
    emit(
      EditItemState(
        isNew: true,
        itemId: const Uuid().v4(),
        vaultId: vaultId,
        icon: icon,
        fields: staged,
        startFields: staged,
        knownTags: _knownTags(),
      ),
    );
  }

  /// An existing item, as stored.
  void startEdit(String itemId) {
    _reloadsSeen = _vault.reloads;
    final VaultItem? item = _item(itemId);
    if (item == null) {
      emit(EditItemState(itemId: itemId, gone: true));
      return;
    }
    final List<EditableField> staged = <EditableField>[
      for (final Field field in item.fields)
        EditableField.from(_nextKey++, field),
    ];
    emit(
      EditItemState(
        itemId: itemId,
        vaultId: item.vaultId,
        icon: item.icon,
        name: item.name,
        startName: item.name,
        iconGlyph: item.iconGlyph,
        startIconGlyph: item.iconGlyph,
        fields: staged,
        startFields: staged,
        tags: List<String>.of(item.tags),
        startTags: List<String>.of(item.tags),
        knownTags: _knownTags(),
      ),
    );
  }

  void setName(String name) => emit(state.copyWith(name: name));

  /// A picked icon, or null for the default (web `onIconPicked`).
  void setIcon(String? glyph) => emit(state.copyWith(iconGlyph: glyph));

  void setFieldName(int key, String name) =>
      _field(key, (EditableField f) => f.copyWith(name: name));

  void setFieldValue(int key, String value) =>
      _field(key, (EditableField f) => f.copyWith(value: value));

  /// The Secret chip (web `toggleFieldSecret`).
  void setFieldSecret(int key, bool secret) =>
      _field(key, (EditableField f) => f.copyWith(secret: secret));

  void setFieldIcon(int key, String? glyph) =>
      _field(key, (EditableField f) => f.copyWith(iconGlyph: glyph));

  /// A blank field of [type], named after it, last (web `addField`);
  /// returns its key, for the screen to focus its value.
  int addField(FieldType type, String name) {
    final EditableField field = _blank(type, name);
    emit(state.copyWith(fields: <EditableField>[...state.fields, field]));
    return field.key;
  }

  /// After "Remove" was confirmed (web `confirmRemoveField`).
  void removeField(int key) => emit(
    state.copyWith(
      fields: state.fields.where((EditableField f) => f.key != key).toList(),
    ),
  );

  /// A tag picked or typed (web `addTag`): trimmed; nothing for a blank, a
  /// repeated or (when typed) an invalid name.
  bool addTag(String tag, {bool typed = true}) {
    final String name = tag.trim();
    if (name.isEmpty || state.tags.contains(name)) return false;
    if (typed && !tagNameValid(name)) return false;
    emit(state.copyWith(tags: <String>[...state.tags, name]));
    return true;
  }

  void removeTag(String tag) => emit(
    state.copyWith(tags: state.tags.where((String t) => t != tag).toList()),
  );

  /// The icon picker's catalogue, loaded once.
  Future<List<CatalogIcon>> iconCatalog() async =>
      _catalog ??= (await _getIconCatalog(
        const NoParams(),
      )).getOrElse(() => const <CatalogIcon>[]);

  /// Country names for the phone's country picker, loaded once.
  Future<Map<String, dynamic>> countryNames() async =>
      _countryNames ??= (await _getCountryNames(
        const NoParams(),
      )).getOrElse(() => const <String, dynamic>{});

  /// Writes the item (web `save`) and saves the vault; its id, or null when
  /// nothing was saved (not ready, editing paused, or the item gone).
  Future<String?> save() async {
    if (!state.canSave) return null;
    emit(state.copyWith(saving: true));
    if (!await _sync.checkBeforeEditing(join: true)) {
      if (!isClosed) emit(state.copyWith(saving: false));
      return null;
    }
    final ItemEditDto dto = ItemEditDto(
      itemId: state.itemId,
      name: state.name.trim(),
      fields: <Field>[for (final EditableField f in state.fields) f.toField()],
      tags: state.tags,
      iconGlyph: state.iconGlyph,
      vaultId: state.isNew ? state.vaultId : null,
      icon: state.isNew ? state.icon : null,
    );
    final Either<Failure, Object> written = state.isNew
        ? _createItem(dto)
        : _updateItem(dto);
    if (written.isLeft()) {
      if (!isClosed) emit(state.copyWith(saving: false));
      return null;
    }
    _recheck = _audit.runAuditForItem(state.itemId);
    unawaited(_sync.saveNow());
    return state.itemId;
  }

  Future<bool>? _recheck;

  /// The saved item's audit, started by [save]: true once it went through
  /// (a fix's toast waits for it — Part 11).
  Future<bool> get recheck => _recheck ?? Future<bool>.value(false);

  /// The findings the stored item has on the field [key] (none for a field
  /// added here), from the last audit.
  List<AuditType> findingsOn(int key) {
    final int index = state.startFields.indexWhere(
      (EditableField f) => f.key == key,
    );
    if (index < 0) return const <AuditType>[];
    return <AuditType>[
      for (final AuditType type in AuditType.values)
        if (_audit.state
            .findingsFor(state.itemId)
            .any((AuditResult r) => r.type == type && r.fieldIndex == index))
          type,
    ];
  }

  /// What [value] on the password field [key] would clear of [findings]
  /// (board `S4-21`): weak when it no longer scores weak; reused when no
  /// other password — another item's, or another field of this one — is
  /// the same. Whether it is in a breach is only known after Save.
  ({bool weak, bool reused}) clears(
    int key,
    String value,
    List<AuditType> findings,
  ) {
    final List<VaultItem> others = <VaultItem>[
      for (final VaultItem item
          in _vault.snapshot?.items ?? const <VaultItem>[])
        if (item.id != state.itemId) item,
    ];
    final bool reusedHere = state.fields.any(
      (EditableField f) =>
          f.key != key && f.type == FieldType.password && f.value == value,
    );
    return (
      weak: findings.contains(AuditType.weakPassword) && !isPasswordWeak(value),
      reused:
          findings.contains(AuditType.reusedPassword) &&
          !reusedHere &&
          !PasswordUse(others).usedOutside(state.itemId, value),
    );
  }

  // ---- Internals

  EditableField _blank(FieldType type, String name) => EditableField(
    key: _nextKey++,
    typeValue: type.value,
    name: name,
    value: '',
    secret: type.secret,
  );

  void _field(int key, EditableField Function(EditableField) change) => emit(
    state.copyWith(
      fields: <EditableField>[
        for (final EditableField f in state.fields)
          f.key == key ? change(f) : f,
      ],
    ),
  );

  VaultItem? _item(String id) =>
      _vault.snapshot?.items.where((VaultItem i) => i.id == id).firstOrNull;

  List<String> _knownTags() {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const <String>[];
    return <String>[
      for (final VaultTagCount tag in tagCounts(snapshot)) tag.name,
    ];
  }

  /// An edited item deleted elsewhere closes the screen; the item screen
  /// below then says it is gone. After "Load the latest" (Edit opens while
  /// its check runs, so "Your Vault Changed" can come over it), Edit starts
  /// over from the latest item: what was typed is dropped, as the sheet says,
  /// and Save can never write the older copy back.
  void _watch() {
    if (isClosed || state.isNew || state.itemId.isEmpty || state.saving) {
      return;
    }
    if (_vault.snapshot == null) return;
    if (_vault.reloads != _reloadsSeen) {
      startEdit(state.itemId);
    } else if (_item(state.itemId) == null) {
      emit(state.copyWith(gone: true));
    }
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
