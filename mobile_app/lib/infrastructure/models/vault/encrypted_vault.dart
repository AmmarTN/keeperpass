import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';

part 'encrypted_vault.freezed.dart';
part 'encrypted_vault.g.dart';

/// The key-derivation parameters stored with a vault (web `KdfParams`), so a
/// future tuning applies to new vaults without breaking old ones.
@freezed
abstract class KdfParams with _$KdfParams {
  const KdfParams._();

  @JsonSerializable(createFieldMap: true)
  const factory KdfParams({
    /// Always `argon2id`.
    required String algorithm,

    /// KiB (65 536 = 64 MiB).
    required int memorySize,
    required int iterations,
    required int parallelism,
  }) = _KdfParams;

  factory KdfParams.fromJson(Map<String, dynamic> json) =>
      _$KdfParamsFromJson(json);

  /// What new vaults use — Bitwarden's production default, as on the web.
  static const KdfParams standard = KdfParams(
    algorithm: 'argon2id',
    memorySize: 65536,
    iterations: 3,
    parallelism: 4,
  );
}

/// The vault file (web `EncryptedVault`): base64 salt, IV and ciphertext (GCM
/// tag appended), the KDF parameters, and the plaintext encoding.
@freezed
abstract class EncryptedVault with _$EncryptedVault {
  const EncryptedVault._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory EncryptedVault({
    required String salt,
    required String iv,
    required String ciphertext,
    required KdfParams kdf,

    /// `gzip`, or absent for a vault written before compression (bare UTF-8
    /// JSON) — must stay optional forever.
    String? encoding,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _EncryptedVault;

  factory EncryptedVault.fromJson(Map<String, dynamic> json) =>
      _$EncryptedVaultFromJson(json).copyWith(
        unknown: unknownJsonKeys(json, _$EncryptedVaultFieldMap.values),
      );

  /// The file's JSON, unknown keys included.
  Map<String, dynamic> toFileJson() => withUnknownKeys(
    unknown,
    <String, dynamic>{...toJson(), 'kdf': kdf.toJson()},
  );
}
