import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';

part 'vault_item.freezed.dart';
part 'vault_item.g.dart';

/// How many past versions each item keeps (web `ITEM_HISTORY_LIMIT`). Every
/// entry duplicates the item's whole name, fields and tags, and the vault is
/// one file downloaded on every unlock.
const int kItemHistoryLimit = 5;

/// An item (web `VaultItem`).
@freezed
abstract class VaultItem with _$VaultItem {
  const VaultItem._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory VaultItem({
    required String id,
    required String vaultId,
    required String name,
    @JsonKey(toJson: fieldsToVaultJson) @Default(<Field>[]) List<Field> fields,
    @Default(<String>[]) List<String> tags,

    /// When the item was first added; absent in vaults written before it
    /// existed (see [createdOrUpdated]).
    @WebDateNullableConverter() DateTime? created,
    @WebDateConverter() required DateTime updated,

    /// Days after an update before the item counts as expired.
    int? expiresAfter,
    @WebDateNullableConverter() DateTime? expiresAt,

    /// Newest first, at most [kItemHistoryLimit].
    @JsonKey(toJson: _historyToJson)
    @Default(<HistoryEntry>[])
    List<HistoryEntry> history,

    /// Overrides the icon derived from the item's field types (an app icon
    /// name).
    String? icon,

    /// A Font Awesome code point picked from the catalogue (hex); wins over
    /// [icon].
    String? iconGlyph,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _VaultItem;

  /// Revives an item as the web's `reviveItemDates` does, including trimming
  /// [history] to [kItemHistoryLimit] — a vault written before the cap is
  /// trimmed the first time it is opened.
  factory VaultItem.fromJson(Map<String, dynamic> json) =>
      _revive(_$VaultItemFromJson(json), json);

  /// The creation time, or the closest thing there is (web `itemCreated`):
  /// items saved before `created` existed fall back to `updated`.
  int get createdOrUpdated => (created ?? updated).millisecondsSinceEpoch;

  /// The JSON written to the vault, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}

List<Map<String, dynamic>> _historyToJson(List<HistoryEntry> history) =>
    <Map<String, dynamic>>[
      for (final HistoryEntry entry in history) entry.toVaultJson(),
    ];

VaultItem _revive(VaultItem item, Map<String, dynamic> json) => item.copyWith(
  history: item.history.take(kItemHistoryLimit).toList(),
  unknown: unknownJsonKeys(json, _$VaultItemFieldMap.values),
);
