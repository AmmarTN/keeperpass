// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_secret_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangeSecretDto {

 String get currentSecret; String get newSecret; UploadProgress? get onProgress;/// The current secret opened the stored vault; encrypting under the new
/// one starts (board `S5-20`'s second step).
 void Function()? get onVerified;
/// Create a copy of ChangeSecretDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeSecretDtoCopyWith<ChangeSecretDto> get copyWith => _$ChangeSecretDtoCopyWithImpl<ChangeSecretDto>(this as ChangeSecretDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeSecretDto&&(identical(other.currentSecret, currentSecret) || other.currentSecret == currentSecret)&&(identical(other.newSecret, newSecret) || other.newSecret == newSecret)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress)&&(identical(other.onVerified, onVerified) || other.onVerified == onVerified));
}


@override
int get hashCode => Object.hash(runtimeType,currentSecret,newSecret,onProgress,onVerified);

@override
String toString() {
  return 'ChangeSecretDto(currentSecret: $currentSecret, newSecret: $newSecret, onProgress: $onProgress, onVerified: $onVerified)';
}


}

/// @nodoc
abstract mixin class $ChangeSecretDtoCopyWith<$Res>  {
  factory $ChangeSecretDtoCopyWith(ChangeSecretDto value, $Res Function(ChangeSecretDto) _then) = _$ChangeSecretDtoCopyWithImpl;
@useResult
$Res call({
 String currentSecret, String newSecret, UploadProgress? onProgress, void Function()? onVerified
});




}
/// @nodoc
class _$ChangeSecretDtoCopyWithImpl<$Res>
    implements $ChangeSecretDtoCopyWith<$Res> {
  _$ChangeSecretDtoCopyWithImpl(this._self, this._then);

  final ChangeSecretDto _self;
  final $Res Function(ChangeSecretDto) _then;

/// Create a copy of ChangeSecretDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentSecret = null,Object? newSecret = null,Object? onProgress = freezed,Object? onVerified = freezed,}) {
  return _then(_self.copyWith(
currentSecret: null == currentSecret ? _self.currentSecret : currentSecret // ignore: cast_nullable_to_non_nullable
as String,newSecret: null == newSecret ? _self.newSecret : newSecret // ignore: cast_nullable_to_non_nullable
as String,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as UploadProgress?,onVerified: freezed == onVerified ? _self.onVerified : onVerified // ignore: cast_nullable_to_non_nullable
as void Function()?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangeSecretDto].
extension ChangeSecretDtoPatterns on ChangeSecretDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangeSecretDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangeSecretDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangeSecretDto value)  $default,){
final _that = this;
switch (_that) {
case _ChangeSecretDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangeSecretDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChangeSecretDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currentSecret,  String newSecret,  UploadProgress? onProgress,  void Function()? onVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangeSecretDto() when $default != null:
return $default(_that.currentSecret,_that.newSecret,_that.onProgress,_that.onVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currentSecret,  String newSecret,  UploadProgress? onProgress,  void Function()? onVerified)  $default,) {final _that = this;
switch (_that) {
case _ChangeSecretDto():
return $default(_that.currentSecret,_that.newSecret,_that.onProgress,_that.onVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currentSecret,  String newSecret,  UploadProgress? onProgress,  void Function()? onVerified)?  $default,) {final _that = this;
switch (_that) {
case _ChangeSecretDto() when $default != null:
return $default(_that.currentSecret,_that.newSecret,_that.onProgress,_that.onVerified);case _:
  return null;

}
}

}

/// @nodoc


class _ChangeSecretDto implements ChangeSecretDto {
  const _ChangeSecretDto({required this.currentSecret, required this.newSecret, this.onProgress, this.onVerified});
  

@override final  String currentSecret;
@override final  String newSecret;
@override final  UploadProgress? onProgress;
/// The current secret opened the stored vault; encrypting under the new
/// one starts (board `S5-20`'s second step).
@override final  void Function()? onVerified;

/// Create a copy of ChangeSecretDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeSecretDtoCopyWith<_ChangeSecretDto> get copyWith => __$ChangeSecretDtoCopyWithImpl<_ChangeSecretDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeSecretDto&&(identical(other.currentSecret, currentSecret) || other.currentSecret == currentSecret)&&(identical(other.newSecret, newSecret) || other.newSecret == newSecret)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress)&&(identical(other.onVerified, onVerified) || other.onVerified == onVerified));
}


@override
int get hashCode => Object.hash(runtimeType,currentSecret,newSecret,onProgress,onVerified);

@override
String toString() {
  return 'ChangeSecretDto(currentSecret: $currentSecret, newSecret: $newSecret, onProgress: $onProgress, onVerified: $onVerified)';
}


}

/// @nodoc
abstract mixin class _$ChangeSecretDtoCopyWith<$Res> implements $ChangeSecretDtoCopyWith<$Res> {
  factory _$ChangeSecretDtoCopyWith(_ChangeSecretDto value, $Res Function(_ChangeSecretDto) _then) = __$ChangeSecretDtoCopyWithImpl;
@override @useResult
$Res call({
 String currentSecret, String newSecret, UploadProgress? onProgress, void Function()? onVerified
});




}
/// @nodoc
class __$ChangeSecretDtoCopyWithImpl<$Res>
    implements _$ChangeSecretDtoCopyWith<$Res> {
  __$ChangeSecretDtoCopyWithImpl(this._self, this._then);

  final _ChangeSecretDto _self;
  final $Res Function(_ChangeSecretDto) _then;

/// Create a copy of ChangeSecretDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentSecret = null,Object? newSecret = null,Object? onProgress = freezed,Object? onVerified = freezed,}) {
  return _then(_ChangeSecretDto(
currentSecret: null == currentSecret ? _self.currentSecret : currentSecret // ignore: cast_nullable_to_non_nullable
as String,newSecret: null == newSecret ? _self.newSecret : newSecret // ignore: cast_nullable_to_non_nullable
as String,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as UploadProgress?,onVerified: freezed == onVerified ? _self.onVerified : onVerified // ignore: cast_nullable_to_non_nullable
as void Function()?,
  ));
}


}

// dart format on
