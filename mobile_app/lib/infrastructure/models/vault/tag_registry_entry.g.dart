// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_registry_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TagRegistryEntry _$TagRegistryEntryFromJson(Map<String, dynamic> json) =>
    _TagRegistryEntry(
      name: json['name'] as String,
      created: const WebDateNullableConverter().fromJson(json['created']),
    );

const _$TagRegistryEntryFieldMap = <String, String>{
  'name': 'name',
  'created': 'created',
};

Map<String, dynamic> _$TagRegistryEntryToJson(_TagRegistryEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'created': ?const WebDateNullableConverter().toJson(instance.created),
    };
