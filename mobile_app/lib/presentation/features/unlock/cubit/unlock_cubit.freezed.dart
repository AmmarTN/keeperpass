// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unlock_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnlockState {

 UnlockStatus get status; Failure? get failure;/// Bumped on each wrong secret: the dial shakes and rings red.
 int get wrongAttempts;
/// Create a copy of UnlockState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlockStateCopyWith<UnlockState> get copyWith => _$UnlockStateCopyWithImpl<UnlockState>(this as UnlockState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,wrongAttempts);

@override
String toString() {
  return 'UnlockState(status: $status, failure: $failure, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class $UnlockStateCopyWith<$Res>  {
  factory $UnlockStateCopyWith(UnlockState value, $Res Function(UnlockState) _then) = _$UnlockStateCopyWithImpl;
@useResult
$Res call({
 UnlockStatus status, Failure? failure, int wrongAttempts
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$UnlockStateCopyWithImpl<$Res>
    implements $UnlockStateCopyWith<$Res> {
  _$UnlockStateCopyWithImpl(this._self, this._then);

  final UnlockState _self;
  final $Res Function(UnlockState) _then;

/// Create a copy of UnlockState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? failure = freezed,Object? wrongAttempts = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UnlockStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of UnlockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [UnlockState].
extension UnlockStatePatterns on UnlockState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnlockState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnlockState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnlockState value)  $default,){
final _that = this;
switch (_that) {
case _UnlockState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnlockState value)?  $default,){
final _that = this;
switch (_that) {
case _UnlockState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UnlockStatus status,  Failure? failure,  int wrongAttempts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnlockState() when $default != null:
return $default(_that.status,_that.failure,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UnlockStatus status,  Failure? failure,  int wrongAttempts)  $default,) {final _that = this;
switch (_that) {
case _UnlockState():
return $default(_that.status,_that.failure,_that.wrongAttempts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UnlockStatus status,  Failure? failure,  int wrongAttempts)?  $default,) {final _that = this;
switch (_that) {
case _UnlockState() when $default != null:
return $default(_that.status,_that.failure,_that.wrongAttempts);case _:
  return null;

}
}

}

/// @nodoc


class _UnlockState implements UnlockState {
  const _UnlockState({this.status = UnlockStatus.idle, this.failure, this.wrongAttempts = 0});
  

@override@JsonKey() final  UnlockStatus status;
@override final  Failure? failure;
/// Bumped on each wrong secret: the dial shakes and rings red.
@override@JsonKey() final  int wrongAttempts;

/// Create a copy of UnlockState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnlockStateCopyWith<_UnlockState> get copyWith => __$UnlockStateCopyWithImpl<_UnlockState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnlockState&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.wrongAttempts, wrongAttempts) || other.wrongAttempts == wrongAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,wrongAttempts);

@override
String toString() {
  return 'UnlockState(status: $status, failure: $failure, wrongAttempts: $wrongAttempts)';
}


}

/// @nodoc
abstract mixin class _$UnlockStateCopyWith<$Res> implements $UnlockStateCopyWith<$Res> {
  factory _$UnlockStateCopyWith(_UnlockState value, $Res Function(_UnlockState) _then) = __$UnlockStateCopyWithImpl;
@override @useResult
$Res call({
 UnlockStatus status, Failure? failure, int wrongAttempts
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$UnlockStateCopyWithImpl<$Res>
    implements _$UnlockStateCopyWith<$Res> {
  __$UnlockStateCopyWithImpl(this._self, this._then);

  final _UnlockState _self;
  final $Res Function(_UnlockState) _then;

/// Create a copy of UnlockState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? failure = freezed,Object? wrongAttempts = null,}) {
  return _then(_UnlockState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UnlockStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,wrongAttempts: null == wrongAttempts ? _self.wrongAttempts : wrongAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of UnlockState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
