// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'run_audit_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RunAuditDto {

 String? get onlyItemId; AuditProgress? get onProgress;
/// Create a copy of RunAuditDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RunAuditDtoCopyWith<RunAuditDto> get copyWith => _$RunAuditDtoCopyWithImpl<RunAuditDto>(this as RunAuditDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RunAuditDto&&(identical(other.onlyItemId, onlyItemId) || other.onlyItemId == onlyItemId)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,onlyItemId,onProgress);

@override
String toString() {
  return 'RunAuditDto(onlyItemId: $onlyItemId, onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class $RunAuditDtoCopyWith<$Res>  {
  factory $RunAuditDtoCopyWith(RunAuditDto value, $Res Function(RunAuditDto) _then) = _$RunAuditDtoCopyWithImpl;
@useResult
$Res call({
 String? onlyItemId, AuditProgress? onProgress
});




}
/// @nodoc
class _$RunAuditDtoCopyWithImpl<$Res>
    implements $RunAuditDtoCopyWith<$Res> {
  _$RunAuditDtoCopyWithImpl(this._self, this._then);

  final RunAuditDto _self;
  final $Res Function(RunAuditDto) _then;

/// Create a copy of RunAuditDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onlyItemId = freezed,Object? onProgress = freezed,}) {
  return _then(_self.copyWith(
onlyItemId: freezed == onlyItemId ? _self.onlyItemId : onlyItemId // ignore: cast_nullable_to_non_nullable
as String?,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as AuditProgress?,
  ));
}

}


/// Adds pattern-matching-related methods to [RunAuditDto].
extension RunAuditDtoPatterns on RunAuditDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RunAuditDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RunAuditDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RunAuditDto value)  $default,){
final _that = this;
switch (_that) {
case _RunAuditDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RunAuditDto value)?  $default,){
final _that = this;
switch (_that) {
case _RunAuditDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? onlyItemId,  AuditProgress? onProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RunAuditDto() when $default != null:
return $default(_that.onlyItemId,_that.onProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? onlyItemId,  AuditProgress? onProgress)  $default,) {final _that = this;
switch (_that) {
case _RunAuditDto():
return $default(_that.onlyItemId,_that.onProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? onlyItemId,  AuditProgress? onProgress)?  $default,) {final _that = this;
switch (_that) {
case _RunAuditDto() when $default != null:
return $default(_that.onlyItemId,_that.onProgress);case _:
  return null;

}
}

}

/// @nodoc


class _RunAuditDto implements RunAuditDto {
  const _RunAuditDto({this.onlyItemId, this.onProgress});
  

@override final  String? onlyItemId;
@override final  AuditProgress? onProgress;

/// Create a copy of RunAuditDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RunAuditDtoCopyWith<_RunAuditDto> get copyWith => __$RunAuditDtoCopyWithImpl<_RunAuditDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RunAuditDto&&(identical(other.onlyItemId, onlyItemId) || other.onlyItemId == onlyItemId)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,onlyItemId,onProgress);

@override
String toString() {
  return 'RunAuditDto(onlyItemId: $onlyItemId, onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class _$RunAuditDtoCopyWith<$Res> implements $RunAuditDtoCopyWith<$Res> {
  factory _$RunAuditDtoCopyWith(_RunAuditDto value, $Res Function(_RunAuditDto) _then) = __$RunAuditDtoCopyWithImpl;
@override @useResult
$Res call({
 String? onlyItemId, AuditProgress? onProgress
});




}
/// @nodoc
class __$RunAuditDtoCopyWithImpl<$Res>
    implements _$RunAuditDtoCopyWith<$Res> {
  __$RunAuditDtoCopyWithImpl(this._self, this._then);

  final _RunAuditDto _self;
  final $Res Function(_RunAuditDto) _then;

/// Create a copy of RunAuditDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onlyItemId = freezed,Object? onProgress = freezed,}) {
  return _then(_RunAuditDto(
onlyItemId: freezed == onlyItemId ? _self.onlyItemId : onlyItemId // ignore: cast_nullable_to_non_nullable
as String?,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as AuditProgress?,
  ));
}


}

// dart format on
