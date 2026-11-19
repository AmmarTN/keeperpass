import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/import_items_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/data/import_items.dart';
import 'package:keeperpass/core/utils/import_export/csv.dart';
import 'package:keeperpass/core/utils/items/vault_label.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';

part 'import_cubit.freezed.dart';
part 'import_state.dart';

/// The file types the picker offers (web `IMPORT_ACCEPT`: `.csv`, plain
/// text).
const List<String> kImportExtensions = <String>['csv', 'txt'];

/// Settings › Import CSV (boards `S5-32`, `S5-33`; web `ImportDialog`): the
/// file is read as soon as it is chosen, so the count on the button is what
/// will be imported. Items are added to the chosen vault; nothing is
/// replaced.
@injectable
class ImportCubit extends Cubit<ImportState> {
  ImportCubit(this._files, this._importItems, this._vault, this._sync)
    : super(const ImportState());

  final FileService _files;
  final ImportItems _importItems;
  final VaultSessionService _vault;
  final SyncCubit _sync;

  /// The system picker; null when nothing was chosen.
  Future<PickedTextFile?> pick() => _files.pickText(kImportExtensions);

  /// Reads [file] (web `parse`) and lists the vaults it can go to, the
  /// personal vault chosen (web `reset`).
  void load(PickedTextFile file) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    List<ItemDraft> drafts = <ItemDraft>[];
    ImportError? error;
    final String? text = file.text;
    if (text == null) {
      error = ImportError.invalidCsv;
    } else {
      try {
        drafts = csvToItemDrafts(parseCsv(text));
        if (drafts.isEmpty) error = ImportError.noItems;
      } on Object {
        error = ImportError.invalidCsv;
      }
    }
    final List<ImportVault> vaults = snapshot == null
        ? const <ImportVault>[]
        : <ImportVault>[
            for (final Vault vault in snapshot.vaults)
              ImportVault(
                id: vault.id,
                label: labelForVault(snapshot, vault.id),
                items: snapshot.items
                    .where((VaultItem item) => item.vaultId == vault.id)
                    .length,
              ),
          ];
    final bool hasPersonal = vaults.any(
      (ImportVault v) => v.id == kPersonalVaultId,
    );
    emit(
      ImportState(
        fileName: file.name,
        size: file.size,
        drafts: drafts,
        error: error,
        vaults: vaults,
        vaultId: hasPersonal
            ? kPersonalVaultId
            : (vaults.isEmpty ? null : vaults.first.id),
      ),
    );
  }

  /// "Change", "Choose another file".
  Future<void> change() async {
    final PickedTextFile? file = await pick();
    if (file != null && !isClosed) load(file);
  }

  void setVault(String vaultId) => emit(state.copyWith(vaultId: vaultId));

  /// "Import 16 items": added, then saved; the result is the vault they
  /// went to (the Vault tab opens on it, as the web), null when nothing
  /// was imported.
  Future<String?> import() async {
    final String? vaultId = state.vaultId;
    if (!state.canImport || vaultId == null) return null;
    if (!await _sync.checkBeforeEditing()) return null;
    final Either<Failure, int> result = _importItems(
      ImportItemsDto(vaultId: vaultId, drafts: state.drafts),
    );
    if (result.isLeft()) return null;
    unawaited(_sync.saveNow());
    return vaultId;
  }
}
