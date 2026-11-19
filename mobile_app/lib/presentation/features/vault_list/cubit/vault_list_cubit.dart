import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/move_items_dto.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/items/delete_items.dart';
import 'package:keeperpass/core/usecases/items/move_items.dart';
import 'package:keeperpass/core/usecases/items/toggle_favourite.dart';
import 'package:keeperpass/core/usecases/recent/get_recent_items.dart';
import 'package:keeperpass/core/usecases/recent/record_recent_item.dart';
import 'package:keeperpass/core/usecases/recent/watch_recent_items.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/usecases/vaults/add_vault.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/core/utils/items/field_display.dart';
import 'package:keeperpass/core/utils/items/item_sections.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_sheets.dart';

part 'vault_list_cubit.freezed.dart';
part 'vault_list_state.dart';

/// The Vault tab (boards `U3-Vault-home`, `U3-Vault-actions`,
/// `U3-Vault-empty`; web `ItemsList`): scope, tag chip, search, sort,
/// selection, and the changes made from the list — each one saved at once
/// through [SyncCubit].
@injectable
class VaultListCubit extends Cubit<VaultListState> implements ItemMover {
  VaultListCubit(
    this._vault,
    this._sync,
    this._audit,
    this._getRecentItems,
    this._watchRecentItems,
    this._recordRecentItem,
    this._toggleFavourite,
    this._moveItems,
    this._deleteItems,
    this._addVault,
    this._clipboard,
    this._links, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const VaultListState()) {
    _recentIds = _getRecentItems(const NoParams()).getOrElse(() => <String>[]);
    _subscriptions.addAll(<StreamSubscription<Object?>>[
      _vault.changes.listen((_) => _rebuild()),
      _audit.stream.listen((_) => _rebuild()),
      _watchRecentItems(const NoParams()).listen(
        (Either<Failure, List<String>> ids) =>
            ids.fold((_) {}, (List<String> ids) {
              _recentIds = ids;
              _rebuild();
            }),
      ),
    ]);
    _rebuild();
  }

  final VaultSessionService _vault;
  final SyncCubit _sync;
  final AuditCubit _audit;
  final GetRecentItems _getRecentItems;
  final WatchRecentItems _watchRecentItems;
  final RecordRecentItem _recordRecentItem;
  final ToggleFavourite _toggleFavourite;
  final MoveItems _moveItems;
  final DeleteItems _deleteItems;
  final AddVault _addVault;
  final ClipboardService _clipboard;
  final LinkService _links;
  final DateTime Function() _now;

  final List<StreamSubscription<Object?>> _subscriptions =
      <StreamSubscription<Object?>>[];
  List<String> _recentIds = const <String>[];

  // ---- Scope, filters, search, sort

  /// From the "Vaults" sheet; leaves search and the security filter.
  void setScope(VaultScope scope, {String? vaultId}) => _update(
    state.copyWith(
      scope: scope,
      vaultId: scope == VaultScope.vault ? vaultId : null,
    ),
  );

  /// A tag chip turns on, or off when it already was.
  void toggleTag(String tag) =>
      _update(state.copyWith(tag: state.tag == tag ? null : tag));

  /// A tag tapped on an item (board `U3-Item-detail`: "tapping one filters
  /// the vault by it"): the list as it was, with that tag on.
  void showTag(String tag) => _update(
    state.copyWith(tag: tag, report: null, searching: false, search: ''),
  );

  /// The Security tab's "Weak passwords" and the like (Part 11).
  void showReport(AuditType report) => _update(
    state.copyWith(scope: VaultScope.all, vaultId: null, report: report),
  );

  void clearReport() => _update(state.copyWith(report: null));

  void startSearch() => emit(state.copyWith(searching: true));

  void setSearch(String search) => _update(state.copyWith(search: search));

  /// "Cancel": back to the list as it was.
  void cancelSearch() => _update(state.copyWith(searching: false, search: ''));

  void setSort(ItemSort sort) => _update(state.copyWith(sort: sort));

  // ---- Selection

  /// "Select" in the quick sheet: selection mode with that item ticked.
  void startSelecting([String? itemId]) =>
      emit(state.copyWith(selecting: true, selected: <String>{?itemId}));

  void toggleSelected(String itemId) {
    final Set<String> selected = Set<String>.of(state.selected);
    if (!selected.remove(itemId)) selected.add(itemId);
    emit(state.copyWith(selected: selected));
  }

  /// "Select All", or clear when everything listed is selected (web
  /// `toggleSelectAll`).
  void toggleSelectAll() => emit(
    state.copyWith(
      selected: state.allSelected
          ? <String>{}
          : <String>{for (final VaultRow row in state.view.rows) row.id},
    ),
  );

  void cancelSelecting() =>
      emit(state.copyWith(selecting: false, selected: <String>{}));

  // ---- Refresh

  /// Pull to refresh re-reads the vault from storage; with a change still
  /// waiting to be saved it saves that instead (your answer, Part 7), so
  /// nothing is thrown away. A failure's text is in `status.errorMsg`.
  Future<void> refresh() async {
    if (state.refreshing) return;
    emit(state.copyWith(refreshing: true, status: const CubitStatus()));
    if (_sync.state.pendingChanges > 0) {
      await _sync.retry();
      if (isClosed) return;
      emit(state.copyWith(refreshing: false));
      return;
    }
    await _sync.loadLatest();
    if (isClosed) return;
    final CubitStatus sync = _sync.state.status;
    emit(
      state.copyWith(
        refreshing: false,
        status:
            sync.action == CubitAction.loadLatest &&
                sync.statusType == CubitStatusType.failure
            ? CubitStatus(
                action: CubitAction.refreshVault,
                statusType: CubitStatusType.failure,
                errorMsg: sync.errorMsg,
              )
            : const CubitStatus(),
      ),
    );
  }

  // ---- Copy and open

  /// Copies [field] of [itemId] — a 2FA field copies its current code, as
  /// the web does — and records the item as recently used. Null when there
  /// was nothing to copy.
  Future<Copied?> copy(String itemId, Field field) async {
    if (field.value.isEmpty) return null;
    final String value;
    if (field.type == FieldType.totp) {
      try {
        value = generateTotp(field.value);
      } catch (_) {
        return null;
      }
    } else {
      value = field.value;
    }
    final Duration? clearsIn = await _clipboard.copy(
      value,
      sensitive: copiesSecret(field),
    );
    await _recordRecentItem(itemId);
    return (clearsIn: clearsIn);
  }

  /// An item was opened.
  Future<void> opened(String itemId) => _recordRecentItem(itemId);

  /// "Open website": the address as typed; without a scheme, https.
  Future<void> openWebsite(String address) async {
    final Uri? uri = websiteUri(address);
    if (uri != null) await _links.open(uri);
  }

  // ---- Changes, each saved at once

  /// Stars or unstars an item; null when editing is paused (a newer version
  /// on Dropbox) or the vault is locked.
  Future<bool?> toggleFavourite(String itemId) async {
    if (!await _sync.checkBeforeEditing()) return null;
    final bool? favourite = _toggleFavourite(
      itemId,
    ).fold((_) => null, (bool favourite) => favourite);
    if (favourite != null) unawaited(_sync.saveNow());
    return favourite;
  }

  /// Moves items to [vaultId]; false when nothing moved.
  @override
  Future<bool> moveItems(List<String> itemIds, String vaultId) async {
    if (itemIds.isEmpty || !await _sync.checkBeforeEditing()) return false;
    final bool moved = _moveItems(
      MoveItemsDto(itemIds: itemIds, vaultId: vaultId),
    ).isRight();
    if (moved) {
      unawaited(_sync.saveNow());
      cancelSelecting();
    }
    return moved;
  }

  /// "New vault…" in the Move sheet: creates the vault, moves the items into
  /// it, and saves once. Null when nothing changed.
  @override
  Future<Vault?> moveItemsToNewVault(List<String> itemIds, String name) async {
    if (itemIds.isEmpty || !await _sync.checkBeforeEditing()) return null;
    final Vault? vault = _addVault(name).fold((_) => null, (Vault v) => v);
    if (vault == null) return null;
    _moveItems(MoveItemsDto(itemIds: itemIds, vaultId: vault.id));
    unawaited(_sync.saveNow());
    cancelSelecting();
    return vault;
  }

  /// Deletes items for good; false when nothing was deleted.
  Future<bool> deleteItems(List<String> itemIds) async {
    if (itemIds.isEmpty || !await _sync.checkBeforeEditing()) return false;
    final bool deleted = (await _deleteItems(itemIds)).isRight();
    if (deleted) {
      unawaited(_sync.saveNow());
      cancelSelecting();
    }
    return deleted;
  }

  /// The vault names as the Move and New Vault sheets need them.
  @override
  List<Vault> get vaults => _vault.snapshot?.vaults ?? const <Vault>[];

  @override
  Map<String, int> get vaultCounts => state.view.vaultCounts;

  // ---- Internals

  void _update(VaultListState next) => emit(_withView(next));

  void _rebuild() {
    if (!isClosed) emit(_withView(state));
  }

  VaultListState _withView(VaultListState next) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) {
      return next.copyWith(view: const VaultListView());
    }
    // A vault deleted elsewhere falls back to All Vaults.
    final bool vaultGone =
        next.scope == VaultScope.vault &&
        !snapshot.vaults.any((Vault v) => v.id == next.vaultId);
    // So does a tag deleted or renamed in Tags (Part 12): the filter goes.
    final String? tag = next.tag;
    final bool tagGone =
        tag != null &&
        !snapshot.items.any((VaultItem i) => i.tags.contains(tag)) &&
        !snapshot.tagRegistry.any((TagRegistryEntry e) => e.name == tag);
    final VaultListState scoped = next.copyWith(
      scope: vaultGone ? VaultScope.all : next.scope,
      vaultId: vaultGone ? null : next.vaultId,
      tag: tagGone ? null : tag,
    );
    final VaultListView view = buildVaultListView(
      snapshot: snapshot,
      scope: scoped.scope,
      vaultId: scoped.vaultId,
      tag: scoped.tag,
      report: scoped.report,
      search: scoped.searching ? scoped.search : '',
      sort: scoped.sort,
      recentIds: _recentIds,
      findings: _audit.state.findings,
      now: _now(),
      locale: LocaleSettings.currentLocale.languageCode,
    );
    // Selected items that disappeared (deleted elsewhere) drop out.
    final Set<String> listed = <String>{
      for (final VaultRow row in view.rows) row.id,
    };
    return scoped.copyWith(
      view: view,
      selected: scoped.selected.where(listed.contains).toSet(),
    );
  }

  @override
  Future<void> close() async {
    for (final StreamSubscription<Object?> subscription in _subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
