import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';

part 'export_record.freezed.dart';
part 'export_record.g.dart';

/// One export, kept in the vault so the record of what left it follows the
/// user (web `ExportRecord`).
@freezed
abstract class ExportRecord with _$ExportRecord {
  const ExportRecord._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory ExportRecord({
    @WebDateConverter() required DateTime at,

    /// The format's id — always `csv` today.
    required String format,

    /// What was exported, in words: a vault's name, or "All Vaults".
    required String scope,
    required int itemCount,
    required String fileName,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _ExportRecord;

  factory ExportRecord.fromJson(Map<String, dynamic> json) =>
      _$ExportRecordFromJson(
        json,
      ).copyWith(unknown: unknownJsonKeys(json, _$ExportRecordFieldMap.values));

  /// The JSON written to the vault file, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}
