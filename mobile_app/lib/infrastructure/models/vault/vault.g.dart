// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Vault _$VaultFromJson(Map<String, dynamic> json) => _Vault(
  id: json['id'] as String,
  name: json['name'] as String,
  created: const WebDateNullableConverter().fromJson(json['created']),
  organizationId: json['organizationId'] as String?,
  error: json['error'] as String?,
);

const _$VaultFieldMap = <String, String>{
  'id': 'id',
  'name': 'name',
  'created': 'created',
  'organizationId': 'organizationId',
  'error': 'error',
};

Map<String, dynamic> _$VaultToJson(_Vault instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'created': ?const WebDateNullableConverter().toJson(instance.created),
  'organizationId': ?instance.organizationId,
  'error': ?instance.error,
};
