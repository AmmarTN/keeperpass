// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'move_vault_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoveVaultState {

 MoveVaultStep get step;/// The storage the vault leaves, and the one it goes to.
 ProviderId? get from; ProviderId? get destination;/// Signing in to the destination.
 bool get connecting;/// Why signing in there did not work (web: the dialog's alert).
 Failure? get connectFailure;/// The signed-in destination, held only for this move.
 MigrationTarget? get target;/// The person agreed the destination's vault is kept as a backup and
/// replaced.
 bool get replaceConfirmed;/// "Choose a new secret" for the moved vault.
 bool get newSecret; String get secret; String get repeat;/// Bumped by Generate, so the fields show the new secret.
 int get generation; MigrationStage get stage;/// The upload's share, 0–1.
 double get progress; Failure? get failure;
/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoveVaultStateCopyWith<MoveVaultState> get copyWith => _$MoveVaultStateCopyWithImpl<MoveVaultState>(this as MoveVaultState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoveVaultState&&(identical(other.step, step) || other.step == step)&&(identical(other.from, from) || other.from == from)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.connecting, connecting) || other.connecting == connecting)&&(identical(other.connectFailure, connectFailure) || other.connectFailure == connectFailure)&&(identical(other.target, target) || other.target == target)&&(identical(other.replaceConfirmed, replaceConfirmed) || other.replaceConfirmed == replaceConfirmed)&&(identical(other.newSecret, newSecret) || other.newSecret == newSecret)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.generation, generation) || other.generation == generation)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,step,from,destination,connecting,connectFailure,target,replaceConfirmed,newSecret,secret,repeat,generation,stage,progress,failure);

@override
String toString() {
  return 'MoveVaultState(step: $step, from: $from, destination: $destination, connecting: $connecting, connectFailure: $connectFailure, target: $target, replaceConfirmed: $replaceConfirmed, newSecret: $newSecret, secret: $secret, repeat: $repeat, generation: $generation, stage: $stage, progress: $progress, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $MoveVaultStateCopyWith<$Res>  {
  factory $MoveVaultStateCopyWith(MoveVaultState value, $Res Function(MoveVaultState) _then) = _$MoveVaultStateCopyWithImpl;
@useResult
$Res call({
 MoveVaultStep step, ProviderId? from, ProviderId? destination, bool connecting, Failure? connectFailure, MigrationTarget? target, bool replaceConfirmed, bool newSecret, String secret, String repeat, int generation, MigrationStage stage, double progress, Failure? failure
});


$FailureCopyWith<$Res>? get connectFailure;$MigrationTargetCopyWith<$Res>? get target;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$MoveVaultStateCopyWithImpl<$Res>
    implements $MoveVaultStateCopyWith<$Res> {
  _$MoveVaultStateCopyWithImpl(this._self, this._then);

  final MoveVaultState _self;
  final $Res Function(MoveVaultState) _then;

/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? from = freezed,Object? destination = freezed,Object? connecting = null,Object? connectFailure = freezed,Object? target = freezed,Object? replaceConfirmed = null,Object? newSecret = null,Object? secret = null,Object? repeat = null,Object? generation = null,Object? stage = null,Object? progress = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as MoveVaultStep,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as ProviderId?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as ProviderId?,connecting: null == connecting ? _self.connecting : connecting // ignore: cast_nullable_to_non_nullable
as bool,connectFailure: freezed == connectFailure ? _self.connectFailure : connectFailure // ignore: cast_nullable_to_non_nullable
as Failure?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MigrationTarget?,replaceConfirmed: null == replaceConfirmed ? _self.replaceConfirmed : replaceConfirmed // ignore: cast_nullable_to_non_nullable
as bool,newSecret: null == newSecret ? _self.newSecret : newSecret // ignore: cast_nullable_to_non_nullable
as bool,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as MigrationStage,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get connectFailure {
    if (_self.connectFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.connectFailure!, (value) {
    return _then(_self.copyWith(connectFailure: value));
  });
}/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MigrationTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $MigrationTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}/// Create a copy of MoveVaultState
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


/// Adds pattern-matching-related methods to [MoveVaultState].
extension MoveVaultStatePatterns on MoveVaultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoveVaultState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoveVaultState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoveVaultState value)  $default,){
final _that = this;
switch (_that) {
case _MoveVaultState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoveVaultState value)?  $default,){
final _that = this;
switch (_that) {
case _MoveVaultState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MoveVaultStep step,  ProviderId? from,  ProviderId? destination,  bool connecting,  Failure? connectFailure,  MigrationTarget? target,  bool replaceConfirmed,  bool newSecret,  String secret,  String repeat,  int generation,  MigrationStage stage,  double progress,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoveVaultState() when $default != null:
return $default(_that.step,_that.from,_that.destination,_that.connecting,_that.connectFailure,_that.target,_that.replaceConfirmed,_that.newSecret,_that.secret,_that.repeat,_that.generation,_that.stage,_that.progress,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MoveVaultStep step,  ProviderId? from,  ProviderId? destination,  bool connecting,  Failure? connectFailure,  MigrationTarget? target,  bool replaceConfirmed,  bool newSecret,  String secret,  String repeat,  int generation,  MigrationStage stage,  double progress,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _MoveVaultState():
return $default(_that.step,_that.from,_that.destination,_that.connecting,_that.connectFailure,_that.target,_that.replaceConfirmed,_that.newSecret,_that.secret,_that.repeat,_that.generation,_that.stage,_that.progress,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MoveVaultStep step,  ProviderId? from,  ProviderId? destination,  bool connecting,  Failure? connectFailure,  MigrationTarget? target,  bool replaceConfirmed,  bool newSecret,  String secret,  String repeat,  int generation,  MigrationStage stage,  double progress,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _MoveVaultState() when $default != null:
return $default(_that.step,_that.from,_that.destination,_that.connecting,_that.connectFailure,_that.target,_that.replaceConfirmed,_that.newSecret,_that.secret,_that.repeat,_that.generation,_that.stage,_that.progress,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _MoveVaultState extends MoveVaultState {
  const _MoveVaultState({this.step = MoveVaultStep.start, this.from, this.destination, this.connecting = false, this.connectFailure, this.target, this.replaceConfirmed = false, this.newSecret = false, this.secret = '', this.repeat = '', this.generation = 0, this.stage = MigrationStage.encrypting, this.progress = 0, this.failure}): super._();
  

@override@JsonKey() final  MoveVaultStep step;
/// The storage the vault leaves, and the one it goes to.
@override final  ProviderId? from;
@override final  ProviderId? destination;
/// Signing in to the destination.
@override@JsonKey() final  bool connecting;
/// Why signing in there did not work (web: the dialog's alert).
@override final  Failure? connectFailure;
/// The signed-in destination, held only for this move.
@override final  MigrationTarget? target;
/// The person agreed the destination's vault is kept as a backup and
/// replaced.
@override@JsonKey() final  bool replaceConfirmed;
/// "Choose a new secret" for the moved vault.
@override@JsonKey() final  bool newSecret;
@override@JsonKey() final  String secret;
@override@JsonKey() final  String repeat;
/// Bumped by Generate, so the fields show the new secret.
@override@JsonKey() final  int generation;
@override@JsonKey() final  MigrationStage stage;
/// The upload's share, 0–1.
@override@JsonKey() final  double progress;
@override final  Failure? failure;

/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoveVaultStateCopyWith<_MoveVaultState> get copyWith => __$MoveVaultStateCopyWithImpl<_MoveVaultState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoveVaultState&&(identical(other.step, step) || other.step == step)&&(identical(other.from, from) || other.from == from)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.connecting, connecting) || other.connecting == connecting)&&(identical(other.connectFailure, connectFailure) || other.connectFailure == connectFailure)&&(identical(other.target, target) || other.target == target)&&(identical(other.replaceConfirmed, replaceConfirmed) || other.replaceConfirmed == replaceConfirmed)&&(identical(other.newSecret, newSecret) || other.newSecret == newSecret)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.repeat, repeat) || other.repeat == repeat)&&(identical(other.generation, generation) || other.generation == generation)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,step,from,destination,connecting,connectFailure,target,replaceConfirmed,newSecret,secret,repeat,generation,stage,progress,failure);

@override
String toString() {
  return 'MoveVaultState(step: $step, from: $from, destination: $destination, connecting: $connecting, connectFailure: $connectFailure, target: $target, replaceConfirmed: $replaceConfirmed, newSecret: $newSecret, secret: $secret, repeat: $repeat, generation: $generation, stage: $stage, progress: $progress, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MoveVaultStateCopyWith<$Res> implements $MoveVaultStateCopyWith<$Res> {
  factory _$MoveVaultStateCopyWith(_MoveVaultState value, $Res Function(_MoveVaultState) _then) = __$MoveVaultStateCopyWithImpl;
@override @useResult
$Res call({
 MoveVaultStep step, ProviderId? from, ProviderId? destination, bool connecting, Failure? connectFailure, MigrationTarget? target, bool replaceConfirmed, bool newSecret, String secret, String repeat, int generation, MigrationStage stage, double progress, Failure? failure
});


@override $FailureCopyWith<$Res>? get connectFailure;@override $MigrationTargetCopyWith<$Res>? get target;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$MoveVaultStateCopyWithImpl<$Res>
    implements _$MoveVaultStateCopyWith<$Res> {
  __$MoveVaultStateCopyWithImpl(this._self, this._then);

  final _MoveVaultState _self;
  final $Res Function(_MoveVaultState) _then;

/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? from = freezed,Object? destination = freezed,Object? connecting = null,Object? connectFailure = freezed,Object? target = freezed,Object? replaceConfirmed = null,Object? newSecret = null,Object? secret = null,Object? repeat = null,Object? generation = null,Object? stage = null,Object? progress = null,Object? failure = freezed,}) {
  return _then(_MoveVaultState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as MoveVaultStep,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as ProviderId?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as ProviderId?,connecting: null == connecting ? _self.connecting : connecting // ignore: cast_nullable_to_non_nullable
as bool,connectFailure: freezed == connectFailure ? _self.connectFailure : connectFailure // ignore: cast_nullable_to_non_nullable
as Failure?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MigrationTarget?,replaceConfirmed: null == replaceConfirmed ? _self.replaceConfirmed : replaceConfirmed // ignore: cast_nullable_to_non_nullable
as bool,newSecret: null == newSecret ? _self.newSecret : newSecret // ignore: cast_nullable_to_non_nullable
as bool,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,repeat: null == repeat ? _self.repeat : repeat // ignore: cast_nullable_to_non_nullable
as String,generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as MigrationStage,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get connectFailure {
    if (_self.connectFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.connectFailure!, (value) {
    return _then(_self.copyWith(connectFailure: value));
  });
}/// Create a copy of MoveVaultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MigrationTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $MigrationTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}/// Create a copy of MoveVaultState
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
