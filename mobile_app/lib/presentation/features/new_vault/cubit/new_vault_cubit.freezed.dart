// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_vault_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewVaultState {

 DateTime get backupAt; NewVaultStep get step; String get secret; String get repeat; NewVaultStage get stage; Failure? get failure;/// Bumped by each generation, so the fields show the new words.
 int get generation;
/// Create a copy of NewVaultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewVaultStateCopyWith<NewVaultState> get copyWith => _$NewVaultStateCopyWithImpl<NewVaultState>(this as NewVaultState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewVaultState&&(identical(other.backupAt, backupAt) || other.backupAt == backupAt)&&(identical(other.step, step) || other.step == step)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.generation, generation) || other.generation == generation));
}


@override
int get hashCode => Object.hash(runtimeType,backupAt,step,secret,repeat,stage,failure,generation);

@override
String toString() {
  return 'NewVaultState(backupAt: $backupAt, step: $step, secret: $secret, repeat: $repeat, stage: $stage, failure: $failure, generation: $generation)';
}


}

/// @nodoc
abstract mixin class $NewVaultStateCopyWith<$Res>  {
  factory $NewVaultStateCopyWith(NewVaultState value, $Res Function(NewVaultState) _then) = _$NewVaultStateCopyWithImpl;
@useResult
$Res call({
 DateTime backupAt, NewVaultStep step, String secret, String repeat, NewVaultStage stage, Failure? failure, int generation
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$NewVaultStateCopyWithImpl<$Res>
    implements $NewVaultStateCopyWith<$Res> {
  _$NewVaultStateCopyWithImpl(this._self, this._then);

  final NewVaultState _self;
  final $Res Function(NewVaultState) _then;

/// Create a copy of NewVaultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backupAt = null,Object? step = null,Object? secret = null,Object? repeat = null,Object? stage = null,Object? failure = freezed,Object? generation = null,}) {
  return _then(_self.copyWith(
backupAt: null == backupAt ? _self.backupAt : backupAt // ignore: cast_nullable_to_non_nullable
as DateTime,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as NewVaultStep,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as NewVaultStage,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of NewVaultState
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


/// Adds pattern-matching-related methods to [NewVaultState].
extension NewVaultStatePatterns on NewVaultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewVaultState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewVaultState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewVaultState value)  $default,){
final _that = this;
switch (_that) {
case _NewVaultState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewVaultState value)?  $default,){
final _that = this;
switch (_that) {
case _NewVaultState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime backupAt,  NewVaultStep step,  String secret,  String repeat,  NewVaultStage stage,  Failure? failure,  int generation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewVaultState() when $default != null:
return $default(_that.backupAt,_that.step,_that.secret,_that.repeat,_that.stage,_that.failure,_that.generation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime backupAt,  NewVaultStep step,  String secret,  String repeat,  NewVaultStage stage,  Failure? failure,  int generation)  $default,) {final _that = this;
switch (_that) {
case _NewVaultState():
return $default(_that.backupAt,_that.step,_that.secret,_that.repeat,_that.stage,_that.failure,_that.generation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime backupAt,  NewVaultStep step,  String secret,  String repeat,  NewVaultStage stage,  Failure? failure,  int generation)?  $default,) {final _that = this;
switch (_that) {
case _NewVaultState() when $default != null:
return $default(_that.backupAt,_that.step,_that.secret,_that.repeat,_that.stage,_that.failure,_that.generation);case _:
  return null;

}
}

}

/// @nodoc


class _NewVaultState extends NewVaultState {
  const _NewVaultState({required this.backupAt, this.step = NewVaultStep.form, this.secret = '', this.repeat = '', this.stage = NewVaultStage.encrypting, this.failure, this.generation = 0}): super._();
  

@override final  DateTime backupAt;
@override@JsonKey() final  NewVaultStep step;
@override@JsonKey() final  String secret;
@override@JsonKey() final  String repeat;
@override@JsonKey() final  NewVaultStage stage;
@override final  Failure? failure;
/// Bumped by each generation, so the fields show the new words.
@override@JsonKey() final  int generation;

/// Create a copy of NewVaultState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewVaultStateCopyWith<_NewVaultState> get copyWith => __$NewVaultStateCopyWithImpl<_NewVaultState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewVaultState&&(identical(other.backupAt, backupAt) || other.backupAt == backupAt)&&(identical(other.step, step) || other.step == step)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.generation, generation) || other.generation == generation));
}


@override
int get hashCode => Object.hash(runtimeType,backupAt,step,secret,repeat,stage,failure,generation);

@override
String toString() {
  return 'NewVaultState(backupAt: $backupAt, step: $step, secret: $secret, repeat: $repeat, stage: $stage, failure: $failure, generation: $generation)';
}


}

/// @nodoc
abstract mixin class _$NewVaultStateCopyWith<$Res> implements $NewVaultStateCopyWith<$Res> {
  factory _$NewVaultStateCopyWith(_NewVaultState value, $Res Function(_NewVaultState) _then) = __$NewVaultStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime backupAt, NewVaultStep step, String secret, String repeat, NewVaultStage stage, Failure? failure, int generation
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$NewVaultStateCopyWithImpl<$Res>
    implements _$NewVaultStateCopyWith<$Res> {
  __$NewVaultStateCopyWithImpl(this._self, this._then);

  final _NewVaultState _self;
  final $Res Function(_NewVaultState) _then;

/// Create a copy of NewVaultState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backupAt = null,Object? step = null,Object? secret = null,Object? repeat = null,Object? stage = null,Object? failure = freezed,Object? generation = null,}) {
  return _then(_NewVaultState(
backupAt: null == backupAt ? _self.backupAt : backupAt // ignore: cast_nullable_to_non_nullable
as DateTime,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as NewVaultStep,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as NewVaultStage,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of NewVaultState
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
