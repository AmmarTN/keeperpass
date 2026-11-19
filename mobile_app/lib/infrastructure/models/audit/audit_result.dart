import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/core/enums/audit_type.dart';

part 'audit_result.freezed.dart';

/// One finding on one password field (web `AuditResult`). Findings are kept
/// for the session only, never in the vault (web `AuditService`).
@freezed
abstract class AuditResult with _$AuditResult {
  const factory AuditResult({
    required AuditType type,
    required int fieldIndex,
  }) = _AuditResult;
}
