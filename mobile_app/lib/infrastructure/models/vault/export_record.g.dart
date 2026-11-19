// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExportRecord _$ExportRecordFromJson(Map<String, dynamic> json) =>
    _ExportRecord(
      at: const WebDateConverter().fromJson(json['at']),
      format: json['format'] as String,
      scope: json['scope'] as String,
      itemCount: (json['itemCount'] as num).toInt(),
      fileName: json['fileName'] as String,
    );

const _$ExportRecordFieldMap = <String, String>{
  'at': 'at',
  'format': 'format',
  'scope': 'scope',
  'itemCount': 'itemCount',
  'fileName': 'fileName',
};

Map<String, dynamic> _$ExportRecordToJson(_ExportRecord instance) =>
    <String, dynamic>{
      'at': ?const WebDateConverter().toJson(instance.at),
      'format': instance.format,
      'scope': instance.scope,
      'itemCount': instance.itemCount,
      'fileName': instance.fileName,
    };
