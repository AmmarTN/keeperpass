// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VaultItem _$VaultItemFromJson(Map<String, dynamic> json) => _VaultItem(
  id: json['id'] as String,
  vaultId: json['vaultId'] as String,
  name: json['name'] as String,
  fields:
      (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Field>[],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  created: const WebDateNullableConverter().fromJson(json['created']),
  updated: const WebDateConverter().fromJson(json['updated']),
  expiresAfter: (json['expiresAfter'] as num?)?.toInt(),
  expiresAt: const WebDateNullableConverter().fromJson(json['expiresAt']),
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HistoryEntry>[],
  icon: json['icon'] as String?,
  iconGlyph: json['iconGlyph'] as String?,
);

const _$VaultItemFieldMap = <String, String>{
  'id': 'id',
  'vaultId': 'vaultId',
  'name': 'name',
  'fields': 'fields',
  'tags': 'tags',
  'created': 'created',
  'updated': 'updated',
  'expiresAfter': 'expiresAfter',
  'expiresAt': 'expiresAt',
  'history': 'history',
  'icon': 'icon',
  'iconGlyph': 'iconGlyph',
};

Map<String, dynamic> _$VaultItemToJson(_VaultItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vaultId': instance.vaultId,
      'name': instance.name,
      'fields': fieldsToVaultJson(instance.fields),
      'tags': instance.tags,
      'created': ?const WebDateNullableConverter().toJson(instance.created),
      'updated': ?const WebDateConverter().toJson(instance.updated),
      'expiresAfter': ?instance.expiresAfter,
      'expiresAt': ?const WebDateNullableConverter().toJson(instance.expiresAt),
      'history': _historyToJson(instance.history),
      'icon': ?instance.icon,
      'iconGlyph': ?instance.iconGlyph,
    };
