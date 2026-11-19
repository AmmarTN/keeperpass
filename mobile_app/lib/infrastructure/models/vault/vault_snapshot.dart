import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/models/vault/organization.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';

part 'vault_snapshot.freezed.dart';
part 'vault_snapshot.g.dart';

/// Every account has this vault (web `PERSONAL_VAULT_ID`).
const String kPersonalVaultId = 'vault-personal';

/// How many past exports are remembered (web `EXPORT_HISTORY_LIMIT`).
const int kExportHistoryLimit = 10;

/// Everything in the encrypted vault file (web `VaultSnapshot`): what is
/// decrypted on unlock and encrypted on save.
@freezed
abstract class VaultSnapshot with _$VaultSnapshot {
  const VaultSnapshot._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory VaultSnapshot({
    @JsonKey(toJson: _vaultsToJson) @Default(<Vault>[]) List<Vault> vaults,
    @JsonKey(toJson: _itemsToJson)
    @Default(<VaultItem>[])
    List<VaultItem> items,
    @JsonKey(toJson: _organizationsToJson)
    @Default(<Organization>[])
    List<Organization> organizations,
    @Default(<String>[]) List<String> favouriteIds,

    /// Tags known even with no items; older vaults omit it.
    @JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson)
    @Default(<TagRegistryEntry>[])
    List<TagRegistryEntry> tagRegistry,

    /// The last exports, newest first, at most [kExportHistoryLimit]; older
    /// vaults omit it.
    @JsonKey(toJson: _exportsToJson)
    @Default(<ExportRecord>[])
    List<ExportRecord> exportHistory,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _VaultSnapshot;

  /// Revives a decrypted vault as the web's `hydrate()` does: dates parsed,
  /// item history trimmed to five, export history to ten. Keys this version
  /// does not know are kept everywhere, so saving never loses data a newer
  /// app wrote (plan X9).
  factory VaultSnapshot.fromJson(Map<String, dynamic> json) =>
      _revive(_$VaultSnapshotFromJson(json), json);

  /// A brand-new account's vault (web `createEmptyVaultSnapshot`): the
  /// personal vault, created now, and nothing else.
  factory VaultSnapshot.empty({required String vaultName, DateTime? now}) =>
      VaultSnapshot(
        vaults: <Vault>[
          Vault(
            id: kPersonalVaultId,
            name: vaultName,
            created: (now ?? DateTime.now()).toUtc(),
          ),
        ],
      );

  /// The JSON encrypted into the vault file, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}

List<Map<String, dynamic>> _vaultsToJson(List<Vault> vaults) =>
    <Map<String, dynamic>>[
      for (final Vault vault in vaults) vault.toVaultJson(),
    ];

List<Map<String, dynamic>> _itemsToJson(List<VaultItem> items) =>
    <Map<String, dynamic>>[
      for (final VaultItem item in items) item.toVaultJson(),
    ];

List<Map<String, dynamic>> _organizationsToJson(
  List<Organization> organizations,
) => <Map<String, dynamic>>[
  for (final Organization organization in organizations)
    organization.toVaultJson(),
];

List<TagRegistryEntry> _tagRegistryFromJson(Object? json) => <TagRegistryEntry>[
  for (final Object? entry in (json as List<Object?>?) ?? const <Object?>[])
    TagRegistryEntry.fromAny(entry),
];

List<Map<String, dynamic>> _tagRegistryToJson(List<TagRegistryEntry> entries) =>
    <Map<String, dynamic>>[
      for (final TagRegistryEntry entry in entries) entry.toVaultJson(),
    ];

List<Map<String, dynamic>> _exportsToJson(List<ExportRecord> records) =>
    <Map<String, dynamic>>[
      for (final ExportRecord record in records) record.toVaultJson(),
    ];

VaultSnapshot _revive(VaultSnapshot snapshot, Map<String, dynamic> json) =>
    snapshot.copyWith(
      exportHistory: snapshot.exportHistory.take(kExportHistoryLimit).toList(),
      unknown: unknownJsonKeys(json, _$VaultSnapshotFieldMap.values),
    );
