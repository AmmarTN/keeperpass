// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncState {

/// Reconnect and "Load the latest" report here.
 CubitStatus get status; SyncPhase get phase;/// The current save was started by Retry ("Trying again…").
 bool get retrying;/// The upload, `0` to `1`; meaningful while [SyncPhase.uploading].
 double get progress;/// Committed changes not saved yet ("1 change not saved").
 int get pendingChanges;/// Why the last save did not go through.
 Failure? get failure;/// When the last save went through.
 DateTime? get savedAt;/// A Dropbox conflict: the stored file, newer than the one this phone
/// opened ("In Dropbox, saved 9:37 AM · newer").
 VaultFileInfo? get newerVersion;/// When this phone's version was loaded or last saved ("On this phone,
/// loaded 9:12 AM").
 DateTime? get openedAt;/// Bumped each time an edit is refused for a newer version: the app
/// asks "Your Vault Changed" (board `Sync-states`).
 int get conflictPrompts;
/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncStateCopyWith<SyncState> get copyWith => _$SyncStateCopyWithImpl<SyncState>(this as SyncState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncState&&(identical(other.status, status) || other.status == status)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.retrying, retrying) || other.retrying == retrying)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.pendingChanges, pendingChanges) || other.pendingChanges == pendingChanges)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.newerVersion, newerVersion) || other.newerVersion == newerVersion)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.conflictPrompts, conflictPrompts) || other.conflictPrompts == conflictPrompts));
}


@override
int get hashCode => Object.hash(runtimeType,status,phase,retrying,progress,pendingChanges,failure,savedAt,newerVersion,openedAt,conflictPrompts);

@override
String toString() {
  return 'SyncState(status: $status, phase: $phase, retrying: $retrying, progress: $progress, pendingChanges: $pendingChanges, failure: $failure, savedAt: $savedAt, newerVersion: $newerVersion, openedAt: $openedAt, conflictPrompts: $conflictPrompts)';
}


}

/// @nodoc
abstract mixin class $SyncStateCopyWith<$Res>  {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) _then) = _$SyncStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, SyncPhase phase, bool retrying, double progress, int pendingChanges, Failure? failure, DateTime? savedAt, VaultFileInfo? newerVersion, DateTime? openedAt, int conflictPrompts
});


$FailureCopyWith<$Res>? get failure;$VaultFileInfoCopyWith<$Res>? get newerVersion;

}
/// @nodoc
class _$SyncStateCopyWithImpl<$Res>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._self, this._then);

  final SyncState _self;
  final $Res Function(SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? phase = null,Object? retrying = null,Object? progress = null,Object? pendingChanges = null,Object? failure = freezed,Object? savedAt = freezed,Object? newerVersion = freezed,Object? openedAt = freezed,Object? conflictPrompts = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SyncPhase,retrying: null == retrying ? _self.retrying : retrying // ignore: cast_nullable_to_non_nullable
as bool,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,pendingChanges: null == pendingChanges ? _self.pendingChanges : pendingChanges // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,newerVersion: freezed == newerVersion ? _self.newerVersion : newerVersion // ignore: cast_nullable_to_non_nullable
as VaultFileInfo?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,conflictPrompts: null == conflictPrompts ? _self.conflictPrompts : conflictPrompts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SyncState
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
}/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultFileInfoCopyWith<$Res>? get newerVersion {
    if (_self.newerVersion == null) {
    return null;
  }

  return $VaultFileInfoCopyWith<$Res>(_self.newerVersion!, (value) {
    return _then(_self.copyWith(newerVersion: value));
  });
}
}


/// Adds pattern-matching-related methods to [SyncState].
extension SyncStatePatterns on SyncState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncState value)  $default,){
final _that = this;
switch (_that) {
case _SyncState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncState value)?  $default,){
final _that = this;
switch (_that) {
case _SyncState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  SyncPhase phase,  bool retrying,  double progress,  int pendingChanges,  Failure? failure,  DateTime? savedAt,  VaultFileInfo? newerVersion,  DateTime? openedAt,  int conflictPrompts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncState() when $default != null:
return $default(_that.status,_that.phase,_that.retrying,_that.progress,_that.pendingChanges,_that.failure,_that.savedAt,_that.newerVersion,_that.openedAt,_that.conflictPrompts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  SyncPhase phase,  bool retrying,  double progress,  int pendingChanges,  Failure? failure,  DateTime? savedAt,  VaultFileInfo? newerVersion,  DateTime? openedAt,  int conflictPrompts)  $default,) {final _that = this;
switch (_that) {
case _SyncState():
return $default(_that.status,_that.phase,_that.retrying,_that.progress,_that.pendingChanges,_that.failure,_that.savedAt,_that.newerVersion,_that.openedAt,_that.conflictPrompts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  SyncPhase phase,  bool retrying,  double progress,  int pendingChanges,  Failure? failure,  DateTime? savedAt,  VaultFileInfo? newerVersion,  DateTime? openedAt,  int conflictPrompts)?  $default,) {final _that = this;
switch (_that) {
case _SyncState() when $default != null:
return $default(_that.status,_that.phase,_that.retrying,_that.progress,_that.pendingChanges,_that.failure,_that.savedAt,_that.newerVersion,_that.openedAt,_that.conflictPrompts);case _:
  return null;

}
}

}

/// @nodoc


class _SyncState extends SyncState {
  const _SyncState({this.status = const CubitStatus(), this.phase = SyncPhase.idle, this.retrying = false, this.progress = 0.0, this.pendingChanges = 0, this.failure, this.savedAt, this.newerVersion, this.openedAt, this.conflictPrompts = 0}): super._();
  

/// Reconnect and "Load the latest" report here.
@override@JsonKey() final  CubitStatus status;
@override@JsonKey() final  SyncPhase phase;
/// The current save was started by Retry ("Trying again…").
@override@JsonKey() final  bool retrying;
/// The upload, `0` to `1`; meaningful while [SyncPhase.uploading].
@override@JsonKey() final  double progress;
/// Committed changes not saved yet ("1 change not saved").
@override@JsonKey() final  int pendingChanges;
/// Why the last save did not go through.
@override final  Failure? failure;
/// When the last save went through.
@override final  DateTime? savedAt;
/// A Dropbox conflict: the stored file, newer than the one this phone
/// opened ("In Dropbox, saved 9:37 AM · newer").
@override final  VaultFileInfo? newerVersion;
/// When this phone's version was loaded or last saved ("On this phone,
/// loaded 9:12 AM").
@override final  DateTime? openedAt;
/// Bumped each time an edit is refused for a newer version: the app
/// asks "Your Vault Changed" (board `Sync-states`).
@override@JsonKey() final  int conflictPrompts;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncStateCopyWith<_SyncState> get copyWith => __$SyncStateCopyWithImpl<_SyncState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncState&&(identical(other.status, status) || other.status == status)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.retrying, retrying) || other.retrying == retrying)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.pendingChanges, pendingChanges) || other.pendingChanges == pendingChanges)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.newerVersion, newerVersion) || other.newerVersion == newerVersion)&&(identical(other.openedAt, openedAt) || other.openedAt == openedAt)&&(identical(other.conflictPrompts, conflictPrompts) || other.conflictPrompts == conflictPrompts));
}


@override
int get hashCode => Object.hash(runtimeType,status,phase,retrying,progress,pendingChanges,failure,savedAt,newerVersion,openedAt,conflictPrompts);

@override
String toString() {
  return 'SyncState(status: $status, phase: $phase, retrying: $retrying, progress: $progress, pendingChanges: $pendingChanges, failure: $failure, savedAt: $savedAt, newerVersion: $newerVersion, openedAt: $openedAt, conflictPrompts: $conflictPrompts)';
}


}

/// @nodoc
abstract mixin class _$SyncStateCopyWith<$Res> implements $SyncStateCopyWith<$Res> {
  factory _$SyncStateCopyWith(_SyncState value, $Res Function(_SyncState) _then) = __$SyncStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, SyncPhase phase, bool retrying, double progress, int pendingChanges, Failure? failure, DateTime? savedAt, VaultFileInfo? newerVersion, DateTime? openedAt, int conflictPrompts
});


@override $FailureCopyWith<$Res>? get failure;@override $VaultFileInfoCopyWith<$Res>? get newerVersion;

}
/// @nodoc
class __$SyncStateCopyWithImpl<$Res>
    implements _$SyncStateCopyWith<$Res> {
  __$SyncStateCopyWithImpl(this._self, this._then);

  final _SyncState _self;
  final $Res Function(_SyncState) _then;

/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? phase = null,Object? retrying = null,Object? progress = null,Object? pendingChanges = null,Object? failure = freezed,Object? savedAt = freezed,Object? newerVersion = freezed,Object? openedAt = freezed,Object? conflictPrompts = null,}) {
  return _then(_SyncState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SyncPhase,retrying: null == retrying ? _self.retrying : retrying // ignore: cast_nullable_to_non_nullable
as bool,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,pendingChanges: null == pendingChanges ? _self.pendingChanges : pendingChanges // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,newerVersion: freezed == newerVersion ? _self.newerVersion : newerVersion // ignore: cast_nullable_to_non_nullable
as VaultFileInfo?,openedAt: freezed == openedAt ? _self.openedAt : openedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,conflictPrompts: null == conflictPrompts ? _self.conflictPrompts : conflictPrompts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SyncState
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
}/// Create a copy of SyncState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultFileInfoCopyWith<$Res>? get newerVersion {
    if (_self.newerVersion == null) {
    return null;
  }

  return $VaultFileInfoCopyWith<$Res>(_self.newerVersion!, (value) {
    return _then(_self.copyWith(newerVersion: value));
  });
}
}

// dart format on
