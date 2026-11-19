// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_secret_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangeSecretState {

 ChangeSecretStep get step; String get current; String get secret; String get repeat;/// Bumped by Generate, so the fields show the new secret.
 int get generation;/// "That is not your current secret." (board `S5-19`).
 bool get wrongCurrent;/// The upload's share, 0–1.
 double get progress; Failure? get failure;
/// Create a copy of ChangeSecretState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeSecretStateCopyWith<ChangeSecretState> get copyWith => _$ChangeSecretStateCopyWithImpl<ChangeSecretState>(this as ChangeSecretState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeSecretState&&(identical(other.step, step) || other.step == step)&&(identical(other.current, current) || other.current == current)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.generation, generation) || other.generation == generation)&&(identical(other.wrongCurrent, wrongCurrent) || other.wrongCurrent == wrongCurrent)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,step,current,secret,repeat,generation,wrongCurrent,progress,failure);

@override
String toString() {
  return 'ChangeSecretState(step: $step, current: $current, secret: $secret, repeat: $repeat, generation: $generation, wrongCurrent: $wrongCurrent, progress: $progress, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ChangeSecretStateCopyWith<$Res>  {
  factory $ChangeSecretStateCopyWith(ChangeSecretState value, $Res Function(ChangeSecretState) _then) = _$ChangeSecretStateCopyWithImpl;
@useResult
$Res call({
 ChangeSecretStep step, String current, String secret, String repeat, int generation, bool wrongCurrent, double progress, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$ChangeSecretStateCopyWithImpl<$Res>
    implements $ChangeSecretStateCopyWith<$Res> {
  _$ChangeSecretStateCopyWithImpl(this._self, this._then);

  final ChangeSecretState _self;
  final $Res Function(ChangeSecretState) _then;

/// Create a copy of ChangeSecretState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? current = null,Object? secret = null,Object? repeat = null,Object? generation = null,Object? wrongCurrent = null,Object? progress = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ChangeSecretStep,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,wrongCurrent: null == wrongCurrent ? _self.wrongCurrent : wrongCurrent // ignore: cast_nullable_to_non_nullable
as bool,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of ChangeSecretState
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


/// Adds pattern-matching-related methods to [ChangeSecretState].
extension ChangeSecretStatePatterns on ChangeSecretState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangeSecretState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangeSecretState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangeSecretState value)  $default,){
final _that = this;
switch (_that) {
case _ChangeSecretState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangeSecretState value)?  $default,){
final _that = this;
switch (_that) {
case _ChangeSecretState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChangeSecretStep step,  String current,  String secret,  String repeat,  int generation,  bool wrongCurrent,  double progress,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangeSecretState() when $default != null:
return $default(_that.step,_that.current,_that.secret,_that.repeat,_that.generation,_that.wrongCurrent,_that.progress,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChangeSecretStep step,  String current,  String secret,  String repeat,  int generation,  bool wrongCurrent,  double progress,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _ChangeSecretState():
return $default(_that.step,_that.current,_that.secret,_that.repeat,_that.generation,_that.wrongCurrent,_that.progress,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChangeSecretStep step,  String current,  String secret,  String repeat,  int generation,  bool wrongCurrent,  double progress,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _ChangeSecretState() when $default != null:
return $default(_that.step,_that.current,_that.secret,_that.repeat,_that.generation,_that.wrongCurrent,_that.progress,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _ChangeSecretState extends ChangeSecretState {
  const _ChangeSecretState({this.step = ChangeSecretStep.form, this.current = '', this.secret = '', this.repeat = '', this.generation = 0, this.wrongCurrent = false, this.progress = 0, this.failure}): super._();
  

@override@JsonKey() final  ChangeSecretStep step;
@override@JsonKey() final  String current;
@override@JsonKey() final  String secret;
@override@JsonKey() final  String repeat;
/// Bumped by Generate, so the fields show the new secret.
@override@JsonKey() final  int generation;
/// "That is not your current secret." (board `S5-19`).
@override@JsonKey() final  bool wrongCurrent;
/// The upload's share, 0–1.
@override@JsonKey() final  double progress;
@override final  Failure? failure;

/// Create a copy of ChangeSecretState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeSecretStateCopyWith<_ChangeSecretState> get copyWith => __$ChangeSecretStateCopyWithImpl<_ChangeSecretState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeSecretState&&(identical(other.step, step) || other.step == step)&&(identical(other.current, current) || other.current == current)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.generation, generation) || other.generation == generation)&&(identical(other.wrongCurrent, wrongCurrent) || other.wrongCurrent == wrongCurrent)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,step,current,secret,repeat,generation,wrongCurrent,progress,failure);

@override
String toString() {
  return 'ChangeSecretState(step: $step, current: $current, secret: $secret, repeat: $repeat, generation: $generation, wrongCurrent: $wrongCurrent, progress: $progress, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ChangeSecretStateCopyWith<$Res> implements $ChangeSecretStateCopyWith<$Res> {
  factory _$ChangeSecretStateCopyWith(_ChangeSecretState value, $Res Function(_ChangeSecretState) _then) = __$ChangeSecretStateCopyWithImpl;
@override @useResult
$Res call({
 ChangeSecretStep step, String current, String secret, String repeat, int generation, bool wrongCurrent, double progress, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$ChangeSecretStateCopyWithImpl<$Res>
    implements _$ChangeSecretStateCopyWith<$Res> {
  __$ChangeSecretStateCopyWithImpl(this._self, this._then);

  final _ChangeSecretState _self;
  final $Res Function(_ChangeSecretState) _then;

/// Create a copy of ChangeSecretState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? current = null,Object? secret = null,Object? repeat = null,Object? generation = null,Object? wrongCurrent = null,Object? progress = null,Object? failure = freezed,}) {
  return _then(_ChangeSecretState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ChangeSecretStep,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,wrongCurrent: null == wrongCurrent ? _self.wrongCurrent : wrongCurrent // ignore: cast_nullable_to_non_nullable
as bool,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ChangeSecretState
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
