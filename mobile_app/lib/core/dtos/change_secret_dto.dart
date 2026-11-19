import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';

part 'change_secret_dto.freezed.dart';

/// Settings › Change secret (web `MasterPasswordService.change`).
@freezed
abstract class ChangeSecretDto with _$ChangeSecretDto {
  const factory ChangeSecretDto({
    required String currentSecret,
    required String newSecret,
    UploadProgress? onProgress,

    /// The current secret opened the stored vault; encrypting under the new
    /// one starts (board `S5-20`'s second step).
    void Function()? onVerified,
  }) = _ChangeSecretDto;
}
