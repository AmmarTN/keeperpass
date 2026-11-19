import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/rename_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/vaults/add_vault.dart';
import 'package:keeperpass/core/usecases/vaults/delete_vaults.dart';
import 'package:keeperpass/core/usecases/vaults/rename_vault.dart';
import 'package:keeperpass/core/utils/vaults/vault_changes.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';

part 'my_vaults_cubit.freezed.dart';
part 'my_vaults_state.dart';

/// My Vaults (boards `Vaults`, `S5-01` … `S5-06`; web `VaultsPage`): your
/// own vaults with their item counts; new, rename and delete — deleting
/// moves the items to the default vault, which itself cannot be renamed
/// or deleted. Each change is saved at once.
@injectable
class MyVaultsCubit extends Cubit<MyVaultsState> {
  MyVaultsCubit(
    this._vault,
    this._sync,
    this._addVault,
    this._renameVault,
    this._deleteVaults,
  ) : super(const MyVaultsState()) {
    _changes = _vault.changes.listen((_) => _rebuild());
    _rebuild();
  }

  final VaultSessionService _vault;
  final SyncCubit _sync;
  final AddVault _addVault;
  final RenameVault _renameVault;
  final DeleteVaults _deleteVaults;
  late final StreamSubscription<VaultSnapshot?> _changes;

  void startSelecting() => emit(state.copyWith(selecting: true));

  void cancelSelecting() =>
      emit(state.copyWith(selecting: false, selected: const <String>{}));

  void toggle(String vaultId) {
    if (vaultId == kPersonalVaultId) return;
    final Set<String> next = Set<String>.of(state.selected);
    if (!next.remove(vaultId)) next.add(vaultId);
    emit(state.copyWith(selected: next));
  }

  /// Every vault that can go, or none when they all are (web
  /// `toggleSelectAll`).
  void toggleSelectAll() {
    final List<String> ids = <String>[
      for (final VaultEntry e in state.others) e.vault.id,
    ];
    final bool all = ids.isNotEmpty && state.selected.length == ids.length;
    emit(state.copyWith(selected: all ? const <String>{} : ids.toSet()));
  }

  Future<bool> create(String name) =>
      _change(() => _addVault(name).map((_) => unit));

  Future<bool> rename(String vaultId, String name) =>
      _change(() => _renameVault(RenameDto(id: vaultId, name: name)));

  /// Deletes [vaultIds] (the selection, or one from its row).
  Future<bool> delete(List<String> vaultIds) async {
    final bool done = await _change(
      () => _deleteVaults(vaultIds).map((_) => unit),
    );
    if (done) cancelSelecting();
    return done;
  }

  /// Applies a change, after the Dropbox newer-version check (Part 5), and
  /// saves it.
  Future<bool> _change(Either<Failure, Unit> Function() change) async {
    if (!await _sync.checkBeforeEditing()) return false;
    if (change().isLeft()) return false;
    unawaited(_sync.saveNow());
    return true;
  }

  void _rebuild() {
    if (isClosed) return;
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) {
      emit(const MyVaultsState());
      return;
    }
    final Map<String, int> counts = <String, int>{};
    for (final VaultItem item in snapshot.items) {
      counts[item.vaultId] = (counts[item.vaultId] ?? 0) + 1;
    }
    final List<VaultEntry> vaults =
        <VaultEntry>[
          for (final Vault vault in ownVaults(snapshot))
            VaultEntry(vault, counts[vault.id] ?? 0),
        ]..sort(
          (VaultEntry a, VaultEntry b) => a.isDefault == b.isDefault
              ? 0
              : a.isDefault
              ? -1
              : 1,
        );
    final Set<String> ids = <String>{
      for (final VaultEntry e in vaults) e.vault.id,
    };
    emit(
      state.copyWith(
        vaults: vaults,
        allVaults: snapshot.vaults,
        selected: state.selected.where(ids.contains).toSet(),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
