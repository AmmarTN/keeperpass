import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';

part 'save_vault_dto.freezed.dart';

/// Saving the open vault; [onProgress] reports the upload from `0` to `1`
/// (before its first call the vault is still being encrypted).
@freezed
abstract class SaveVaultDto with _$SaveVaultDto {
  const factory SaveVaultDto({UploadProgress? onProgress}) = _SaveVaultDto;
}
