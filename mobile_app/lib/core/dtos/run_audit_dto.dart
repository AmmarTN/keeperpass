import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/core/utils/audit/audit.dart';

part 'run_audit_dto.freezed.dart';

/// An audit of the open vault: every item, or only [onlyItemId] (every
/// password is still scanned for reuse). [onProgress] hears the breach
/// lookups, for the report's progress.
@freezed
abstract class RunAuditDto with _$RunAuditDto {
  const factory RunAuditDto({String? onlyItemId, AuditProgress? onProgress}) =
      _RunAuditDto;
}
