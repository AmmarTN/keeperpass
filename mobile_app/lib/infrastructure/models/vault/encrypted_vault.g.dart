// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encrypted_vault.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KdfParams _$KdfParamsFromJson(Map<String, dynamic> json) => _KdfParams(
  algorithm: json['algorithm'] as String,
  memorySize: (json['memorySize'] as num).toInt(),
  iterations: (json['iterations'] as num).toInt(),
  parallelism: (json['parallelism'] as num).toInt(),
);

const _$KdfParamsFieldMap = <String, String>{
  'algorithm': 'algorithm',
  'memorySize': 'memorySize',
  'iterations': 'iterations',
  'parallelism': 'parallelism',
};

Map<String, dynamic> _$KdfParamsToJson(_KdfParams instance) =>
    <String, dynamic>{
      'algorithm': instance.algorithm,
      'memorySize': instance.memorySize,
      'iterations': instance.iterations,
      'parallelism': instance.parallelism,
    };

_EncryptedVault _$EncryptedVaultFromJson(Map<String, dynamic> json) =>
    _EncryptedVault(
      salt: json['salt'] as String,
      iv: json['iv'] as String,
      ciphertext: json['ciphertext'] as String,
      kdf: KdfParams.fromJson(json['kdf'] as Map<String, dynamic>),
      encoding: json['encoding'] as String?,
    );

const _$EncryptedVaultFieldMap = <String, String>{
  'salt': 'salt',
  'iv': 'iv',
  'ciphertext': 'ciphertext',
  'kdf': 'kdf',
  'encoding': 'encoding',
};

Map<String, dynamic> _$EncryptedVaultToJson(_EncryptedVault instance) =>
    <String, dynamic>{
      'salt': instance.salt,
      'iv': instance.iv,
      'ciphertext': instance.ciphertext,
      'kdf': instance.kdf,
      'encoding': ?instance.encoding,
    };
