import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';

part 'history_entry.freezed.dart';
part 'history_entry.g.dart';

/// A past version of an item, kept so a change can be reviewed or undone
/// (web `HistoryEntry`).
@freezed
abstract class HistoryEntry with _$HistoryEntry {
  const HistoryEntry._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory HistoryEntry({
    @WebDateConverter() required DateTime updated,
    required String name,
    @JsonKey(toJson: fieldsToVaultJson) @Default(<Field>[]) List<Field> fields,
    @Default(<String>[]) List<String> tags,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$HistoryEntryFromJson(
        json,
      ).copyWith(unknown: unknownJsonKeys(json, _$HistoryEntryFieldMap.values));

  /// The JSON written to the vault, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}
