import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/history_entry_dto.dart';
import 'package:keeperpass/core/dtos/move_items_dto.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/common/get_country_names.dart';
import 'package:keeperpass/core/usecases/common/get_relative_time_formatter.dart';
import 'package:keeperpass/core/usecases/items/delete_history_entry.dart';
import 'package:keeperpass/core/usecases/items/delete_items.dart';
import 'package:keeperpass/core/usecases/items/move_items.dart';
import 'package:keeperpass/core/usecases/items/restore_history_entry.dart';
import 'package:keeperpass/core/usecases/items/toggle_favourite.dart';
import 'package:keeperpass/core/usecases/recent/record_recent_item.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/usecases/vaults/add_vault.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/core/utils/items/field_display.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_sheets.dart';

part 'item_detail_cubit.freezed.dart';
part 'item_detail_state.dart';

/// One item (boards `U3-Item-detail`, `U3-Item-types`; web `ItemView` and
/// `ItemField`): reveal and copy per field, favorite, move, delete, and its
/// earlier versions — each change saved at once through [SyncCubit].
@injectable
class ItemDetailCubit extends Cubit<ItemDetailState> implements ItemMover {
  ItemDetailCubit(
    this._vault,
    this._sync,
    this._audit,
    this._recordRecentItem,
    this._toggleFavourite,
    this._moveItems,
    this._deleteItems,
    this._addVault,
    this._restoreHistoryEntry,
    this._deleteHistoryEntry,
    this._getRelativeTimeFormatter,
    this._getCountryNames,
    this._clipboard,
    this._links, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const ItemDetailState()) {
    _changes = _vault.changes.listen((_) => _rebuild());
    // Findings arrive after the item's check (its card, Part 11).
    _findings = _audit.stream
        .map((AuditState audit) => audit.findingsFor(state.itemId))
        .distinct()
        .listen((_) => _rebuild());
  }

  final VaultSessionService _vault;
  final SyncCubit _sync;
  final AuditCubit _audit;
  final RecordRecentItem _recordRecentItem;
  final ToggleFavourite _toggleFavourite;
  final MoveItems _moveItems;
  final DeleteItems _deleteItems;
  final AddVault _addVault;
  final RestoreHistoryEntry _restoreHistoryEntry;
  final DeleteHistoryEntry _deleteHistoryEntry;
  final GetRelativeTimeFormatter _getRelativeTimeFormatter;
  final GetCountryNames _getCountryNames;
  final ClipboardService _clipboard;
  final LinkService _links;
  final DateTime Function() _now;

  /// The clock the screen reads ("4 minutes ago", today's history rows).
  DateTime now() => _now();

  late final StreamSubscription<VaultSnapshot?> _changes;
  late final StreamSubscription<List<AuditResult>> _findings;

  /// Set while this screen deletes its own item, so the "gone" screen does
  /// not flash before it closes.
  bool _leaving = false;

  /// Shows [itemId] and counts it as used (web: recorded on opening).
  Future<void> open(String itemId) async {
    emit(state.copyWith(itemId: itemId, revealed: <int>{}));
    _rebuild();
    if (state.row != null) unawaited(_recordRecentItem(itemId));
    final Either<Failure, RelativeTimeFormatter> relative =
        await _getRelativeTimeFormatter(const NoParams());
    final Either<Failure, Map<String, dynamic>> countries =
        await _getCountryNames(const NoParams());
    if (isClosed) return;
    emit(
      state.copyWith(
        relativeTime: relative.fold(
          (_) => null,
          (RelativeTimeFormatter r) => r,
        ),
        countryNames: countries.getOrElse(() => const <String, dynamic>{}),
      ),
    );
  }

  /// Shows or hides one secret.
  void toggleReveal(int index) {
    final Set<int> revealed = Set<int>.of(state.revealed);
    if (!revealed.remove(index)) revealed.add(index);
    emit(state.copyWith(revealed: revealed));
  }

  // ---- Copy and open

  /// Copies [field] — a 2FA field its current code (web `ItemField.copy`),
  /// an IBAN without its spaces — or [value] when given (one recovery
  /// code). Null when there was nothing to copy.
  Future<Copied?> copy(Field field, {String? value}) async {
    final String text;
    if (value != null) {
      text = value;
    } else if (field.value.isEmpty) {
      return null;
    } else if (field.type == FieldType.totp) {
      try {
        text = generateTotp(field.value);
      } catch (_) {
        return null;
      }
    } else {
      text = fieldCopyValue(field);
    }
    if (text.isEmpty) return null;
    final Duration? clearsIn = await _clipboard.copy(
      text,
      sensitive: copiesSecret(field),
    );
    await _recordRecentItem(state.itemId);
    return (clearsIn: clearsIn);
  }

  /// "Open github.com".
  Future<void> openWebsite(String address) async {
    final Uri? uri = websiteUri(address);
    if (uri != null) await _links.open(uri);
  }

  /// Call or Message (board `S3-35`): the phone's own app.
  Future<void> call(String number) => _openPhone('tel', number);

  Future<void> message(String number) => _openPhone('sms', number);

  Future<void> _openPhone(String scheme, String number) async {
    final Uri? uri = phoneUri(scheme, number);
    if (uri != null) await _links.open(uri);
  }

  // ---- Changes, each saved at once

  /// Stars or unstars the item; null when editing is paused.
  Future<bool?> toggleFavourite() async {
    if (!await _sync.checkBeforeEditing()) return null;
    final bool? favourite = _toggleFavourite(
      state.itemId,
    ).fold((_) => null, (bool favourite) => favourite);
    if (favourite != null) unawaited(_sync.saveNow());
    return favourite;
  }

  @override
  List<Vault> get vaults => _vault.snapshot?.vaults ?? const <Vault>[];

  @override
  Map<String, int> get vaultCounts {
    final VaultSnapshot? snapshot = _vault.snapshot;
    return snapshot == null ? const <String, int>{} : vaultCountsOf(snapshot);
  }

  @override
  Future<bool> moveItems(List<String> itemIds, String vaultId) async {
    if (itemIds.isEmpty || !await _sync.checkBeforeEditing()) return false;
    final bool moved = _moveItems(
      MoveItemsDto(itemIds: itemIds, vaultId: vaultId),
    ).isRight();
    if (moved) unawaited(_sync.saveNow());
    return moved;
  }

  @override
  Future<Vault?> moveItemsToNewVault(List<String> itemIds, String name) async {
    if (itemIds.isEmpty || !await _sync.checkBeforeEditing()) return null;
    final Vault? vault = _addVault(name).fold((_) => null, (Vault v) => v);
    if (vault == null) return null;
    _moveItems(MoveItemsDto(itemIds: itemIds, vaultId: vault.id));
    unawaited(_sync.saveNow());
    return vault;
  }

  /// Deletes the item for good (web `confirmDelete`); its history goes with
  /// it. False when nothing was deleted.
  Future<bool> delete() async {
    if (!await _sync.checkBeforeEditing()) return false;
    _leaving = true;
    final bool deleted = (await _deleteItems(<String>[state.itemId])).isRight();
    if (!deleted) {
      _leaving = false;
      return false;
    }
    unawaited(_sync.saveNow());
    return true;
  }

  /// Restores the version at [index] (web `confirmRestoreHistory`): saved,
  /// and the item's passwords are checked again.
  Future<bool> restore(int index) async {
    if (!await _sync.checkBeforeEditing()) return false;
    final bool restored = _restoreHistoryEntry(
      HistoryEntryDto(itemId: state.itemId, index: index),
    ).isRight();
    if (restored) {
      unawaited(_audit.runAuditForItem(state.itemId));
      unawaited(_sync.saveNow());
    }
    return restored;
  }

  /// Deletes the version at [index] for good.
  Future<bool> deleteVersion(int index) async {
    if (!await _sync.checkBeforeEditing()) return false;
    final bool deleted = _deleteHistoryEntry(
      HistoryEntryDto(itemId: state.itemId, index: index),
    ).isRight();
    if (deleted) unawaited(_sync.saveNow());
    return deleted;
  }

  // ---- Internals

  void _rebuild() {
    if (isClosed || state.itemId.isEmpty) return;
    final VaultSnapshot? snapshot = _vault.snapshot;
    // Locked: the session takes the screen away; keep what is shown.
    if (snapshot == null) return;
    final VaultItem? item = snapshot.items
        .where((VaultItem i) => i.id == state.itemId)
        .firstOrNull;
    if (item == null) {
      if (!_leaving) emit(state.copyWith(row: null, gone: true));
      return;
    }
    emit(
      state.copyWith(
        gone: false,
        row: buildVaultRow(
          snapshot: snapshot,
          item: item,
          favourite: snapshot.favouriteIds.contains(item.id),
          findings: _audit.state.findings,
          locale: LocaleSettings.currentLocale.languageCode,
        ),
        // A version restored or fields changed elsewhere: positions may
        // mean other fields now, so everything is masked again.
        revealed: listEquals(item.fields, state.item?.fields)
            ? state.revealed
            : <int>{},
      ),
    );
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    await _findings.cancel();
    return super.close();
  }
}
