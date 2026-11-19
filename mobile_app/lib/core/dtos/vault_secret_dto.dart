import 'package:freezed_annotation/freezed_annotation.dart';

part 'vault_secret_dto.freezed.dart';

/// Unlock, create or recover: the secret, and the name the first vault gets
/// when a new one is created (web `vaults.defaultName`, translated).
@freezed
abstract class VaultSecretDto with _$VaultSecretDto {
  const factory VaultSecretDto({
    required String secret,
    required String vaultName,
  }) = _VaultSecretDto;
}
