import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/core/enums/migration_stage.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';

part 'move_vault_dto.freezed.dart';

/// Settings › Storage › Move the vault (web `VaultMigrationService.migrate`).
@freezed
abstract class MoveVaultDto with _$MoveVaultDto {
  const factory MoveVaultDto({
    required ProviderId targetProvider,
    required MigrationTarget target,

    /// The secret the moved vault is encrypted with: the current one, or a
    /// new one chosen for the destination.
    required String secret,

    /// The person agreed that the destination's vault is kept as a backup
    /// and replaced.
    required bool replaceExisting,
    void Function(MigrationStage stage)? onStage,

    /// The upload's share, 0–1 ("Saving to Dropbox…", board `S5-28`).
    void Function(double fraction)? onProgress,
  }) = _MoveVaultDto;
}
