// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vault_secret_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VaultSecretDto {

 String get secret; String get vaultName;
/// Create a copy of VaultSecretDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaultSecretDtoCopyWith<VaultSecretDto> get copyWith => _$VaultSecretDtoCopyWithImpl<VaultSecretDto>(this as VaultSecretDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultSecretDto&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.vaultName, vaultName) || other.vaultName == vaultName));
}


@override
int get hashCode => Object.hash(runtimeType,secret,vaultName);

@override
String toString() {
  return 'VaultSecretDto(secret: $secret, vaultName: $vaultName)';
}


}

/// @nodoc
abstract mixin class $VaultSecretDtoCopyWith<$Res>  {
  factory $VaultSecretDtoCopyWith(VaultSecretDto value, $Res Function(VaultSecretDto) _then) = _$VaultSecretDtoCopyWithImpl;
@useResult
$Res call({
 String secret, String vaultName
});




}
/// @nodoc
class _$VaultSecretDtoCopyWithImpl<$Res>
    implements $VaultSecretDtoCopyWith<$Res> {
  _$VaultSecretDtoCopyWithImpl(this._self, this._then);

  final VaultSecretDto _self;
  final $Res Function(VaultSecretDto) _then;

/// Create a copy of VaultSecretDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? secret = null,Object? vaultName = null,}) {
  return _then(_self.copyWith(
secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,vaultName: null == vaultName ? _self.vaultName : vaultName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VaultSecretDto].
extension VaultSecretDtoPatterns on VaultSecretDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaultSecretDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaultSecretDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaultSecretDto value)  $default,){
final _that = this;
switch (_that) {
case _VaultSecretDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaultSecretDto value)?  $default,){
final _that = this;
switch (_that) {
case _VaultSecretDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String secret,  String vaultName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaultSecretDto() when $default != null:
return $default(_that.secret,_that.vaultName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String secret,  String vaultName)  $default,) {final _that = this;
switch (_that) {
case _VaultSecretDto():
return $default(_that.secret,_that.vaultName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String secret,  String vaultName)?  $default,) {final _that = this;
switch (_that) {
case _VaultSecretDto() when $default != null:
return $default(_that.secret,_that.vaultName);case _:
  return null;

}
}

}

/// @nodoc


class _VaultSecretDto implements VaultSecretDto {
  const _VaultSecretDto({required this.secret, required this.vaultName});
  

@override final  String secret;
@override final  String vaultName;

/// Create a copy of VaultSecretDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaultSecretDtoCopyWith<_VaultSecretDto> get copyWith => __$VaultSecretDtoCopyWithImpl<_VaultSecretDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaultSecretDto&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.vaultName, vaultName) || other.vaultName == vaultName));
}


@override
int get hashCode => Object.hash(runtimeType,secret,vaultName);

@override
String toString() {
  return 'VaultSecretDto(secret: $secret, vaultName: $vaultName)';
}


}

/// @nodoc
abstract mixin class _$VaultSecretDtoCopyWith<$Res> implements $VaultSecretDtoCopyWith<$Res> {
  factory _$VaultSecretDtoCopyWith(_VaultSecretDto value, $Res Function(_VaultSecretDto) _then) = __$VaultSecretDtoCopyWithImpl;
@override @useResult
$Res call({
 String secret, String vaultName
});




}
/// @nodoc
class __$VaultSecretDtoCopyWithImpl<$Res>
    implements _$VaultSecretDtoCopyWith<$Res> {
  __$VaultSecretDtoCopyWithImpl(this._self, this._then);

  final _VaultSecretDto _self;
  final $Res Function(_VaultSecretDto) _then;

/// Create a copy of VaultSecretDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? secret = null,Object? vaultName = null,}) {
  return _then(_VaultSecretDto(
secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,vaultName: null == vaultName ? _self.vaultName : vaultName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
