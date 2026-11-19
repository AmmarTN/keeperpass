// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_vault_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaveVaultDto {

 UploadProgress? get onProgress;
/// Create a copy of SaveVaultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveVaultDtoCopyWith<SaveVaultDto> get copyWith => _$SaveVaultDtoCopyWithImpl<SaveVaultDto>(this as SaveVaultDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveVaultDto&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,onProgress);

@override
String toString() {
  return 'SaveVaultDto(onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class $SaveVaultDtoCopyWith<$Res>  {
  factory $SaveVaultDtoCopyWith(SaveVaultDto value, $Res Function(SaveVaultDto) _then) = _$SaveVaultDtoCopyWithImpl;
@useResult
$Res call({
 UploadProgress? onProgress
});




}
/// @nodoc
class _$SaveVaultDtoCopyWithImpl<$Res>
    implements $SaveVaultDtoCopyWith<$Res> {
  _$SaveVaultDtoCopyWithImpl(this._self, this._then);

  final SaveVaultDto _self;
  final $Res Function(SaveVaultDto) _then;

/// Create a copy of SaveVaultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onProgress = freezed,}) {
  return _then(_self.copyWith(
onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as UploadProgress?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaveVaultDto].
extension SaveVaultDtoPatterns on SaveVaultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaveVaultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaveVaultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaveVaultDto value)  $default,){
final _that = this;
switch (_that) {
case _SaveVaultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaveVaultDto value)?  $default,){
final _that = this;
switch (_that) {
case _SaveVaultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UploadProgress? onProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaveVaultDto() when $default != null:
return $default(_that.onProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UploadProgress? onProgress)  $default,) {final _that = this;
switch (_that) {
case _SaveVaultDto():
return $default(_that.onProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UploadProgress? onProgress)?  $default,) {final _that = this;
switch (_that) {
case _SaveVaultDto() when $default != null:
return $default(_that.onProgress);case _:
  return null;

}
}

}

/// @nodoc


class _SaveVaultDto implements SaveVaultDto {
  const _SaveVaultDto({this.onProgress});
  

@override final  UploadProgress? onProgress;

/// Create a copy of SaveVaultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveVaultDtoCopyWith<_SaveVaultDto> get copyWith => __$SaveVaultDtoCopyWithImpl<_SaveVaultDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveVaultDto&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,onProgress);

@override
String toString() {
  return 'SaveVaultDto(onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class _$SaveVaultDtoCopyWith<$Res> implements $SaveVaultDtoCopyWith<$Res> {
  factory _$SaveVaultDtoCopyWith(_SaveVaultDto value, $Res Function(_SaveVaultDto) _then) = __$SaveVaultDtoCopyWithImpl;
@override @useResult
$Res call({
 UploadProgress? onProgress
});




}
/// @nodoc
class __$SaveVaultDtoCopyWithImpl<$Res>
    implements _$SaveVaultDtoCopyWith<$Res> {
  __$SaveVaultDtoCopyWithImpl(this._self, this._then);

  final _SaveVaultDto _self;
  final $Res Function(_SaveVaultDto) _then;

/// Create a copy of SaveVaultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onProgress = freezed,}) {
  return _then(_SaveVaultDto(
onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as UploadProgress?,
  ));
}


}

// dart format on
