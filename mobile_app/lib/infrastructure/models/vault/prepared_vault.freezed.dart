// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prepared_vault.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PreparedVault {

 VaultSnapshot get snapshot; String get secret;/// The vault file's contents.
 String get encrypted;
/// Create a copy of PreparedVault
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreparedVaultCopyWith<PreparedVault> get copyWith => _$PreparedVaultCopyWithImpl<PreparedVault>(this as PreparedVault, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreparedVault&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.encrypted, encrypted) || other.encrypted == encrypted));
}


@override
int get hashCode => Object.hash(runtimeType,snapshot,secret,encrypted);

@override
String toString() {
  return 'PreparedVault(snapshot: $snapshot, secret: $secret, encrypted: $encrypted)';
}


}

/// @nodoc
abstract mixin class $PreparedVaultCopyWith<$Res>  {
  factory $PreparedVaultCopyWith(PreparedVault value, $Res Function(PreparedVault) _then) = _$PreparedVaultCopyWithImpl;
@useResult
$Res call({
 VaultSnapshot snapshot, String secret, String encrypted
});


$VaultSnapshotCopyWith<$Res> get snapshot;

}
/// @nodoc
class _$PreparedVaultCopyWithImpl<$Res>
    implements $PreparedVaultCopyWith<$Res> {
  _$PreparedVaultCopyWithImpl(this._self, this._then);

  final PreparedVault _self;
  final $Res Function(PreparedVault) _then;

/// Create a copy of PreparedVault
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? snapshot = null,Object? secret = null,Object? encrypted = null,}) {
  return _then(_self.copyWith(
snapshot: null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as VaultSnapshot,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,encrypted: null == encrypted ? _self.encrypted : encrypted // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PreparedVault
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultSnapshotCopyWith<$Res> get snapshot {
  
  return $VaultSnapshotCopyWith<$Res>(_self.snapshot, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}


/// Adds pattern-matching-related methods to [PreparedVault].
extension PreparedVaultPatterns on PreparedVault {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreparedVault value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreparedVault() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreparedVault value)  $default,){
final _that = this;
switch (_that) {
case _PreparedVault():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreparedVault value)?  $default,){
final _that = this;
switch (_that) {
case _PreparedVault() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VaultSnapshot snapshot,  String secret,  String encrypted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreparedVault() when $default != null:
return $default(_that.snapshot,_that.secret,_that.encrypted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VaultSnapshot snapshot,  String secret,  String encrypted)  $default,) {final _that = this;
switch (_that) {
case _PreparedVault():
return $default(_that.snapshot,_that.secret,_that.encrypted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VaultSnapshot snapshot,  String secret,  String encrypted)?  $default,) {final _that = this;
switch (_that) {
case _PreparedVault() when $default != null:
return $default(_that.snapshot,_that.secret,_that.encrypted);case _:
  return null;

}
}

}

/// @nodoc


class _PreparedVault implements PreparedVault {
  const _PreparedVault({required this.snapshot, required this.secret, required this.encrypted});
  

@override final  VaultSnapshot snapshot;
@override final  String secret;
/// The vault file's contents.
@override final  String encrypted;

/// Create a copy of PreparedVault
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreparedVaultCopyWith<_PreparedVault> get copyWith => __$PreparedVaultCopyWithImpl<_PreparedVault>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreparedVault&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.encrypted, encrypted) || other.encrypted == encrypted));
}


@override
int get hashCode => Object.hash(runtimeType,snapshot,secret,encrypted);

@override
String toString() {
  return 'PreparedVault(snapshot: $snapshot, secret: $secret, encrypted: $encrypted)';
}


}

/// @nodoc
abstract mixin class _$PreparedVaultCopyWith<$Res> implements $PreparedVaultCopyWith<$Res> {
  factory _$PreparedVaultCopyWith(_PreparedVault value, $Res Function(_PreparedVault) _then) = __$PreparedVaultCopyWithImpl;
@override @useResult
$Res call({
 VaultSnapshot snapshot, String secret, String encrypted
});


@override $VaultSnapshotCopyWith<$Res> get snapshot;

}
/// @nodoc
class __$PreparedVaultCopyWithImpl<$Res>
    implements _$PreparedVaultCopyWith<$Res> {
  __$PreparedVaultCopyWithImpl(this._self, this._then);

  final _PreparedVault _self;
  final $Res Function(_PreparedVault) _then;

/// Create a copy of PreparedVault
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? snapshot = null,Object? secret = null,Object? encrypted = null,}) {
  return _then(_PreparedVault(
snapshot: null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as VaultSnapshot,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,encrypted: null == encrypted ? _self.encrypted : encrypted // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PreparedVault
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultSnapshotCopyWith<$Res> get snapshot {
  
  return $VaultSnapshotCopyWith<$Res>(_self.snapshot, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}

// dart format on
