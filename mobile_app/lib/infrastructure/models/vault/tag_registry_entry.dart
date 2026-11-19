import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';

part 'tag_registry_entry.freezed.dart';
part 'tag_registry_entry.g.dart';

/// A registered tag, known even with no items using it (web
/// `TagRegistryEntry`). The registry used to be a bare list of names; a plain
/// string still reads as an entry without a date.
@freezed
abstract class TagRegistryEntry with _$TagRegistryEntry {
  const TagRegistryEntry._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory TagRegistryEntry({
    required String name,
    @WebDateNullableConverter() DateTime? created,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _TagRegistryEntry;

  factory TagRegistryEntry.fromJson(Map<String, dynamic> json) =>
      _$TagRegistryEntryFromJson(json).copyWith(
        unknown: unknownJsonKeys(json, _$TagRegistryEntryFieldMap.values),
      );

  /// Either shape the registry has had (web `reviveTagRegistry`).
  factory TagRegistryEntry.fromAny(Object? json) => switch (json) {
    final String name => TagRegistryEntry(name: name),
    final Map<String, dynamic> map => TagRegistryEntry.fromJson(map),
    _ => throw FormatException('Not a tag registry entry: $json'),
  };

  /// The JSON written to the vault file, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}
