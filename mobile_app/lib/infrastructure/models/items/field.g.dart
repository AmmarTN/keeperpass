// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Field _$FieldFromJson(Map<String, dynamic> json) => _Field(
  name: json['name'] as String,
  value: json['value'] as String,
  typeValue: json['type'] as String,
  secret: json['secret'] as bool?,
  iconGlyph: json['iconGlyph'] as String?,
);

const _$FieldFieldMap = <String, String>{
  'name': 'name',
  'value': 'value',
  'typeValue': 'type',
  'secret': 'secret',
  'iconGlyph': 'iconGlyph',
};

Map<String, dynamic> _$FieldToJson(_Field instance) => <String, dynamic>{
  'name': instance.name,
  'value': instance.value,
  'type': instance.typeValue,
  'secret': ?instance.secret,
  'iconGlyph': ?instance.iconGlyph,
};
