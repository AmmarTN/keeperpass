// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuditResult {

 AuditType get type; int get fieldIndex;
/// Create a copy of AuditResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditResultCopyWith<AuditResult> get copyWith => _$AuditResultCopyWithImpl<AuditResult>(this as AuditResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditResult&&(identical(other.type, type) || other.type == type)&&(identical(other.fieldIndex, fieldIndex) || other.fieldIndex == fieldIndex));
}


@override
int get hashCode => Object.hash(runtimeType,type,fieldIndex);

@override
String toString() {
  return 'AuditResult(type: $type, fieldIndex: $fieldIndex)';
}


}

/// @nodoc
abstract mixin class $AuditResultCopyWith<$Res>  {
  factory $AuditResultCopyWith(AuditResult value, $Res Function(AuditResult) _then) = _$AuditResultCopyWithImpl;
@useResult
$Res call({
 AuditType type, int fieldIndex
});




}
/// @nodoc
class _$AuditResultCopyWithImpl<$Res>
    implements $AuditResultCopyWith<$Res> {
  _$AuditResultCopyWithImpl(this._self, this._then);

  final AuditResult _self;
  final $Res Function(AuditResult) _then;

/// Create a copy of AuditResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? fieldIndex = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AuditType,fieldIndex: null == fieldIndex ? _self.fieldIndex : fieldIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditResult].
extension AuditResultPatterns on AuditResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditResult value)  $default,){
final _that = this;
switch (_that) {
case _AuditResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditResult value)?  $default,){
final _that = this;
switch (_that) {
case _AuditResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuditType type,  int fieldIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditResult() when $default != null:
return $default(_that.type,_that.fieldIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuditType type,  int fieldIndex)  $default,) {final _that = this;
switch (_that) {
case _AuditResult():
return $default(_that.type,_that.fieldIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuditType type,  int fieldIndex)?  $default,) {final _that = this;
switch (_that) {
case _AuditResult() when $default != null:
return $default(_that.type,_that.fieldIndex);case _:
  return null;

}
}

}

/// @nodoc


class _AuditResult implements AuditResult {
  const _AuditResult({required this.type, required this.fieldIndex});
  

@override final  AuditType type;
@override final  int fieldIndex;

/// Create a copy of AuditResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditResultCopyWith<_AuditResult> get copyWith => __$AuditResultCopyWithImpl<_AuditResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditResult&&(identical(other.type, type) || other.type == type)&&(identical(other.fieldIndex, fieldIndex) || other.fieldIndex == fieldIndex));
}


@override
int get hashCode => Object.hash(runtimeType,type,fieldIndex);

@override
String toString() {
  return 'AuditResult(type: $type, fieldIndex: $fieldIndex)';
}


}

/// @nodoc
abstract mixin class _$AuditResultCopyWith<$Res> implements $AuditResultCopyWith<$Res> {
  factory _$AuditResultCopyWith(_AuditResult value, $Res Function(_AuditResult) _then) = __$AuditResultCopyWithImpl;
@override @useResult
$Res call({
 AuditType type, int fieldIndex
});




}
/// @nodoc
class __$AuditResultCopyWithImpl<$Res>
    implements _$AuditResultCopyWith<$Res> {
  __$AuditResultCopyWithImpl(this._self, this._then);

  final _AuditResult _self;
  final $Res Function(_AuditResult) _then;

/// Create a copy of AuditResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? fieldIndex = null,}) {
  return _then(_AuditResult(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AuditType,fieldIndex: null == fieldIndex ? _self.fieldIndex : fieldIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
