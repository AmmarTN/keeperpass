// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VaultSnapshot _$VaultSnapshotFromJson(Map<String, dynamic> json) =>
    _VaultSnapshot(
      vaults:
          (json['vaults'] as List<dynamic>?)
              ?.map((e) => Vault.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Vault>[],
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => VaultItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VaultItem>[],
      organizations:
          (json['organizations'] as List<dynamic>?)
              ?.map((e) => Organization.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Organization>[],
      favouriteIds:
          (json['favouriteIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      tagRegistry: json['tagRegistry'] == null
          ? const <TagRegistryEntry>[]
          : _tagRegistryFromJson(json['tagRegistry']),
      exportHistory:
          (json['exportHistory'] as List<dynamic>?)
              ?.map((e) => ExportRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExportRecord>[],
    );

const _$VaultSnapshotFieldMap = <String, String>{
  'vaults': 'vaults',
  'items': 'items',
  'organizations': 'organizations',
  'favouriteIds': 'favouriteIds',
  'tagRegistry': 'tagRegistry',
  'exportHistory': 'exportHistory',
};

Map<String, dynamic> _$VaultSnapshotToJson(_VaultSnapshot instance) =>
    <String, dynamic>{
      'vaults': _vaultsToJson(instance.vaults),
      'items': _itemsToJson(instance.items),
      'organizations': _organizationsToJson(instance.organizations),
      'favouriteIds': instance.favouriteIds,
      'tagRegistry': _tagRegistryToJson(instance.tagRegistry),
      'exportHistory': _exportsToJson(instance.exportHistory),
    };
