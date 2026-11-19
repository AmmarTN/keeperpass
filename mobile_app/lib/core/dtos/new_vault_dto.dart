import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/vault/prepared_vault.dart';

part 'new_vault_dto.freezed.dart';

/// Saving a first vault (Create) or a replacement (Start a new vault).
@freezed
abstract class NewVaultDto with _$NewVaultDto {
  const factory NewVaultDto({
    required PreparedVault vault,

    /// Start a new vault only: when the old file is renamed, and its name.
    DateTime? backupAt,

    /// Start a new vault only: the old file is out of the way.
    void Function()? onBackedUp,
    UploadProgress? onProgress,
  }) = _NewVaultDto;
}
