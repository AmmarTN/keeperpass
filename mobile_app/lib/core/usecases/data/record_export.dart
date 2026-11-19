import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Remembers an export in the vault (web `VaultStore.recordExport`): newest
/// first, at most [kExportHistoryLimit] — the oldest falls off. Only what,
/// when and how many; never the data. The caller saves.
@singleton
class RecordExport implements UnawaitedUsecase<Unit, ExportRecord> {
  final VaultSessionService _vault;

  RecordExport(this._vault);

  @override
  Either<Failure, Unit> call(ExportRecord record) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    _vault.update(
      snapshot.copyWith(
        exportHistory: <ExportRecord>[
          record,
          ...snapshot.exportHistory,
        ].take(kExportHistoryLimit).toList(),
      ),
    );
    return const Right(unit);
  }
}
