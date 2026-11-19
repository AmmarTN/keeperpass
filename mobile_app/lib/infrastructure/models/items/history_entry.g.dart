// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) =>
    _HistoryEntry(
      updated: const WebDateConverter().fromJson(json['updated']),
      name: json['name'] as String,
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Field>[],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

const _$HistoryEntryFieldMap = <String, String>{
  'updated': 'updated',
  'name': 'name',
  'fields': 'fields',
  'tags': 'tags',
};

Map<String, dynamic> _$HistoryEntryToJson(_HistoryEntry instance) =>
    <String, dynamic>{
      'updated': ?const WebDateConverter().toJson(instance.updated),
      'name': instance.name,
      'fields': fieldsToVaultJson(instance.fields),
      'tags': instance.tags,
    };
