// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionState {

 CubitStatus get status; SessionPhase get phase;/// The session's account; while signed out after an expiry, the one to
/// greet ("Welcome back", board `U2-Connect`).
 ProviderAccount? get account;/// Signed out because the session expired, not by choice.
 bool get expired;/// The launch restore has finished (the splash can move on).
 bool get restored;/// Whether this account has a vault file; null before the check.
 bool? get hasVault;/// The file found by the check ("updated 2 days ago").
 VaultFileInfo? get vaultFile;/// Why the vault last locked; null when it was never unlocked.
 LockReason? get lockReason;/// Which provider's button is busy signing in.
 ProviderId? get signingIn;/// The last action's failure, for screens that react to its kind
/// (cancelled sign-in → toast, wrong secret → shake).
 Failure? get failure;/// Signed out by archiving or moving the vault: what Welcome shows over
/// itself.
 SessionFarewell? get farewell;
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStateCopyWith<SessionState> get copyWith => _$SessionStateCopyWithImpl<SessionState>(this as SessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.account, account) || other.account == account)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.restored, restored) || other.restored == restored)&&(identical(other.hasVault, hasVault) || other.hasVault == hasVault)&&(identical(other.vaultFile, vaultFile) || other.vaultFile == vaultFile)&&(identical(other.lockReason, lockReason) || other.lockReason == lockReason)&&(identical(other.signingIn, signingIn) || other.signingIn == signingIn)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.farewell, farewell) || other.farewell == farewell));
}


@override
int get hashCode => Object.hash(runtimeType,status,phase,account,expired,restored,hasVault,vaultFile,lockReason,signingIn,failure,farewell);

@override
String toString() {
  return 'SessionState(status: $status, phase: $phase, account: $account, expired: $expired, restored: $restored, hasVault: $hasVault, vaultFile: $vaultFile, lockReason: $lockReason, signingIn: $signingIn, failure: $failure, farewell: $farewell)';
}


}

/// @nodoc
abstract mixin class $SessionStateCopyWith<$Res>  {
  factory $SessionStateCopyWith(SessionState value, $Res Function(SessionState) _then) = _$SessionStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, SessionPhase phase, ProviderAccount? account, bool expired, bool restored, bool? hasVault, VaultFileInfo? vaultFile, LockReason? lockReason, ProviderId? signingIn, Failure? failure, SessionFarewell? farewell
});


$ProviderAccountCopyWith<$Res>? get account;$VaultFileInfoCopyWith<$Res>? get vaultFile;$FailureCopyWith<$Res>? get failure;$SessionFarewellCopyWith<$Res>? get farewell;

}
/// @nodoc
class _$SessionStateCopyWithImpl<$Res>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._self, this._then);

  final SessionState _self;
  final $Res Function(SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? phase = null,Object? account = freezed,Object? expired = null,Object? restored = null,Object? hasVault = freezed,Object? vaultFile = freezed,Object? lockReason = freezed,Object? signingIn = freezed,Object? failure = freezed,Object? farewell = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SessionPhase,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as ProviderAccount?,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,restored: null == restored ? _self.restored : restored // ignore: cast_nullable_to_non_nullable
as bool,hasVault: freezed == hasVault ? _self.hasVault : hasVault // ignore: cast_nullable_to_non_nullable
as bool?,vaultFile: freezed == vaultFile ? _self.vaultFile : vaultFile // ignore: cast_nullable_to_non_nullable
as VaultFileInfo?,lockReason: freezed == lockReason ? _self.lockReason : lockReason // ignore: cast_nullable_to_non_nullable
as LockReason?,signingIn: freezed == signingIn ? _self.signingIn : signingIn // ignore: cast_nullable_to_non_nullable
as ProviderId?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,farewell: freezed == farewell ? _self.farewell : farewell // ignore: cast_nullable_to_non_nullable
as SessionFarewell?,
  ));
}
/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $ProviderAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultFileInfoCopyWith<$Res>? get vaultFile {
    if (_self.vaultFile == null) {
    return null;
  }

  return $VaultFileInfoCopyWith<$Res>(_self.vaultFile!, (value) {
    return _then(_self.copyWith(vaultFile: value));
  });
}/// Create a copy of SessionState
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
}/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionFarewellCopyWith<$Res>? get farewell {
    if (_self.farewell == null) {
    return null;
  }

  return $SessionFarewellCopyWith<$Res>(_self.farewell!, (value) {
    return _then(_self.copyWith(farewell: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionState value)  $default,){
final _that = this;
switch (_that) {
case _SessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionState value)?  $default,){
final _that = this;
switch (_that) {
case _SessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  SessionPhase phase,  ProviderAccount? account,  bool expired,  bool restored,  bool? hasVault,  VaultFileInfo? vaultFile,  LockReason? lockReason,  ProviderId? signingIn,  Failure? failure,  SessionFarewell? farewell)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.status,_that.phase,_that.account,_that.expired,_that.restored,_that.hasVault,_that.vaultFile,_that.lockReason,_that.signingIn,_that.failure,_that.farewell);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  SessionPhase phase,  ProviderAccount? account,  bool expired,  bool restored,  bool? hasVault,  VaultFileInfo? vaultFile,  LockReason? lockReason,  ProviderId? signingIn,  Failure? failure,  SessionFarewell? farewell)  $default,) {final _that = this;
switch (_that) {
case _SessionState():
return $default(_that.status,_that.phase,_that.account,_that.expired,_that.restored,_that.hasVault,_that.vaultFile,_that.lockReason,_that.signingIn,_that.failure,_that.farewell);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  SessionPhase phase,  ProviderAccount? account,  bool expired,  bool restored,  bool? hasVault,  VaultFileInfo? vaultFile,  LockReason? lockReason,  ProviderId? signingIn,  Failure? failure,  SessionFarewell? farewell)?  $default,) {final _that = this;
switch (_that) {
case _SessionState() when $default != null:
return $default(_that.status,_that.phase,_that.account,_that.expired,_that.restored,_that.hasVault,_that.vaultFile,_that.lockReason,_that.signingIn,_that.failure,_that.farewell);case _:
  return null;

}
}

}

/// @nodoc


class _SessionState extends SessionState {
  const _SessionState({this.status = const CubitStatus(), this.phase = SessionPhase.signedOut, this.account, this.expired = false, this.restored = false, this.hasVault, this.vaultFile, this.lockReason, this.signingIn, this.failure, this.farewell}): super._();
  

@override@JsonKey() final  CubitStatus status;
@override@JsonKey() final  SessionPhase phase;
/// The session's account; while signed out after an expiry, the one to
/// greet ("Welcome back", board `U2-Connect`).
@override final  ProviderAccount? account;
/// Signed out because the session expired, not by choice.
@override@JsonKey() final  bool expired;
/// The launch restore has finished (the splash can move on).
@override@JsonKey() final  bool restored;
/// Whether this account has a vault file; null before the check.
@override final  bool? hasVault;
/// The file found by the check ("updated 2 days ago").
@override final  VaultFileInfo? vaultFile;
/// Why the vault last locked; null when it was never unlocked.
@override final  LockReason? lockReason;
/// Which provider's button is busy signing in.
@override final  ProviderId? signingIn;
/// The last action's failure, for screens that react to its kind
/// (cancelled sign-in → toast, wrong secret → shake).
@override final  Failure? failure;
/// Signed out by archiving or moving the vault: what Welcome shows over
/// itself.
@override final  SessionFarewell? farewell;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionStateCopyWith<_SessionState> get copyWith => __$SessionStateCopyWithImpl<_SessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionState&&(identical(other.status, status) || other.status == status)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.account, account) || other.account == account)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.restored, restored) || other.restored == restored)&&(identical(other.hasVault, hasVault) || other.hasVault == hasVault)&&(identical(other.vaultFile, vaultFile) || other.vaultFile == vaultFile)&&(identical(other.lockReason, lockReason) || other.lockReason == lockReason)&&(identical(other.signingIn, signingIn) || other.signingIn == signingIn)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.farewell, farewell) || other.farewell == farewell));
}


@override
int get hashCode => Object.hash(runtimeType,status,phase,account,expired,restored,hasVault,vaultFile,lockReason,signingIn,failure,farewell);

@override
String toString() {
  return 'SessionState(status: $status, phase: $phase, account: $account, expired: $expired, restored: $restored, hasVault: $hasVault, vaultFile: $vaultFile, lockReason: $lockReason, signingIn: $signingIn, failure: $failure, farewell: $farewell)';
}


}

/// @nodoc
abstract mixin class _$SessionStateCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory _$SessionStateCopyWith(_SessionState value, $Res Function(_SessionState) _then) = __$SessionStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, SessionPhase phase, ProviderAccount? account, bool expired, bool restored, bool? hasVault, VaultFileInfo? vaultFile, LockReason? lockReason, ProviderId? signingIn, Failure? failure, SessionFarewell? farewell
});


@override $ProviderAccountCopyWith<$Res>? get account;@override $VaultFileInfoCopyWith<$Res>? get vaultFile;@override $FailureCopyWith<$Res>? get failure;@override $SessionFarewellCopyWith<$Res>? get farewell;

}
/// @nodoc
class __$SessionStateCopyWithImpl<$Res>
    implements _$SessionStateCopyWith<$Res> {
  __$SessionStateCopyWithImpl(this._self, this._then);

  final _SessionState _self;
  final $Res Function(_SessionState) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? phase = null,Object? account = freezed,Object? expired = null,Object? restored = null,Object? hasVault = freezed,Object? vaultFile = freezed,Object? lockReason = freezed,Object? signingIn = freezed,Object? failure = freezed,Object? farewell = freezed,}) {
  return _then(_SessionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as SessionPhase,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as ProviderAccount?,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,restored: null == restored ? _self.restored : restored // ignore: cast_nullable_to_non_nullable
as bool,hasVault: freezed == hasVault ? _self.hasVault : hasVault // ignore: cast_nullable_to_non_nullable
as bool?,vaultFile: freezed == vaultFile ? _self.vaultFile : vaultFile // ignore: cast_nullable_to_non_nullable
as VaultFileInfo?,lockReason: freezed == lockReason ? _self.lockReason : lockReason // ignore: cast_nullable_to_non_nullable
as LockReason?,signingIn: freezed == signingIn ? _self.signingIn : signingIn // ignore: cast_nullable_to_non_nullable
as ProviderId?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,farewell: freezed == farewell ? _self.farewell : farewell // ignore: cast_nullable_to_non_nullable
as SessionFarewell?,
  ));
}

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $ProviderAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultFileInfoCopyWith<$Res>? get vaultFile {
    if (_self.vaultFile == null) {
    return null;
  }

  return $VaultFileInfoCopyWith<$Res>(_self.vaultFile!, (value) {
    return _then(_self.copyWith(vaultFile: value));
  });
}/// Create a copy of SessionState
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
}/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionFarewellCopyWith<$Res>? get farewell {
    if (_self.farewell == null) {
    return null;
  }

  return $SessionFarewellCopyWith<$Res>(_self.farewell!, (value) {
    return _then(_self.copyWith(farewell: value));
  });
}
}

/// @nodoc
mixin _$SessionFarewell {

/// The file's new name; null when there was no file to rename.
 String? get renamedFile;
/// Create a copy of SessionFarewell
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionFarewellCopyWith<SessionFarewell> get copyWith => _$SessionFarewellCopyWithImpl<SessionFarewell>(this as SessionFarewell, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionFarewell&&(identical(other.renamedFile, renamedFile) || other.renamedFile == renamedFile));
}


@override
int get hashCode => Object.hash(runtimeType,renamedFile);

@override
String toString() {
  return 'SessionFarewell(renamedFile: $renamedFile)';
}


}

/// @nodoc
abstract mixin class $SessionFarewellCopyWith<$Res>  {
  factory $SessionFarewellCopyWith(SessionFarewell value, $Res Function(SessionFarewell) _then) = _$SessionFarewellCopyWithImpl;
@useResult
$Res call({
 String? renamedFile
});




}
/// @nodoc
class _$SessionFarewellCopyWithImpl<$Res>
    implements $SessionFarewellCopyWith<$Res> {
  _$SessionFarewellCopyWithImpl(this._self, this._then);

  final SessionFarewell _self;
  final $Res Function(SessionFarewell) _then;

/// Create a copy of SessionFarewell
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? renamedFile = freezed,}) {
  return _then(_self.copyWith(
renamedFile: freezed == renamedFile ? _self.renamedFile : renamedFile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionFarewell].
extension SessionFarewellPatterns on SessionFarewell {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ArchivedFarewell value)?  archived,TResult Function( MovedFarewell value)?  moved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ArchivedFarewell() when archived != null:
return archived(_that);case MovedFarewell() when moved != null:
return moved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ArchivedFarewell value)  archived,required TResult Function( MovedFarewell value)  moved,}){
final _that = this;
switch (_that) {
case ArchivedFarewell():
return archived(_that);case MovedFarewell():
return moved(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ArchivedFarewell value)?  archived,TResult? Function( MovedFarewell value)?  moved,}){
final _that = this;
switch (_that) {
case ArchivedFarewell() when archived != null:
return archived(_that);case MovedFarewell() when moved != null:
return moved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ProviderId provider,  String? renamedFile)?  archived,TResult Function( ProviderId from,  ProviderId to,  String? renamedFile)?  moved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ArchivedFarewell() when archived != null:
return archived(_that.provider,_that.renamedFile);case MovedFarewell() when moved != null:
return moved(_that.from,_that.to,_that.renamedFile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ProviderId provider,  String? renamedFile)  archived,required TResult Function( ProviderId from,  ProviderId to,  String? renamedFile)  moved,}) {final _that = this;
switch (_that) {
case ArchivedFarewell():
return archived(_that.provider,_that.renamedFile);case MovedFarewell():
return moved(_that.from,_that.to,_that.renamedFile);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ProviderId provider,  String? renamedFile)?  archived,TResult? Function( ProviderId from,  ProviderId to,  String? renamedFile)?  moved,}) {final _that = this;
switch (_that) {
case ArchivedFarewell() when archived != null:
return archived(_that.provider,_that.renamedFile);case MovedFarewell() when moved != null:
return moved(_that.from,_that.to,_that.renamedFile);case _:
  return null;

}
}

}

/// @nodoc


class ArchivedFarewell implements SessionFarewell {
  const ArchivedFarewell({required this.provider, this.renamedFile});
  

 final  ProviderId provider;
/// The file's new name; null when there was no file to rename.
@override final  String? renamedFile;

/// Create a copy of SessionFarewell
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchivedFarewellCopyWith<ArchivedFarewell> get copyWith => _$ArchivedFarewellCopyWithImpl<ArchivedFarewell>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchivedFarewell&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.renamedFile, renamedFile) || other.renamedFile == renamedFile));
}


@override
int get hashCode => Object.hash(runtimeType,provider,renamedFile);

@override
String toString() {
  return 'SessionFarewell.archived(provider: $provider, renamedFile: $renamedFile)';
}


}

/// @nodoc
abstract mixin class $ArchivedFarewellCopyWith<$Res> implements $SessionFarewellCopyWith<$Res> {
  factory $ArchivedFarewellCopyWith(ArchivedFarewell value, $Res Function(ArchivedFarewell) _then) = _$ArchivedFarewellCopyWithImpl;
@override @useResult
$Res call({
 ProviderId provider, String? renamedFile
});




}
/// @nodoc
class _$ArchivedFarewellCopyWithImpl<$Res>
    implements $ArchivedFarewellCopyWith<$Res> {
  _$ArchivedFarewellCopyWithImpl(this._self, this._then);

  final ArchivedFarewell _self;
  final $Res Function(ArchivedFarewell) _then;

/// Create a copy of SessionFarewell
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? renamedFile = freezed,}) {
  return _then(ArchivedFarewell(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,renamedFile: freezed == renamedFile ? _self.renamedFile : renamedFile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class MovedFarewell implements SessionFarewell {
  const MovedFarewell({required this.from, required this.to, this.renamedFile});
  

 final  ProviderId from;
 final  ProviderId to;
@override final  String? renamedFile;

/// Create a copy of SessionFarewell
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovedFarewellCopyWith<MovedFarewell> get copyWith => _$MovedFarewellCopyWithImpl<MovedFarewell>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovedFarewell&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.renamedFile, renamedFile) || other.renamedFile == renamedFile));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,renamedFile);

@override
String toString() {
  return 'SessionFarewell.moved(from: $from, to: $to, renamedFile: $renamedFile)';
}


}

/// @nodoc
abstract mixin class $MovedFarewellCopyWith<$Res> implements $SessionFarewellCopyWith<$Res> {
  factory $MovedFarewellCopyWith(MovedFarewell value, $Res Function(MovedFarewell) _then) = _$MovedFarewellCopyWithImpl;
@override @useResult
$Res call({
 ProviderId from, ProviderId to, String? renamedFile
});




}
/// @nodoc
class _$MovedFarewellCopyWithImpl<$Res>
    implements $MovedFarewellCopyWith<$Res> {
  _$MovedFarewellCopyWithImpl(this._self, this._then);

  final MovedFarewell _self;
  final $Res Function(MovedFarewell) _then;

/// Create a copy of SessionFarewell
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? renamedFile = freezed,}) {
  return _then(MovedFarewell(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as ProviderId,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as ProviderId,renamedFile: freezed == renamedFile ? _self.renamedFile : renamedFile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
