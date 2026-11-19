// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vault_file_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VaultFileInfo {

 DateTime? get modifiedAt;
/// Create a copy of VaultFileInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaultFileInfoCopyWith<VaultFileInfo> get copyWith => _$VaultFileInfoCopyWithImpl<VaultFileInfo>(this as VaultFileInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultFileInfo&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,modifiedAt);

@override
String toString() {
  return 'VaultFileInfo(modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class $VaultFileInfoCopyWith<$Res>  {
  factory $VaultFileInfoCopyWith(VaultFileInfo value, $Res Function(VaultFileInfo) _then) = _$VaultFileInfoCopyWithImpl;
@useResult
$Res call({
 DateTime? modifiedAt
});




}
/// @nodoc
class _$VaultFileInfoCopyWithImpl<$Res>
    implements $VaultFileInfoCopyWith<$Res> {
  _$VaultFileInfoCopyWithImpl(this._self, this._then);

  final VaultFileInfo _self;
  final $Res Function(VaultFileInfo) _then;

/// Create a copy of VaultFileInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modifiedAt = freezed,}) {
  return _then(_self.copyWith(
modifiedAt: freezed == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VaultFileInfo].
extension VaultFileInfoPatterns on VaultFileInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaultFileInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaultFileInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaultFileInfo value)  $default,){
final _that = this;
switch (_that) {
case _VaultFileInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaultFileInfo value)?  $default,){
final _that = this;
switch (_that) {
case _VaultFileInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? modifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaultFileInfo() when $default != null:
return $default(_that.modifiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? modifiedAt)  $default,) {final _that = this;
switch (_that) {
case _VaultFileInfo():
return $default(_that.modifiedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? modifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _VaultFileInfo() when $default != null:
return $default(_that.modifiedAt);case _:
  return null;

}
}

}

/// @nodoc


class _VaultFileInfo implements VaultFileInfo {
  const _VaultFileInfo({this.modifiedAt});
  

@override final  DateTime? modifiedAt;

/// Create a copy of VaultFileInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaultFileInfoCopyWith<_VaultFileInfo> get copyWith => __$VaultFileInfoCopyWithImpl<_VaultFileInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaultFileInfo&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,modifiedAt);

@override
String toString() {
  return 'VaultFileInfo(modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class _$VaultFileInfoCopyWith<$Res> implements $VaultFileInfoCopyWith<$Res> {
  factory _$VaultFileInfoCopyWith(_VaultFileInfo value, $Res Function(_VaultFileInfo) _then) = __$VaultFileInfoCopyWithImpl;
@override @useResult
$Res call({
 DateTime? modifiedAt
});




}
/// @nodoc
class __$VaultFileInfoCopyWithImpl<$Res>
    implements _$VaultFileInfoCopyWith<$Res> {
  __$VaultFileInfoCopyWithImpl(this._self, this._then);

  final _VaultFileInfo _self;
  final $Res Function(_VaultFileInfo) _then;

/// Create a copy of VaultFileInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modifiedAt = freezed,}) {
  return _then(_VaultFileInfo(
modifiedAt: freezed == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$MigrationTarget {

 String get accessToken; String get email;/// Whether the destination account already holds a vault.
 bool get hasVault;/// The account's name, for "Moving to this account" (board `S5-26`).
 String get name;
/// Create a copy of MigrationTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrationTargetCopyWith<MigrationTarget> get copyWith => _$MigrationTargetCopyWithImpl<MigrationTarget>(this as MigrationTarget, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrationTarget&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.email, email) || other.email == email)&&(identical(other.hasVault, hasVault) || other.hasVault == hasVault)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,email,hasVault,name);

@override
String toString() {
  return 'MigrationTarget(accessToken: $accessToken, email: $email, hasVault: $hasVault, name: $name)';
}


}

/// @nodoc
abstract mixin class $MigrationTargetCopyWith<$Res>  {
  factory $MigrationTargetCopyWith(MigrationTarget value, $Res Function(MigrationTarget) _then) = _$MigrationTargetCopyWithImpl;
@useResult
$Res call({
 String accessToken, String email, bool hasVault, String name
});




}
/// @nodoc
class _$MigrationTargetCopyWithImpl<$Res>
    implements $MigrationTargetCopyWith<$Res> {
  _$MigrationTargetCopyWithImpl(this._self, this._then);

  final MigrationTarget _self;
  final $Res Function(MigrationTarget) _then;

/// Create a copy of MigrationTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? email = null,Object? hasVault = null,Object? name = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,hasVault: null == hasVault ? _self.hasVault : hasVault // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MigrationTarget].
extension MigrationTargetPatterns on MigrationTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigrationTarget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigrationTarget() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigrationTarget value)  $default,){
final _that = this;
switch (_that) {
case _MigrationTarget():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigrationTarget value)?  $default,){
final _that = this;
switch (_that) {
case _MigrationTarget() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String email,  bool hasVault,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigrationTarget() when $default != null:
return $default(_that.accessToken,_that.email,_that.hasVault,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String email,  bool hasVault,  String name)  $default,) {final _that = this;
switch (_that) {
case _MigrationTarget():
return $default(_that.accessToken,_that.email,_that.hasVault,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String email,  bool hasVault,  String name)?  $default,) {final _that = this;
switch (_that) {
case _MigrationTarget() when $default != null:
return $default(_that.accessToken,_that.email,_that.hasVault,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _MigrationTarget implements MigrationTarget {
  const _MigrationTarget({required this.accessToken, required this.email, required this.hasVault, this.name = ''});
  

@override final  String accessToken;
@override final  String email;
/// Whether the destination account already holds a vault.
@override final  bool hasVault;
/// The account's name, for "Moving to this account" (board `S5-26`).
@override@JsonKey() final  String name;

/// Create a copy of MigrationTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigrationTargetCopyWith<_MigrationTarget> get copyWith => __$MigrationTargetCopyWithImpl<_MigrationTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigrationTarget&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.email, email) || other.email == email)&&(identical(other.hasVault, hasVault) || other.hasVault == hasVault)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,email,hasVault,name);

@override
String toString() {
  return 'MigrationTarget(accessToken: $accessToken, email: $email, hasVault: $hasVault, name: $name)';
}


}

/// @nodoc
abstract mixin class _$MigrationTargetCopyWith<$Res> implements $MigrationTargetCopyWith<$Res> {
  factory _$MigrationTargetCopyWith(_MigrationTarget value, $Res Function(_MigrationTarget) _then) = __$MigrationTargetCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String email, bool hasVault, String name
});




}
/// @nodoc
class __$MigrationTargetCopyWithImpl<$Res>
    implements _$MigrationTargetCopyWith<$Res> {
  __$MigrationTargetCopyWithImpl(this._self, this._then);

  final _MigrationTarget _self;
  final $Res Function(_MigrationTarget) _then;

/// Create a copy of MigrationTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? email = null,Object? hasVault = null,Object? name = null,}) {
  return _then(_MigrationTarget(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,hasVault: null == hasVault ? _self.hasVault : hasVault // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
