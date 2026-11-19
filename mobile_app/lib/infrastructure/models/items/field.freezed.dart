// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Field {

 String get name; String get value;/// The stored type string — kept as written so a type from a newer app
/// survives a round trip. Read it through [type].
@JsonKey(name: 'type') String get typeValue;/// Overrides the type's default "secret" for this one field; null means
/// "use the type's default" (web `fieldIsSecret`).
 bool? get secret;/// A Font Awesome code point picked from the catalogue (hex).
 String? get iconGlyph;@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown;
/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldCopyWith<Field> get copyWith => _$FieldCopyWithImpl<Field>(this as Field, _$identity);

  /// Serializes this Field to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Field&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value)&&(identical(other.typeValue, typeValue) || other.typeValue == typeValue)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&const DeepCollectionEquality().equals(other.unknown, unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,value,typeValue,secret,iconGlyph,const DeepCollectionEquality().hash(unknown));

@override
String toString() {
  return 'Field(name: $name, value: $value, typeValue: $typeValue, secret: $secret, iconGlyph: $iconGlyph, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class $FieldCopyWith<$Res>  {
  factory $FieldCopyWith(Field value, $Res Function(Field) _then) = _$FieldCopyWithImpl;
@useResult
$Res call({
 String name, String value,@JsonKey(name: 'type') String typeValue, bool? secret, String? iconGlyph,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class _$FieldCopyWithImpl<$Res>
    implements $FieldCopyWith<$Res> {
  _$FieldCopyWithImpl(this._self, this._then);

  final Field _self;
  final $Res Function(Field) _then;

/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,Object? typeValue = null,Object? secret = freezed,Object? iconGlyph = freezed,Object? unknown = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,typeValue: null == typeValue ? _self.typeValue : typeValue // ignore: cast_nullable_to_non_nullable
as String,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as bool?,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [Field].
extension FieldPatterns on Field {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Field value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Field() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Field value)  $default,){
final _that = this;
switch (_that) {
case _Field():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Field value)?  $default,){
final _that = this;
switch (_that) {
case _Field() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String value, @JsonKey(name: 'type')  String typeValue,  bool? secret,  String? iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Field() when $default != null:
return $default(_that.name,_that.value,_that.typeValue,_that.secret,_that.iconGlyph,_that.unknown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String value, @JsonKey(name: 'type')  String typeValue,  bool? secret,  String? iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)  $default,) {final _that = this;
switch (_that) {
case _Field():
return $default(_that.name,_that.value,_that.typeValue,_that.secret,_that.iconGlyph,_that.unknown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String value, @JsonKey(name: 'type')  String typeValue,  bool? secret,  String? iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,) {final _that = this;
switch (_that) {
case _Field() when $default != null:
return $default(_that.name,_that.value,_that.typeValue,_that.secret,_that.iconGlyph,_that.unknown);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, createFieldMap: true)
class _Field extends Field {
  const _Field({required this.name, required this.value, @JsonKey(name: 'type') required this.typeValue, this.secret, this.iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) final  Map<String, Object?> unknown = const <String, Object?>{}}): _unknown = unknown,super._();
  factory _Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

@override final  String name;
@override final  String value;
/// The stored type string — kept as written so a type from a newer app
/// survives a round trip. Read it through [type].
@override@JsonKey(name: 'type') final  String typeValue;
/// Overrides the type's default "secret" for this one field; null means
/// "use the type's default" (web `fieldIsSecret`).
@override final  bool? secret;
/// A Font Awesome code point picked from the catalogue (hex).
@override final  String? iconGlyph;
 final  Map<String, Object?> _unknown;
@override@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown {
  if (_unknown is EqualUnmodifiableMapView) return _unknown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unknown);
}


/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldCopyWith<_Field> get copyWith => __$FieldCopyWithImpl<_Field>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Field&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value)&&(identical(other.typeValue, typeValue) || other.typeValue == typeValue)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&const DeepCollectionEquality().equals(other._unknown, _unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,value,typeValue,secret,iconGlyph,const DeepCollectionEquality().hash(_unknown));

@override
String toString() {
  return 'Field(name: $name, value: $value, typeValue: $typeValue, secret: $secret, iconGlyph: $iconGlyph, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class _$FieldCopyWith<$Res> implements $FieldCopyWith<$Res> {
  factory _$FieldCopyWith(_Field value, $Res Function(_Field) _then) = __$FieldCopyWithImpl;
@override @useResult
$Res call({
 String name, String value,@JsonKey(name: 'type') String typeValue, bool? secret, String? iconGlyph,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class __$FieldCopyWithImpl<$Res>
    implements _$FieldCopyWith<$Res> {
  __$FieldCopyWithImpl(this._self, this._then);

  final _Field _self;
  final $Res Function(_Field) _then;

/// Create a copy of Field
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = null,Object? typeValue = null,Object? secret = freezed,Object? iconGlyph = freezed,Object? unknown = null,}) {
  return _then(_Field(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,typeValue: null == typeValue ? _self.typeValue : typeValue // ignore: cast_nullable_to_non_nullable
as String,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as bool?,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self._unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
