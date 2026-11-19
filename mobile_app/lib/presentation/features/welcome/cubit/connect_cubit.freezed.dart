// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectState {

 ConnectStage get stage; ProviderId? get signingIn;/// Why the last sign-in failed (the dock's red banner).
 Failure? get signInFailure;/// "Found in Google Drive · updated 2 days ago".
 String? get foundMeta;/// Set once; the page navigates and calls `destinationHandled`.
 ConnectDestination? get destination;/// Bumped each time the person closed the provider's page (a toast).
 int get cancelled;
/// Create a copy of ConnectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectStateCopyWith<ConnectState> get copyWith => _$ConnectStateCopyWithImpl<ConnectState>(this as ConnectState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.signingIn, signingIn) || other.signingIn == signingIn)&&(identical(other.signInFailure, signInFailure) || other.signInFailure == signInFailure)&&(identical(other.foundMeta, foundMeta) || other.foundMeta == foundMeta)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled));
}


@override
int get hashCode => Object.hash(runtimeType,stage,signingIn,signInFailure,foundMeta,destination,cancelled);

@override
String toString() {
  return 'ConnectState(stage: $stage, signingIn: $signingIn, signInFailure: $signInFailure, foundMeta: $foundMeta, destination: $destination, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class $ConnectStateCopyWith<$Res>  {
  factory $ConnectStateCopyWith(ConnectState value, $Res Function(ConnectState) _then) = _$ConnectStateCopyWithImpl;
@useResult
$Res call({
 ConnectStage stage, ProviderId? signingIn, Failure? signInFailure, String? foundMeta, ConnectDestination? destination, int cancelled
});


$FailureCopyWith<$Res>? get signInFailure;

}
/// @nodoc
class _$ConnectStateCopyWithImpl<$Res>
    implements $ConnectStateCopyWith<$Res> {
  _$ConnectStateCopyWithImpl(this._self, this._then);

  final ConnectState _self;
  final $Res Function(ConnectState) _then;

/// Create a copy of ConnectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? signingIn = freezed,Object? signInFailure = freezed,Object? foundMeta = freezed,Object? destination = freezed,Object? cancelled = null,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ConnectStage,signingIn: freezed == signingIn ? _self.signingIn : signingIn // ignore: cast_nullable_to_non_nullable
as ProviderId?,signInFailure: freezed == signInFailure ? _self.signInFailure : signInFailure // ignore: cast_nullable_to_non_nullable
as Failure?,foundMeta: freezed == foundMeta ? _self.foundMeta : foundMeta // ignore: cast_nullable_to_non_nullable
as String?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as ConnectDestination?,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ConnectState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get signInFailure {
    if (_self.signInFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.signInFailure!, (value) {
    return _then(_self.copyWith(signInFailure: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectState].
extension ConnectStatePatterns on ConnectState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectState value)  $default,){
final _that = this;
switch (_that) {
case _ConnectState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectState value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ConnectStage stage,  ProviderId? signingIn,  Failure? signInFailure,  String? foundMeta,  ConnectDestination? destination,  int cancelled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectState() when $default != null:
return $default(_that.stage,_that.signingIn,_that.signInFailure,_that.foundMeta,_that.destination,_that.cancelled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ConnectStage stage,  ProviderId? signingIn,  Failure? signInFailure,  String? foundMeta,  ConnectDestination? destination,  int cancelled)  $default,) {final _that = this;
switch (_that) {
case _ConnectState():
return $default(_that.stage,_that.signingIn,_that.signInFailure,_that.foundMeta,_that.destination,_that.cancelled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ConnectStage stage,  ProviderId? signingIn,  Failure? signInFailure,  String? foundMeta,  ConnectDestination? destination,  int cancelled)?  $default,) {final _that = this;
switch (_that) {
case _ConnectState() when $default != null:
return $default(_that.stage,_that.signingIn,_that.signInFailure,_that.foundMeta,_that.destination,_that.cancelled);case _:
  return null;

}
}

}

/// @nodoc


class _ConnectState implements ConnectState {
  const _ConnectState({this.stage = ConnectStage.idle, this.signingIn, this.signInFailure, this.foundMeta, this.destination, this.cancelled = 0});
  

@override@JsonKey() final  ConnectStage stage;
@override final  ProviderId? signingIn;
/// Why the last sign-in failed (the dock's red banner).
@override final  Failure? signInFailure;
/// "Found in Google Drive · updated 2 days ago".
@override final  String? foundMeta;
/// Set once; the page navigates and calls `destinationHandled`.
@override final  ConnectDestination? destination;
/// Bumped each time the person closed the provider's page (a toast).
@override@JsonKey() final  int cancelled;

/// Create a copy of ConnectState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectStateCopyWith<_ConnectState> get copyWith => __$ConnectStateCopyWithImpl<_ConnectState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.signingIn, signingIn) || other.signingIn == signingIn)&&(identical(other.signInFailure, signInFailure) || other.signInFailure == signInFailure)&&(identical(other.foundMeta, foundMeta) || other.foundMeta == foundMeta)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled));
}


@override
int get hashCode => Object.hash(runtimeType,stage,signingIn,signInFailure,foundMeta,destination,cancelled);

@override
String toString() {
  return 'ConnectState(stage: $stage, signingIn: $signingIn, signInFailure: $signInFailure, foundMeta: $foundMeta, destination: $destination, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class _$ConnectStateCopyWith<$Res> implements $ConnectStateCopyWith<$Res> {
  factory _$ConnectStateCopyWith(_ConnectState value, $Res Function(_ConnectState) _then) = __$ConnectStateCopyWithImpl;
@override @useResult
$Res call({
 ConnectStage stage, ProviderId? signingIn, Failure? signInFailure, String? foundMeta, ConnectDestination? destination, int cancelled
});


@override $FailureCopyWith<$Res>? get signInFailure;

}
/// @nodoc
class __$ConnectStateCopyWithImpl<$Res>
    implements _$ConnectStateCopyWith<$Res> {
  __$ConnectStateCopyWithImpl(this._self, this._then);

  final _ConnectState _self;
  final $Res Function(_ConnectState) _then;

/// Create a copy of ConnectState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? signingIn = freezed,Object? signInFailure = freezed,Object? foundMeta = freezed,Object? destination = freezed,Object? cancelled = null,}) {
  return _then(_ConnectState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ConnectStage,signingIn: freezed == signingIn ? _self.signingIn : signingIn // ignore: cast_nullable_to_non_nullable
as ProviderId?,signInFailure: freezed == signInFailure ? _self.signInFailure : signInFailure // ignore: cast_nullable_to_non_nullable
as Failure?,foundMeta: freezed == foundMeta ? _self.foundMeta : foundMeta // ignore: cast_nullable_to_non_nullable
as String?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as ConnectDestination?,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ConnectState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get signInFailure {
    if (_self.signInFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.signInFailure!, (value) {
    return _then(_self.copyWith(signInFailure: value));
  });
}
}

// dart format on
