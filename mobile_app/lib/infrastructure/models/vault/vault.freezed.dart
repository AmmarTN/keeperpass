// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vault.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Vault {

 String get id; String get name;/// When it was created; absent for a vault written before this existed.
@WebDateNullableConverter() DateTime? get created;/// Absent for a personal vault.
 String? get organizationId;/// Set when the vault failed to sync.
 String? get error;@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown;
/// Create a copy of Vault
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaultCopyWith<Vault> get copyWith => _$VaultCopyWithImpl<Vault>(this as Vault, _$identity);

  /// Serializes this Vault to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vault&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.created, created) || other.created == created)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.unknown, unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,created,organizationId,error,const DeepCollectionEquality().hash(unknown));

@override
String toString() {
  return 'Vault(id: $id, name: $name, created: $created, organizationId: $organizationId, error: $error, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class $VaultCopyWith<$Res>  {
  factory $VaultCopyWith(Vault value, $Res Function(Vault) _then) = _$VaultCopyWithImpl;
@useResult
$Res call({
 String id, String name,@WebDateNullableConverter() DateTime? created, String? organizationId, String? error,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class _$VaultCopyWithImpl<$Res>
    implements $VaultCopyWith<$Res> {
  _$VaultCopyWithImpl(this._self, this._then);

  final Vault _self;
  final $Res Function(Vault) _then;

/// Create a copy of Vault
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? created = freezed,Object? organizationId = freezed,Object? error = freezed,Object? unknown = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [Vault].
extension VaultPatterns on Vault {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vault value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vault() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vault value)  $default,){
final _that = this;
switch (_that) {
case _Vault():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vault value)?  $default,){
final _that = this;
switch (_that) {
case _Vault() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @WebDateNullableConverter()  DateTime? created,  String? organizationId,  String? error, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vault() when $default != null:
return $default(_that.id,_that.name,_that.created,_that.organizationId,_that.error,_that.unknown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @WebDateNullableConverter()  DateTime? created,  String? organizationId,  String? error, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)  $default,) {final _that = this;
switch (_that) {
case _Vault():
return $default(_that.id,_that.name,_that.created,_that.organizationId,_that.error,_that.unknown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @WebDateNullableConverter()  DateTime? created,  String? organizationId,  String? error, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,) {final _that = this;
switch (_that) {
case _Vault() when $default != null:
return $default(_that.id,_that.name,_that.created,_that.organizationId,_that.error,_that.unknown);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, createFieldMap: true)
class _Vault extends Vault {
  const _Vault({required this.id, required this.name, @WebDateNullableConverter() this.created, this.organizationId, this.error, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) final  Map<String, Object?> unknown = const <String, Object?>{}}): _unknown = unknown,super._();
  factory _Vault.fromJson(Map<String, dynamic> json) => _$VaultFromJson(json);

@override final  String id;
@override final  String name;
/// When it was created; absent for a vault written before this existed.
@override@WebDateNullableConverter() final  DateTime? created;
/// Absent for a personal vault.
@override final  String? organizationId;
/// Set when the vault failed to sync.
@override final  String? error;
 final  Map<String, Object?> _unknown;
@override@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown {
  if (_unknown is EqualUnmodifiableMapView) return _unknown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unknown);
}


/// Create a copy of Vault
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaultCopyWith<_Vault> get copyWith => __$VaultCopyWithImpl<_Vault>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vault&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.created, created) || other.created == created)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._unknown, _unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,created,organizationId,error,const DeepCollectionEquality().hash(_unknown));

@override
String toString() {
  return 'Vault(id: $id, name: $name, created: $created, organizationId: $organizationId, error: $error, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class _$VaultCopyWith<$Res> implements $VaultCopyWith<$Res> {
  factory _$VaultCopyWith(_Vault value, $Res Function(_Vault) _then) = __$VaultCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@WebDateNullableConverter() DateTime? created, String? organizationId, String? error,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class __$VaultCopyWithImpl<$Res>
    implements _$VaultCopyWith<$Res> {
  __$VaultCopyWithImpl(this._self, this._then);

  final _Vault _self;
  final $Res Function(_Vault) _then;

/// Create a copy of Vault
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? created = freezed,Object? organizationId = freezed,Object? error = freezed,Object? unknown = null,}) {
  return _then(_Vault(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self._unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
