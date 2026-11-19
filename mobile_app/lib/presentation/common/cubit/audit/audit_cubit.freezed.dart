// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuditState {

/// Findings by item id; empty until the first run of the session.
 Map<String, List<AuditResult>> get findings;/// Items in the vault with at least one finding: the Security badge.
 int get flaggedCount;/// Runs still going (a full run and an item's can overlap, as the web).
 int get running;/// The latest run's breach lookups: [lookedUp] of [toLookUp] distinct
/// passwords, and about how long the rest will take once one batch has
/// answered (board `S4-15`).
 int get lookedUp; int get toLookUp; Duration? get timeLeft;/// When a run last finished; null until one has this session.
 DateTime? get checkedAt;/// Why the last run could not finish; cleared when the next one starts.
/// The findings it would have replaced stay (web `runAndApply`).
 Failure? get failure;
/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditStateCopyWith<AuditState> get copyWith => _$AuditStateCopyWithImpl<AuditState>(this as AuditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditState&&const DeepCollectionEquality().equals(other.findings, findings)&&(identical(other.flaggedCount, flaggedCount) || other.flaggedCount == flaggedCount)&&(identical(other.running, running) || other.running == running)&&(identical(other.lookedUp, lookedUp) || other.lookedUp == lookedUp)&&(identical(other.toLookUp, toLookUp) || other.toLookUp == toLookUp)&&(identical(other.timeLeft, timeLeft) || other.timeLeft == timeLeft)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(findings),flaggedCount,running,lookedUp,toLookUp,timeLeft,checkedAt,failure);

@override
String toString() {
  return 'AuditState(findings: $findings, flaggedCount: $flaggedCount, running: $running, lookedUp: $lookedUp, toLookUp: $toLookUp, timeLeft: $timeLeft, checkedAt: $checkedAt, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuditStateCopyWith<$Res>  {
  factory $AuditStateCopyWith(AuditState value, $Res Function(AuditState) _then) = _$AuditStateCopyWithImpl;
@useResult
$Res call({
 Map<String, List<AuditResult>> findings, int flaggedCount, int running, int lookedUp, int toLookUp, Duration? timeLeft, DateTime? checkedAt, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AuditStateCopyWithImpl<$Res>
    implements $AuditStateCopyWith<$Res> {
  _$AuditStateCopyWithImpl(this._self, this._then);

  final AuditState _self;
  final $Res Function(AuditState) _then;

/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? findings = null,Object? flaggedCount = null,Object? running = null,Object? lookedUp = null,Object? toLookUp = null,Object? timeLeft = freezed,Object? checkedAt = freezed,Object? failure = freezed,}) {
  return _then(_self.copyWith(
findings: null == findings ? _self.findings : findings // ignore: cast_nullable_to_non_nullable
as Map<String, List<AuditResult>>,flaggedCount: null == flaggedCount ? _self.flaggedCount : flaggedCount // ignore: cast_nullable_to_non_nullable
as int,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as int,lookedUp: null == lookedUp ? _self.lookedUp : lookedUp // ignore: cast_nullable_to_non_nullable
as int,toLookUp: null == toLookUp ? _self.toLookUp : toLookUp // ignore: cast_nullable_to_non_nullable
as int,timeLeft: freezed == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration?,checkedAt: freezed == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of AuditState
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


/// Adds pattern-matching-related methods to [AuditState].
extension AuditStatePatterns on AuditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditState value)  $default,){
final _that = this;
switch (_that) {
case _AuditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditState value)?  $default,){
final _that = this;
switch (_that) {
case _AuditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, List<AuditResult>> findings,  int flaggedCount,  int running,  int lookedUp,  int toLookUp,  Duration? timeLeft,  DateTime? checkedAt,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditState() when $default != null:
return $default(_that.findings,_that.flaggedCount,_that.running,_that.lookedUp,_that.toLookUp,_that.timeLeft,_that.checkedAt,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, List<AuditResult>> findings,  int flaggedCount,  int running,  int lookedUp,  int toLookUp,  Duration? timeLeft,  DateTime? checkedAt,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _AuditState():
return $default(_that.findings,_that.flaggedCount,_that.running,_that.lookedUp,_that.toLookUp,_that.timeLeft,_that.checkedAt,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, List<AuditResult>> findings,  int flaggedCount,  int running,  int lookedUp,  int toLookUp,  Duration? timeLeft,  DateTime? checkedAt,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _AuditState() when $default != null:
return $default(_that.findings,_that.flaggedCount,_that.running,_that.lookedUp,_that.toLookUp,_that.timeLeft,_that.checkedAt,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AuditState extends AuditState {
  const _AuditState({final  Map<String, List<AuditResult>> findings = const <String, List<AuditResult>>{}, this.flaggedCount = 0, this.running = 0, this.lookedUp = 0, this.toLookUp = 0, this.timeLeft, this.checkedAt, this.failure}): _findings = findings,super._();
  

/// Findings by item id; empty until the first run of the session.
 final  Map<String, List<AuditResult>> _findings;
/// Findings by item id; empty until the first run of the session.
@override@JsonKey() Map<String, List<AuditResult>> get findings {
  if (_findings is EqualUnmodifiableMapView) return _findings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_findings);
}

/// Items in the vault with at least one finding: the Security badge.
@override@JsonKey() final  int flaggedCount;
/// Runs still going (a full run and an item's can overlap, as the web).
@override@JsonKey() final  int running;
/// The latest run's breach lookups: [lookedUp] of [toLookUp] distinct
/// passwords, and about how long the rest will take once one batch has
/// answered (board `S4-15`).
@override@JsonKey() final  int lookedUp;
@override@JsonKey() final  int toLookUp;
@override final  Duration? timeLeft;
/// When a run last finished; null until one has this session.
@override final  DateTime? checkedAt;
/// Why the last run could not finish; cleared when the next one starts.
/// The findings it would have replaced stay (web `runAndApply`).
@override final  Failure? failure;

/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditStateCopyWith<_AuditState> get copyWith => __$AuditStateCopyWithImpl<_AuditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditState&&const DeepCollectionEquality().equals(other._findings, _findings)&&(identical(other.flaggedCount, flaggedCount) || other.flaggedCount == flaggedCount)&&(identical(other.running, running) || other.running == running)&&(identical(other.lookedUp, lookedUp) || other.lookedUp == lookedUp)&&(identical(other.toLookUp, toLookUp) || other.toLookUp == toLookUp)&&(identical(other.timeLeft, timeLeft) || other.timeLeft == timeLeft)&&(identical(other.checkedAt, checkedAt) || other.checkedAt == checkedAt)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_findings),flaggedCount,running,lookedUp,toLookUp,timeLeft,checkedAt,failure);

@override
String toString() {
  return 'AuditState(findings: $findings, flaggedCount: $flaggedCount, running: $running, lookedUp: $lookedUp, toLookUp: $toLookUp, timeLeft: $timeLeft, checkedAt: $checkedAt, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AuditStateCopyWith<$Res> implements $AuditStateCopyWith<$Res> {
  factory _$AuditStateCopyWith(_AuditState value, $Res Function(_AuditState) _then) = __$AuditStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, List<AuditResult>> findings, int flaggedCount, int running, int lookedUp, int toLookUp, Duration? timeLeft, DateTime? checkedAt, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$AuditStateCopyWithImpl<$Res>
    implements _$AuditStateCopyWith<$Res> {
  __$AuditStateCopyWithImpl(this._self, this._then);

  final _AuditState _self;
  final $Res Function(_AuditState) _then;

/// Create a copy of AuditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? findings = null,Object? flaggedCount = null,Object? running = null,Object? lookedUp = null,Object? toLookUp = null,Object? timeLeft = freezed,Object? checkedAt = freezed,Object? failure = freezed,}) {
  return _then(_AuditState(
findings: null == findings ? _self._findings : findings // ignore: cast_nullable_to_non_nullable
as Map<String, List<AuditResult>>,flaggedCount: null == flaggedCount ? _self.flaggedCount : flaggedCount // ignore: cast_nullable_to_non_nullable
as int,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as int,lookedUp: null == lookedUp ? _self.lookedUp : lookedUp // ignore: cast_nullable_to_non_nullable
as int,toLookUp: null == toLookUp ? _self.toLookUp : toLookUp // ignore: cast_nullable_to_non_nullable
as int,timeLeft: freezed == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration?,checkedAt: freezed == checkedAt ? _self.checkedAt : checkedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of AuditState
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
