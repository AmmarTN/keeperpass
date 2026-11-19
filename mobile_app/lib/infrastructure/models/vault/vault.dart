import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';

part 'vault.freezed.dart';
part 'vault.g.dart';

/// A vault — a separate group of items (web `Vault`).
@freezed
abstract class Vault with _$Vault {
  const Vault._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory Vault({
    required String id,
    required String name,

    /// When it was created; absent for a vault written before this existed.
    @WebDateNullableConverter() DateTime? created,

    /// Absent for a personal vault.
    String? organizationId,

    /// Set when the vault failed to sync.
    String? error,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _Vault;

  factory Vault.fromJson(Map<String, dynamic> json) => _$VaultFromJson(
    json,
  ).copyWith(unknown: unknownJsonKeys(json, _$VaultFieldMap.values));

  /// The JSON written to the vault file, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}
