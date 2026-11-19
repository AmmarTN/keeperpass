import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';

part 'organization.freezed.dart';
part 'organization.g.dart';

/// An organization that shared vaults belong to (web `Organization`).
@freezed
abstract class Organization with _$Organization {
  const Organization._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory Organization({
    required String id,
    required String name,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(
        json,
      ).copyWith(unknown: unknownJsonKeys(json, _$OrganizationFieldMap.values));

  /// The JSON written to the vault file, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}
