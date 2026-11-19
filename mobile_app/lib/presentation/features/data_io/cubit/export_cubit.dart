import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/usecases/data/record_export.dart';
import 'package:keeperpass/core/utils/import_export/csv.dart';
import 'package:keeperpass/core/utils/items/vault_label.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';

part 'export_cubit.freezed.dart';
part 'export_state.dart';

/// Settings › Export CSV (board `S5-34`; web `ExportDialog`): a plain CSV
/// of all vaults or one, handed to the share sheet. The export is
/// remembered in the vault once the sheet has the file, and saved straight
/// away.
@injectable
class ExportCubit extends Cubit<ExportState> {
  ExportCubit(
    this._vault,
    this._files,
    this._recordExport,
    this._sync, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const ExportState()) {
    _read();
  }

  final VaultSessionService _vault;
  final FileService _files;
  final RecordExport _recordExport;
  final SyncCubit _sync;
  final DateTime Function() _now;

  /// All vaults first, then each vault (web `vaultOptions`).
  void _read() {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return;
    emit(
      state.copyWith(
        sources: <ExportSource>[
          ExportSource(
            label: t.vaultList.allVaults,
            items: snapshot.items.length,
          ),
          for (final Vault vault in snapshot.vaults)
            ExportSource(
              vaultId: vault.id,
              label: labelForVault(snapshot, vault.id),
              items: snapshot.items
                  .where((VaultItem item) => item.vaultId == vault.id)
                  .length,
            ),
        ],
      ),
    );
  }

  /// Null for All Vaults.
  void choose(String? vaultId) => emit(state.copyWith(vaultId: vaultId));

  /// "Export 23 items": the share sheet, and the record. Returns once the
  /// sheet has closed.
  Future<void> export() async {
    final VaultSnapshot? snapshot = _vault.snapshot;
    final ExportSource? source = state.source;
    if (snapshot == null || source == null || source.items == 0) return;
    if (state.exporting) return;
    // The record is a change: not while a newer version waits (Dropbox).
    if (!await _sync.checkBeforeEditing()) return;
    emit(state.copyWith(exporting: true));
    final String? vaultId = source.vaultId;
    final List<VaultItem> items = vaultId == null
        ? snapshot.items
        : snapshot.items
              .where((VaultItem item) => item.vaultId == vaultId)
              .toList();
    final String fileName = exportFileName(
      vaultId == null
          ? 'all-vaults'
          : snapshot.vaults
                    .where((Vault vault) => vault.id == vaultId)
                    .firstOrNull
                    ?.name ??
                'vault',
    );
    try {
      await _files.shareText(
        fileName: fileName,
        content: itemsToCsv(items),
        mimeType: 'text/csv',
        onHandedOver: () {
          _recordExport(
            ExportRecord(
              at: _now().toUtc(),
              format: 'csv',
              scope: source.label,
              itemCount: items.length,
              fileName: fileName,
            ),
          );
          unawaited(_sync.saveNow());
        },
      );
    } finally {
      if (!isClosed) emit(state.copyWith(exporting: false));
    }
  }
}

/// `keeperpass-<slug>.csv` (web `ExportDialog.fileName`).
String exportFileName(String scope) {
  final String slug = scope
      .toLowerCase()
      .replaceAll(RegExp('[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
  return 'keeperpass-$slug.csv';
}
