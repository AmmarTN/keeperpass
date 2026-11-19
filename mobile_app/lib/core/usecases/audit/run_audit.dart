import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/run_audit_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/audit/audit.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/breach_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Audits the open vault's passwords (web `AuditService.runAndApply`):
/// findings by item id; with an item id, that one item only.
@singleton
class RunAudit implements Usecase<Map<String, List<AuditResult>>, RunAuditDto> {
  final VaultSessionService _vault;
  final IBreachRepository _breaches;

  RunAudit(this._vault, this._breaches);

  @override
  Future<Either<Failure, Map<String, List<AuditResult>>>> call(
    RunAuditDto params,
  ) async {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    return auditItems(
      snapshot.items,
      isCompromised: _breaches.isCompromised,
      onlyItemId: params.onlyItemId,
      onProgress: params.onProgress,
    );
  }
}
