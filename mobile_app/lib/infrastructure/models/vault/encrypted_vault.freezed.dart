// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encrypted_vault.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KdfParams {

/// Always `argon2id`.
 String get algorithm;/// KiB (65 536 = 64 MiB).
 int get memorySize; int get iterations; int get parallelism;
/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KdfParamsCopyWith<KdfParams> get copyWith => _$KdfParamsCopyWithImpl<KdfParams>(this as KdfParams, _$identity);

  /// Serializes this KdfParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KdfParams&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.memorySize, memorySize) || other.memorySize == memorySize)&&(identical(other.iterations, iterations) || other.iterations == iterations)&&(identical(other.parallelism, parallelism) || other.parallelism == parallelism));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algorithm,memorySize,iterations,parallelism);

@override
String toString() {
  return 'KdfParams(algorithm: $algorithm, memorySize: $memorySize, iterations: $iterations, parallelism: $parallelism)';
}


}

/// @nodoc
abstract mixin class $KdfParamsCopyWith<$Res>  {
  factory $KdfParamsCopyWith(KdfParams value, $Res Function(KdfParams) _then) = _$KdfParamsCopyWithImpl;
@useResult
$Res call({
 String algorithm, int memorySize, int iterations, int parallelism
});




}
/// @nodoc
class _$KdfParamsCopyWithImpl<$Res>
    implements $KdfParamsCopyWith<$Res> {
  _$KdfParamsCopyWithImpl(this._self, this._then);

  final KdfParams _self;
  final $Res Function(KdfParams) _then;

/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? algorithm = null,Object? memorySize = null,Object? iterations = null,Object? parallelism = null,}) {
  return _then(_self.copyWith(
algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as String,memorySize: null == memorySize ? _self.memorySize : memorySize // ignore: cast_nullable_to_non_nullable
as int,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,parallelism: null == parallelism ? _self.parallelism : parallelism // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [KdfParams].
extension KdfParamsPatterns on KdfParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KdfParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KdfParams value)  $default,){
final _that = this;
switch (_that) {
case _KdfParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KdfParams value)?  $default,){
final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String algorithm,  int memorySize,  int iterations,  int parallelism)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
return $default(_that.algorithm,_that.memorySize,_that.iterations,_that.parallelism);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String algorithm,  int memorySize,  int iterations,  int parallelism)  $default,) {final _that = this;
switch (_that) {
case _KdfParams():
return $default(_that.algorithm,_that.memorySize,_that.iterations,_that.parallelism);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String algorithm,  int memorySize,  int iterations,  int parallelism)?  $default,) {final _that = this;
switch (_that) {
case _KdfParams() when $default != null:
return $default(_that.algorithm,_that.memorySize,_that.iterations,_that.parallelism);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createFieldMap: true)
class _KdfParams extends KdfParams {
  const _KdfParams({required this.algorithm, required this.memorySize, required this.iterations, required this.parallelism}): super._();
  factory _KdfParams.fromJson(Map<String, dynamic> json) => _$KdfParamsFromJson(json);

/// Always `argon2id`.
@override final  String algorithm;
/// KiB (65 536 = 64 MiB).
@override final  int memorySize;
@override final  int iterations;
@override final  int parallelism;

/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KdfParamsCopyWith<_KdfParams> get copyWith => __$KdfParamsCopyWithImpl<_KdfParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KdfParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KdfParams&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.memorySize, memorySize) || other.memorySize == memorySize)&&(identical(other.iterations, iterations) || other.iterations == iterations)&&(identical(other.parallelism, parallelism) || other.parallelism == parallelism));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algorithm,memorySize,iterations,parallelism);

@override
String toString() {
  return 'KdfParams(algorithm: $algorithm, memorySize: $memorySize, iterations: $iterations, parallelism: $parallelism)';
}


}

/// @nodoc
abstract mixin class _$KdfParamsCopyWith<$Res> implements $KdfParamsCopyWith<$Res> {
  factory _$KdfParamsCopyWith(_KdfParams value, $Res Function(_KdfParams) _then) = __$KdfParamsCopyWithImpl;
@override @useResult
$Res call({
 String algorithm, int memorySize, int iterations, int parallelism
});




}
/// @nodoc
class __$KdfParamsCopyWithImpl<$Res>
    implements _$KdfParamsCopyWith<$Res> {
  __$KdfParamsCopyWithImpl(this._self, this._then);

  final _KdfParams _self;
  final $Res Function(_KdfParams) _then;

/// Create a copy of KdfParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? algorithm = null,Object? memorySize = null,Object? iterations = null,Object? parallelism = null,}) {
  return _then(_KdfParams(
algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as String,memorySize: null == memorySize ? _self.memorySize : memorySize // ignore: cast_nullable_to_non_nullable
as int,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,parallelism: null == parallelism ? _self.parallelism : parallelism // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EncryptedVault {

 String get salt; String get iv; String get ciphertext; KdfParams get kdf;/// `gzip`, or absent for a vault written before compression (bare UTF-8
/// JSON) — must stay optional forever.
 String? get encoding;@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown;
/// Create a copy of EncryptedVault
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncryptedVaultCopyWith<EncryptedVault> get copyWith => _$EncryptedVaultCopyWithImpl<EncryptedVault>(this as EncryptedVault, _$identity);

  /// Serializes this EncryptedVault to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncryptedVault&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.iv, iv) || other.iv == iv)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&(identical(other.kdf, kdf) || other.kdf == kdf)&&(identical(other.encoding, encoding) || other.encoding == encoding)&&const DeepCollectionEquality().equals(other.unknown, unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,salt,iv,ciphertext,kdf,encoding,const DeepCollectionEquality().hash(unknown));

@override
String toString() {
  return 'EncryptedVault(salt: $salt, iv: $iv, ciphertext: $ciphertext, kdf: $kdf, encoding: $encoding, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class $EncryptedVaultCopyWith<$Res>  {
  factory $EncryptedVaultCopyWith(EncryptedVault value, $Res Function(EncryptedVault) _then) = _$EncryptedVaultCopyWithImpl;
@useResult
$Res call({
 String salt, String iv, String ciphertext, KdfParams kdf, String? encoding,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});


$KdfParamsCopyWith<$Res> get kdf;

}
/// @nodoc
class _$EncryptedVaultCopyWithImpl<$Res>
    implements $EncryptedVaultCopyWith<$Res> {
  _$EncryptedVaultCopyWithImpl(this._self, this._then);

  final EncryptedVault _self;
  final $Res Function(EncryptedVault) _then;

/// Create a copy of EncryptedVault
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? salt = null,Object? iv = null,Object? ciphertext = null,Object? kdf = null,Object? encoding = freezed,Object? unknown = null,}) {
  return _then(_self.copyWith(
salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,iv: null == iv ? _self.iv : iv // ignore: cast_nullable_to_non_nullable
as String,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String,kdf: null == kdf ? _self.kdf : kdf // ignore: cast_nullable_to_non_nullable
as KdfParams,encoding: freezed == encoding ? _self.encoding : encoding // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}
/// Create a copy of EncryptedVault
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KdfParamsCopyWith<$Res> get kdf {
  
  return $KdfParamsCopyWith<$Res>(_self.kdf, (value) {
    return _then(_self.copyWith(kdf: value));
  });
}
}


/// Adds pattern-matching-related methods to [EncryptedVault].
extension EncryptedVaultPatterns on EncryptedVault {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EncryptedVault value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EncryptedVault() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EncryptedVault value)  $default,){
final _that = this;
switch (_that) {
case _EncryptedVault():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EncryptedVault value)?  $default,){
final _that = this;
switch (_that) {
case _EncryptedVault() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String salt,  String iv,  String ciphertext,  KdfParams kdf,  String? encoding, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EncryptedVault() when $default != null:
return $default(_that.salt,_that.iv,_that.ciphertext,_that.kdf,_that.encoding,_that.unknown);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String salt,  String iv,  String ciphertext,  KdfParams kdf,  String? encoding, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)  $default,) {final _that = this;
switch (_that) {
case _EncryptedVault():
return $default(_that.salt,_that.iv,_that.ciphertext,_that.kdf,_that.encoding,_that.unknown);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String salt,  String iv,  String ciphertext,  KdfParams kdf,  String? encoding, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,) {final _that = this;
switch (_that) {
case _EncryptedVault() when $default != null:
return $default(_that.salt,_that.iv,_that.ciphertext,_that.kdf,_that.encoding,_that.unknown);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, createFieldMap: true)
class _EncryptedVault extends EncryptedVault {
  const _EncryptedVault({required this.salt, required this.iv, required this.ciphertext, required this.kdf, this.encoding, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) final  Map<String, Object?> unknown = const <String, Object?>{}}): _unknown = unknown,super._();
  factory _EncryptedVault.fromJson(Map<String, dynamic> json) => _$EncryptedVaultFromJson(json);

@override final  String salt;
@override final  String iv;
@override final  String ciphertext;
@override final  KdfParams kdf;
/// `gzip`, or absent for a vault written before compression (bare UTF-8
/// JSON) — must stay optional forever.
@override final  String? encoding;
 final  Map<String, Object?> _unknown;
@override@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown {
  if (_unknown is EqualUnmodifiableMapView) return _unknown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unknown);
}


/// Create a copy of EncryptedVault
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EncryptedVaultCopyWith<_EncryptedVault> get copyWith => __$EncryptedVaultCopyWithImpl<_EncryptedVault>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EncryptedVaultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EncryptedVault&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.iv, iv) || other.iv == iv)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&(identical(other.kdf, kdf) || other.kdf == kdf)&&(identical(other.encoding, encoding) || other.encoding == encoding)&&const DeepCollectionEquality().equals(other._unknown, _unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,salt,iv,ciphertext,kdf,encoding,const DeepCollectionEquality().hash(_unknown));

@override
String toString() {
  return 'EncryptedVault(salt: $salt, iv: $iv, ciphertext: $ciphertext, kdf: $kdf, encoding: $encoding, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class _$EncryptedVaultCopyWith<$Res> implements $EncryptedVaultCopyWith<$Res> {
  factory _$EncryptedVaultCopyWith(_EncryptedVault value, $Res Function(_EncryptedVault) _then) = __$EncryptedVaultCopyWithImpl;
@override @useResult
$Res call({
 String salt, String iv, String ciphertext, KdfParams kdf, String? encoding,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});


@override $KdfParamsCopyWith<$Res> get kdf;

}
/// @nodoc
class __$EncryptedVaultCopyWithImpl<$Res>
    implements _$EncryptedVaultCopyWith<$Res> {
  __$EncryptedVaultCopyWithImpl(this._self, this._then);

  final _EncryptedVault _self;
  final $Res Function(_EncryptedVault) _then;

/// Create a copy of EncryptedVault
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? salt = null,Object? iv = null,Object? ciphertext = null,Object? kdf = null,Object? encoding = freezed,Object? unknown = null,}) {
  return _then(_EncryptedVault(
salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,iv: null == iv ? _self.iv : iv // ignore: cast_nullable_to_non_nullable
as String,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String,kdf: null == kdf ? _self.kdf : kdf // ignore: cast_nullable_to_non_nullable
as KdfParams,encoding: freezed == encoding ? _self.encoding : encoding // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self._unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

/// Create a copy of EncryptedVault
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KdfParamsCopyWith<$Res> get kdf {
  
  return $KdfParamsCopyWith<$Res>(_self.kdf, (value) {
    return _then(_self.copyWith(kdf: value));
  });
}
}

// dart format on
