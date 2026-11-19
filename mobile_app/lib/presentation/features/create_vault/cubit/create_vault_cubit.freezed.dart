// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_vault_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateVaultState {

 CreateStep get step; String get secret;/// Five generated words: no retype step, shown as word tiles.
 bool get generated; String get repeat;/// "I've written my secret down".
 bool get acknowledged; CreateStage get stage; Failure? get failure;/// Bumped by each generation, so the field shows the new words.
 int get generation;
/// Create a copy of CreateVaultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVaultStateCopyWith<CreateVaultState> get copyWith => _$CreateVaultStateCopyWithImpl<CreateVaultState>(this as CreateVaultState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVaultState&&(identical(other.step, step) || other.step == step)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.generated, generated) || other.generated == generated)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.generation, generation) || other.generation == generation));
}


@override
int get hashCode => Object.hash(runtimeType,step,secret,generated,repeat,acknowledged,stage,failure,generation);

@override
String toString() {
  return 'CreateVaultState(step: $step, secret: $secret, generated: $generated, repeat: $repeat, acknowledged: $acknowledged, stage: $stage, failure: $failure, generation: $generation)';
}


}

/// @nodoc
abstract mixin class $CreateVaultStateCopyWith<$Res>  {
  factory $CreateVaultStateCopyWith(CreateVaultState value, $Res Function(CreateVaultState) _then) = _$CreateVaultStateCopyWithImpl;
@useResult
$Res call({
 CreateStep step, String secret, bool generated, String repeat, bool acknowledged, CreateStage stage, Failure? failure, int generation
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$CreateVaultStateCopyWithImpl<$Res>
    implements $CreateVaultStateCopyWith<$Res> {
  _$CreateVaultStateCopyWithImpl(this._self, this._then);

  final CreateVaultState _self;
  final $Res Function(CreateVaultState) _then;

/// Create a copy of CreateVaultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? secret = null,Object? generated = null,Object? repeat = null,Object? acknowledged = null,Object? stage = null,Object? failure = freezed,Object? generation = null,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CreateStep,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,generated: null == generated ? _self.generated : generated // ignore: cast_nullable_to_non_nullable
as bool,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as CreateStage,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CreateVaultState
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


/// Adds pattern-matching-related methods to [CreateVaultState].
extension CreateVaultStatePatterns on CreateVaultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateVaultState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateVaultState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateVaultState value)  $default,){
final _that = this;
switch (_that) {
case _CreateVaultState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateVaultState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateVaultState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CreateStep step,  String secret,  bool generated,  String repeat,  bool acknowledged,  CreateStage stage,  Failure? failure,  int generation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateVaultState() when $default != null:
return $default(_that.step,_that.secret,_that.generated,_that.repeat,_that.acknowledged,_that.stage,_that.failure,_that.generation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CreateStep step,  String secret,  bool generated,  String repeat,  bool acknowledged,  CreateStage stage,  Failure? failure,  int generation)  $default,) {final _that = this;
switch (_that) {
case _CreateVaultState():
return $default(_that.step,_that.secret,_that.generated,_that.repeat,_that.acknowledged,_that.stage,_that.failure,_that.generation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CreateStep step,  String secret,  bool generated,  String repeat,  bool acknowledged,  CreateStage stage,  Failure? failure,  int generation)?  $default,) {final _that = this;
switch (_that) {
case _CreateVaultState() when $default != null:
return $default(_that.step,_that.secret,_that.generated,_that.repeat,_that.acknowledged,_that.stage,_that.failure,_that.generation);case _:
  return null;

}
}

}

/// @nodoc


class _CreateVaultState extends CreateVaultState {
  const _CreateVaultState({this.step = CreateStep.secret, this.secret = '', this.generated = false, this.repeat = '', this.acknowledged = false, this.stage = CreateStage.encrypting, this.failure, this.generation = 0}): super._();
  

@override@JsonKey() final  CreateStep step;
@override@JsonKey() final  String secret;
/// Five generated words: no retype step, shown as word tiles.
@override@JsonKey() final  bool generated;
@override@JsonKey() final  String repeat;
/// "I've written my secret down".
@override@JsonKey() final  bool acknowledged;
@override@JsonKey() final  CreateStage stage;
@override final  Failure? failure;
/// Bumped by each generation, so the field shows the new words.
@override@JsonKey() final  int generation;

/// Create a copy of CreateVaultState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVaultStateCopyWith<_CreateVaultState> get copyWith => __$CreateVaultStateCopyWithImpl<_CreateVaultState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVaultState&&(identical(other.step, step) || other.step == step)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.generated, generated) || other.generated == generated)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.generation, generation) || other.generation == generation));
}


@override
int get hashCode => Object.hash(runtimeType,step,secret,generated,repeat,acknowledged,stage,failure,generation);

@override
String toString() {
  return 'CreateVaultState(step: $step, secret: $secret, generated: $generated, repeat: $repeat, acknowledged: $acknowledged, stage: $stage, failure: $failure, generation: $generation)';
}


}

/// @nodoc
abstract mixin class _$CreateVaultStateCopyWith<$Res> implements $CreateVaultStateCopyWith<$Res> {
  factory _$CreateVaultStateCopyWith(_CreateVaultState value, $Res Function(_CreateVaultState) _then) = __$CreateVaultStateCopyWithImpl;
@override @useResult
$Res call({
 CreateStep step, String secret, bool generated, String repeat, bool acknowledged, CreateStage stage, Failure? failure, int generation
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$CreateVaultStateCopyWithImpl<$Res>
    implements _$CreateVaultStateCopyWith<$Res> {
  __$CreateVaultStateCopyWithImpl(this._self, this._then);

  final _CreateVaultState _self;
  final $Res Function(_CreateVaultState) _then;

/// Create a copy of CreateVaultState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? secret = null,Object? generated = null,Object? repeat = null,Object? acknowledged = null,Object? stage = null,Object? failure = freezed,Object? generation = null,}) {
  return _then(_CreateVaultState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CreateStep,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,generated: null == generated ? _self.generated : generated // ignore: cast_nullable_to_non_nullable
as bool,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as CreateStage,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CreateVaultState
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
