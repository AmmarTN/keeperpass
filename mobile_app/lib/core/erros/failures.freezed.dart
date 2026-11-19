// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _NetworkFailure value)?  networkFailure,TResult Function( PlatformFailure value)?  platformFailure,TResult Function( FormatExceptionFailure value)?  formatExceptionFailure,TResult Function( UnableToProcess value)?  unableToProcess,TResult Function( UnexpectedError value)?  unexpectedError,TResult Function( AccessTokenFailure value)?  accessTokenFailure,TResult Function( CacheReadFailure value)?  cacheReadFailure,TResult Function( CacheWriteFailure value)?  cacheWriteFailure,TResult Function( StorageAuthExpired value)?  storageAuthExpired,TResult Function( VaultConflict value)?  vaultConflict,TResult Function( StorageFailure value)?  storageError,TResult Function( DriveAccessNotGranted value)?  driveAccessNotGranted,TResult Function( SignInCancelled value)?  signInCancelled,TResult Function( SignInFailed value)?  signInFailed,TResult Function( ProfileFailed value)?  profileFailed,TResult Function( AccountMismatch value)?  accountMismatch,TResult Function( WrongSecret value)?  wrongSecret,TResult Function( UnsupportedVault value)?  unsupportedVault,TResult Function( CorruptVault value)?  corruptVault,TResult Function( VaultNotFound value)?  vaultNotFound,TResult Function( VaultLocked value)?  vaultLocked,TResult Function( MigrationFailure value)?  migration,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkFailure() when networkFailure != null:
return networkFailure(_that);case PlatformFailure() when platformFailure != null:
return platformFailure(_that);case FormatExceptionFailure() when formatExceptionFailure != null:
return formatExceptionFailure(_that);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case AccessTokenFailure() when accessTokenFailure != null:
return accessTokenFailure(_that);case CacheReadFailure() when cacheReadFailure != null:
return cacheReadFailure(_that);case CacheWriteFailure() when cacheWriteFailure != null:
return cacheWriteFailure(_that);case StorageAuthExpired() when storageAuthExpired != null:
return storageAuthExpired(_that);case VaultConflict() when vaultConflict != null:
return vaultConflict(_that);case StorageFailure() when storageError != null:
return storageError(_that);case DriveAccessNotGranted() when driveAccessNotGranted != null:
return driveAccessNotGranted(_that);case SignInCancelled() when signInCancelled != null:
return signInCancelled(_that);case SignInFailed() when signInFailed != null:
return signInFailed(_that);case ProfileFailed() when profileFailed != null:
return profileFailed(_that);case AccountMismatch() when accountMismatch != null:
return accountMismatch(_that);case WrongSecret() when wrongSecret != null:
return wrongSecret(_that);case UnsupportedVault() when unsupportedVault != null:
return unsupportedVault(_that);case CorruptVault() when corruptVault != null:
return corruptVault(_that);case VaultNotFound() when vaultNotFound != null:
return vaultNotFound(_that);case VaultLocked() when vaultLocked != null:
return vaultLocked(_that);case MigrationFailure() when migration != null:
return migration(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _NetworkFailure value)  networkFailure,required TResult Function( PlatformFailure value)  platformFailure,required TResult Function( FormatExceptionFailure value)  formatExceptionFailure,required TResult Function( UnableToProcess value)  unableToProcess,required TResult Function( UnexpectedError value)  unexpectedError,required TResult Function( AccessTokenFailure value)  accessTokenFailure,required TResult Function( CacheReadFailure value)  cacheReadFailure,required TResult Function( CacheWriteFailure value)  cacheWriteFailure,required TResult Function( StorageAuthExpired value)  storageAuthExpired,required TResult Function( VaultConflict value)  vaultConflict,required TResult Function( StorageFailure value)  storageError,required TResult Function( DriveAccessNotGranted value)  driveAccessNotGranted,required TResult Function( SignInCancelled value)  signInCancelled,required TResult Function( SignInFailed value)  signInFailed,required TResult Function( ProfileFailed value)  profileFailed,required TResult Function( AccountMismatch value)  accountMismatch,required TResult Function( WrongSecret value)  wrongSecret,required TResult Function( UnsupportedVault value)  unsupportedVault,required TResult Function( CorruptVault value)  corruptVault,required TResult Function( VaultNotFound value)  vaultNotFound,required TResult Function( VaultLocked value)  vaultLocked,required TResult Function( MigrationFailure value)  migration,}){
final _that = this;
switch (_that) {
case _NetworkFailure():
return networkFailure(_that);case PlatformFailure():
return platformFailure(_that);case FormatExceptionFailure():
return formatExceptionFailure(_that);case UnableToProcess():
return unableToProcess(_that);case UnexpectedError():
return unexpectedError(_that);case AccessTokenFailure():
return accessTokenFailure(_that);case CacheReadFailure():
return cacheReadFailure(_that);case CacheWriteFailure():
return cacheWriteFailure(_that);case StorageAuthExpired():
return storageAuthExpired(_that);case VaultConflict():
return vaultConflict(_that);case StorageFailure():
return storageError(_that);case DriveAccessNotGranted():
return driveAccessNotGranted(_that);case SignInCancelled():
return signInCancelled(_that);case SignInFailed():
return signInFailed(_that);case ProfileFailed():
return profileFailed(_that);case AccountMismatch():
return accountMismatch(_that);case WrongSecret():
return wrongSecret(_that);case UnsupportedVault():
return unsupportedVault(_that);case CorruptVault():
return corruptVault(_that);case VaultNotFound():
return vaultNotFound(_that);case VaultLocked():
return vaultLocked(_that);case MigrationFailure():
return migration(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _NetworkFailure value)?  networkFailure,TResult? Function( PlatformFailure value)?  platformFailure,TResult? Function( FormatExceptionFailure value)?  formatExceptionFailure,TResult? Function( UnableToProcess value)?  unableToProcess,TResult? Function( UnexpectedError value)?  unexpectedError,TResult? Function( AccessTokenFailure value)?  accessTokenFailure,TResult? Function( CacheReadFailure value)?  cacheReadFailure,TResult? Function( CacheWriteFailure value)?  cacheWriteFailure,TResult? Function( StorageAuthExpired value)?  storageAuthExpired,TResult? Function( VaultConflict value)?  vaultConflict,TResult? Function( StorageFailure value)?  storageError,TResult? Function( DriveAccessNotGranted value)?  driveAccessNotGranted,TResult? Function( SignInCancelled value)?  signInCancelled,TResult? Function( SignInFailed value)?  signInFailed,TResult? Function( ProfileFailed value)?  profileFailed,TResult? Function( AccountMismatch value)?  accountMismatch,TResult? Function( WrongSecret value)?  wrongSecret,TResult? Function( UnsupportedVault value)?  unsupportedVault,TResult? Function( CorruptVault value)?  corruptVault,TResult? Function( VaultNotFound value)?  vaultNotFound,TResult? Function( VaultLocked value)?  vaultLocked,TResult? Function( MigrationFailure value)?  migration,}){
final _that = this;
switch (_that) {
case _NetworkFailure() when networkFailure != null:
return networkFailure(_that);case PlatformFailure() when platformFailure != null:
return platformFailure(_that);case FormatExceptionFailure() when formatExceptionFailure != null:
return formatExceptionFailure(_that);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case AccessTokenFailure() when accessTokenFailure != null:
return accessTokenFailure(_that);case CacheReadFailure() when cacheReadFailure != null:
return cacheReadFailure(_that);case CacheWriteFailure() when cacheWriteFailure != null:
return cacheWriteFailure(_that);case StorageAuthExpired() when storageAuthExpired != null:
return storageAuthExpired(_that);case VaultConflict() when vaultConflict != null:
return vaultConflict(_that);case StorageFailure() when storageError != null:
return storageError(_that);case DriveAccessNotGranted() when driveAccessNotGranted != null:
return driveAccessNotGranted(_that);case SignInCancelled() when signInCancelled != null:
return signInCancelled(_that);case SignInFailed() when signInFailed != null:
return signInFailed(_that);case ProfileFailed() when profileFailed != null:
return profileFailed(_that);case AccountMismatch() when accountMismatch != null:
return accountMismatch(_that);case WrongSecret() when wrongSecret != null:
return wrongSecret(_that);case UnsupportedVault() when unsupportedVault != null:
return unsupportedVault(_that);case CorruptVault() when corruptVault != null:
return corruptVault(_that);case VaultNotFound() when vaultNotFound != null:
return vaultNotFound(_that);case VaultLocked() when vaultLocked != null:
return vaultLocked(_that);case MigrationFailure() when migration != null:
return migration(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( NetworkFailure f)?  networkFailure,TResult Function( String? message)?  platformFailure,TResult Function()?  formatExceptionFailure,TResult Function( dynamic error)?  unableToProcess,TResult Function( dynamic data)?  unexpectedError,TResult Function()?  accessTokenFailure,TResult Function()?  cacheReadFailure,TResult Function()?  cacheWriteFailure,TResult Function( ProviderId provider)?  storageAuthExpired,TResult Function()?  vaultConflict,TResult Function( StorageError error)?  storageError,TResult Function()?  driveAccessNotGranted,TResult Function()?  signInCancelled,TResult Function( ProviderId provider,  String? message)?  signInFailed,TResult Function( ProviderId provider)?  profileFailed,TResult Function( String expectedEmail)?  accountMismatch,TResult Function()?  wrongSecret,TResult Function()?  unsupportedVault,TResult Function()?  corruptVault,TResult Function()?  vaultNotFound,TResult Function()?  vaultLocked,TResult Function( MigrationError error,  String? provider)?  migration,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkFailure() when networkFailure != null:
return networkFailure(_that.f);case PlatformFailure() when platformFailure != null:
return platformFailure(_that.message);case FormatExceptionFailure() when formatExceptionFailure != null:
return formatExceptionFailure();case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that.error);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that.data);case AccessTokenFailure() when accessTokenFailure != null:
return accessTokenFailure();case CacheReadFailure() when cacheReadFailure != null:
return cacheReadFailure();case CacheWriteFailure() when cacheWriteFailure != null:
return cacheWriteFailure();case StorageAuthExpired() when storageAuthExpired != null:
return storageAuthExpired(_that.provider);case VaultConflict() when vaultConflict != null:
return vaultConflict();case StorageFailure() when storageError != null:
return storageError(_that.error);case DriveAccessNotGranted() when driveAccessNotGranted != null:
return driveAccessNotGranted();case SignInCancelled() when signInCancelled != null:
return signInCancelled();case SignInFailed() when signInFailed != null:
return signInFailed(_that.provider,_that.message);case ProfileFailed() when profileFailed != null:
return profileFailed(_that.provider);case AccountMismatch() when accountMismatch != null:
return accountMismatch(_that.expectedEmail);case WrongSecret() when wrongSecret != null:
return wrongSecret();case UnsupportedVault() when unsupportedVault != null:
return unsupportedVault();case CorruptVault() when corruptVault != null:
return corruptVault();case VaultNotFound() when vaultNotFound != null:
return vaultNotFound();case VaultLocked() when vaultLocked != null:
return vaultLocked();case MigrationFailure() when migration != null:
return migration(_that.error,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( NetworkFailure f)  networkFailure,required TResult Function( String? message)  platformFailure,required TResult Function()  formatExceptionFailure,required TResult Function( dynamic error)  unableToProcess,required TResult Function( dynamic data)  unexpectedError,required TResult Function()  accessTokenFailure,required TResult Function()  cacheReadFailure,required TResult Function()  cacheWriteFailure,required TResult Function( ProviderId provider)  storageAuthExpired,required TResult Function()  vaultConflict,required TResult Function( StorageError error)  storageError,required TResult Function()  driveAccessNotGranted,required TResult Function()  signInCancelled,required TResult Function( ProviderId provider,  String? message)  signInFailed,required TResult Function( ProviderId provider)  profileFailed,required TResult Function( String expectedEmail)  accountMismatch,required TResult Function()  wrongSecret,required TResult Function()  unsupportedVault,required TResult Function()  corruptVault,required TResult Function()  vaultNotFound,required TResult Function()  vaultLocked,required TResult Function( MigrationError error,  String? provider)  migration,}) {final _that = this;
switch (_that) {
case _NetworkFailure():
return networkFailure(_that.f);case PlatformFailure():
return platformFailure(_that.message);case FormatExceptionFailure():
return formatExceptionFailure();case UnableToProcess():
return unableToProcess(_that.error);case UnexpectedError():
return unexpectedError(_that.data);case AccessTokenFailure():
return accessTokenFailure();case CacheReadFailure():
return cacheReadFailure();case CacheWriteFailure():
return cacheWriteFailure();case StorageAuthExpired():
return storageAuthExpired(_that.provider);case VaultConflict():
return vaultConflict();case StorageFailure():
return storageError(_that.error);case DriveAccessNotGranted():
return driveAccessNotGranted();case SignInCancelled():
return signInCancelled();case SignInFailed():
return signInFailed(_that.provider,_that.message);case ProfileFailed():
return profileFailed(_that.provider);case AccountMismatch():
return accountMismatch(_that.expectedEmail);case WrongSecret():
return wrongSecret();case UnsupportedVault():
return unsupportedVault();case CorruptVault():
return corruptVault();case VaultNotFound():
return vaultNotFound();case VaultLocked():
return vaultLocked();case MigrationFailure():
return migration(_that.error,_that.provider);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( NetworkFailure f)?  networkFailure,TResult? Function( String? message)?  platformFailure,TResult? Function()?  formatExceptionFailure,TResult? Function( dynamic error)?  unableToProcess,TResult? Function( dynamic data)?  unexpectedError,TResult? Function()?  accessTokenFailure,TResult? Function()?  cacheReadFailure,TResult? Function()?  cacheWriteFailure,TResult? Function( ProviderId provider)?  storageAuthExpired,TResult? Function()?  vaultConflict,TResult? Function( StorageError error)?  storageError,TResult? Function()?  driveAccessNotGranted,TResult? Function()?  signInCancelled,TResult? Function( ProviderId provider,  String? message)?  signInFailed,TResult? Function( ProviderId provider)?  profileFailed,TResult? Function( String expectedEmail)?  accountMismatch,TResult? Function()?  wrongSecret,TResult? Function()?  unsupportedVault,TResult? Function()?  corruptVault,TResult? Function()?  vaultNotFound,TResult? Function()?  vaultLocked,TResult? Function( MigrationError error,  String? provider)?  migration,}) {final _that = this;
switch (_that) {
case _NetworkFailure() when networkFailure != null:
return networkFailure(_that.f);case PlatformFailure() when platformFailure != null:
return platformFailure(_that.message);case FormatExceptionFailure() when formatExceptionFailure != null:
return formatExceptionFailure();case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that.error);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that.data);case AccessTokenFailure() when accessTokenFailure != null:
return accessTokenFailure();case CacheReadFailure() when cacheReadFailure != null:
return cacheReadFailure();case CacheWriteFailure() when cacheWriteFailure != null:
return cacheWriteFailure();case StorageAuthExpired() when storageAuthExpired != null:
return storageAuthExpired(_that.provider);case VaultConflict() when vaultConflict != null:
return vaultConflict();case StorageFailure() when storageError != null:
return storageError(_that.error);case DriveAccessNotGranted() when driveAccessNotGranted != null:
return driveAccessNotGranted();case SignInCancelled() when signInCancelled != null:
return signInCancelled();case SignInFailed() when signInFailed != null:
return signInFailed(_that.provider,_that.message);case ProfileFailed() when profileFailed != null:
return profileFailed(_that.provider);case AccountMismatch() when accountMismatch != null:
return accountMismatch(_that.expectedEmail);case WrongSecret() when wrongSecret != null:
return wrongSecret();case UnsupportedVault() when unsupportedVault != null:
return unsupportedVault();case CorruptVault() when corruptVault != null:
return corruptVault();case VaultNotFound() when vaultNotFound != null:
return vaultNotFound();case VaultLocked() when vaultLocked != null:
return vaultLocked();case MigrationFailure() when migration != null:
return migration(_that.error,_that.provider);case _:
  return null;

}
}

}

/// @nodoc


class _NetworkFailure implements Failure {
  const _NetworkFailure(this.f);
  

 final  NetworkFailure f;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkFailureCopyWith<_NetworkFailure> get copyWith => __$NetworkFailureCopyWithImpl<_NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkFailure&&(identical(other.f, f) || other.f == f));
}


@override
int get hashCode => Object.hash(runtimeType,f);

@override
String toString() {
  return 'Failure.networkFailure(f: $f)';
}


}

/// @nodoc
abstract mixin class _$NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$NetworkFailureCopyWith(_NetworkFailure value, $Res Function(_NetworkFailure) _then) = __$NetworkFailureCopyWithImpl;
@useResult
$Res call({
 NetworkFailure f
});


$NetworkFailureCopyWith<$Res> get f;

}
/// @nodoc
class __$NetworkFailureCopyWithImpl<$Res>
    implements _$NetworkFailureCopyWith<$Res> {
  __$NetworkFailureCopyWithImpl(this._self, this._then);

  final _NetworkFailure _self;
  final $Res Function(_NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? f = null,}) {
  return _then(_NetworkFailure(
null == f ? _self.f : f // ignore: cast_nullable_to_non_nullable
as NetworkFailure,
  ));
}

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<$Res> get f {
  
  return $NetworkFailureCopyWith<$Res>(_self.f, (value) {
    return _then(_self.copyWith(f: value));
  });
}
}

/// @nodoc


class PlatformFailure implements Failure {
  const PlatformFailure({this.message});
  

 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformFailureCopyWith<PlatformFailure> get copyWith => _$PlatformFailureCopyWithImpl<PlatformFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'Failure.platformFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $PlatformFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $PlatformFailureCopyWith(PlatformFailure value, $Res Function(PlatformFailure) _then) = _$PlatformFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$PlatformFailureCopyWithImpl<$Res>
    implements $PlatformFailureCopyWith<$Res> {
  _$PlatformFailureCopyWithImpl(this._self, this._then);

  final PlatformFailure _self;
  final $Res Function(PlatformFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(PlatformFailure(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class FormatExceptionFailure implements Failure {
  const FormatExceptionFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatExceptionFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.formatExceptionFailure()';
}


}




/// @nodoc


class UnableToProcess implements Failure {
  const UnableToProcess(this.error);
  

 final  dynamic error;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnableToProcessCopyWith<UnableToProcess> get copyWith => _$UnableToProcessCopyWithImpl<UnableToProcess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnableToProcess&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'Failure.unableToProcess(error: $error)';
}


}

/// @nodoc
abstract mixin class $UnableToProcessCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnableToProcessCopyWith(UnableToProcess value, $Res Function(UnableToProcess) _then) = _$UnableToProcessCopyWithImpl;
@useResult
$Res call({
 dynamic error
});




}
/// @nodoc
class _$UnableToProcessCopyWithImpl<$Res>
    implements $UnableToProcessCopyWith<$Res> {
  _$UnableToProcessCopyWithImpl(this._self, this._then);

  final UnableToProcess _self;
  final $Res Function(UnableToProcess) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(UnableToProcess(
freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class UnexpectedError implements Failure {
  const UnexpectedError(this.data);
  

 final  dynamic data;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnexpectedErrorCopyWith<UnexpectedError> get copyWith => _$UnexpectedErrorCopyWithImpl<UnexpectedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedError&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'Failure.unexpectedError(data: $data)';
}


}

/// @nodoc
abstract mixin class $UnexpectedErrorCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnexpectedErrorCopyWith(UnexpectedError value, $Res Function(UnexpectedError) _then) = _$UnexpectedErrorCopyWithImpl;
@useResult
$Res call({
 dynamic data
});




}
/// @nodoc
class _$UnexpectedErrorCopyWithImpl<$Res>
    implements $UnexpectedErrorCopyWith<$Res> {
  _$UnexpectedErrorCopyWithImpl(this._self, this._then);

  final UnexpectedError _self;
  final $Res Function(UnexpectedError) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(UnexpectedError(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class AccessTokenFailure implements Failure {
  const AccessTokenFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccessTokenFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.accessTokenFailure()';
}


}




/// @nodoc


class CacheReadFailure implements Failure {
  const CacheReadFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheReadFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.cacheReadFailure()';
}


}




/// @nodoc


class CacheWriteFailure implements Failure {
  const CacheWriteFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheWriteFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.cacheWriteFailure()';
}


}




/// @nodoc


class StorageAuthExpired implements Failure {
  const StorageAuthExpired(this.provider);
  

 final  ProviderId provider;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageAuthExpiredCopyWith<StorageAuthExpired> get copyWith => _$StorageAuthExpiredCopyWithImpl<StorageAuthExpired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageAuthExpired&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'Failure.storageAuthExpired(provider: $provider)';
}


}

/// @nodoc
abstract mixin class $StorageAuthExpiredCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageAuthExpiredCopyWith(StorageAuthExpired value, $Res Function(StorageAuthExpired) _then) = _$StorageAuthExpiredCopyWithImpl;
@useResult
$Res call({
 ProviderId provider
});




}
/// @nodoc
class _$StorageAuthExpiredCopyWithImpl<$Res>
    implements $StorageAuthExpiredCopyWith<$Res> {
  _$StorageAuthExpiredCopyWithImpl(this._self, this._then);

  final StorageAuthExpired _self;
  final $Res Function(StorageAuthExpired) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(StorageAuthExpired(
null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,
  ));
}


}

/// @nodoc


class VaultConflict implements Failure {
  const VaultConflict();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultConflict);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.vaultConflict()';
}


}




/// @nodoc


class StorageFailure implements Failure {
  const StorageFailure(this.error);
  

 final  StorageError error;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageFailureCopyWith<StorageFailure> get copyWith => _$StorageFailureCopyWithImpl<StorageFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'Failure.storageError(error: $error)';
}


}

/// @nodoc
abstract mixin class $StorageFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageFailureCopyWith(StorageFailure value, $Res Function(StorageFailure) _then) = _$StorageFailureCopyWithImpl;
@useResult
$Res call({
 StorageError error
});




}
/// @nodoc
class _$StorageFailureCopyWithImpl<$Res>
    implements $StorageFailureCopyWith<$Res> {
  _$StorageFailureCopyWithImpl(this._self, this._then);

  final StorageFailure _self;
  final $Res Function(StorageFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(StorageFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as StorageError,
  ));
}


}

/// @nodoc


class DriveAccessNotGranted implements Failure {
  const DriveAccessNotGranted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriveAccessNotGranted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.driveAccessNotGranted()';
}


}




/// @nodoc


class SignInCancelled implements Failure {
  const SignInCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.signInCancelled()';
}


}




/// @nodoc


class SignInFailed implements Failure {
  const SignInFailed(this.provider, {this.message});
  

 final  ProviderId provider;
 final  String? message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInFailedCopyWith<SignInFailed> get copyWith => _$SignInFailedCopyWithImpl<SignInFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInFailed&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,provider,message);

@override
String toString() {
  return 'Failure.signInFailed(provider: $provider, message: $message)';
}


}

/// @nodoc
abstract mixin class $SignInFailedCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $SignInFailedCopyWith(SignInFailed value, $Res Function(SignInFailed) _then) = _$SignInFailedCopyWithImpl;
@useResult
$Res call({
 ProviderId provider, String? message
});




}
/// @nodoc
class _$SignInFailedCopyWithImpl<$Res>
    implements $SignInFailedCopyWith<$Res> {
  _$SignInFailedCopyWithImpl(this._self, this._then);

  final SignInFailed _self;
  final $Res Function(SignInFailed) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? message = freezed,}) {
  return _then(SignInFailed(
null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ProfileFailed implements Failure {
  const ProfileFailed(this.provider);
  

 final  ProviderId provider;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileFailedCopyWith<ProfileFailed> get copyWith => _$ProfileFailedCopyWithImpl<ProfileFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileFailed&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'Failure.profileFailed(provider: $provider)';
}


}

/// @nodoc
abstract mixin class $ProfileFailedCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ProfileFailedCopyWith(ProfileFailed value, $Res Function(ProfileFailed) _then) = _$ProfileFailedCopyWithImpl;
@useResult
$Res call({
 ProviderId provider
});




}
/// @nodoc
class _$ProfileFailedCopyWithImpl<$Res>
    implements $ProfileFailedCopyWith<$Res> {
  _$ProfileFailedCopyWithImpl(this._self, this._then);

  final ProfileFailed _self;
  final $Res Function(ProfileFailed) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(ProfileFailed(
null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,
  ));
}


}

/// @nodoc


class AccountMismatch implements Failure {
  const AccountMismatch(this.expectedEmail);
  

 final  String expectedEmail;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountMismatchCopyWith<AccountMismatch> get copyWith => _$AccountMismatchCopyWithImpl<AccountMismatch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountMismatch&&(identical(other.expectedEmail, expectedEmail) || other.expectedEmail == expectedEmail));
}


@override
int get hashCode => Object.hash(runtimeType,expectedEmail);

@override
String toString() {
  return 'Failure.accountMismatch(expectedEmail: $expectedEmail)';
}


}

/// @nodoc
abstract mixin class $AccountMismatchCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $AccountMismatchCopyWith(AccountMismatch value, $Res Function(AccountMismatch) _then) = _$AccountMismatchCopyWithImpl;
@useResult
$Res call({
 String expectedEmail
});




}
/// @nodoc
class _$AccountMismatchCopyWithImpl<$Res>
    implements $AccountMismatchCopyWith<$Res> {
  _$AccountMismatchCopyWithImpl(this._self, this._then);

  final AccountMismatch _self;
  final $Res Function(AccountMismatch) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expectedEmail = null,}) {
  return _then(AccountMismatch(
null == expectedEmail ? _self.expectedEmail : expectedEmail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class WrongSecret implements Failure {
  const WrongSecret();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WrongSecret);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.wrongSecret()';
}


}




/// @nodoc


class UnsupportedVault implements Failure {
  const UnsupportedVault();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnsupportedVault);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.unsupportedVault()';
}


}




/// @nodoc


class CorruptVault implements Failure {
  const CorruptVault();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CorruptVault);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.corruptVault()';
}


}




/// @nodoc


class VaultNotFound implements Failure {
  const VaultNotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.vaultNotFound()';
}


}




/// @nodoc


class VaultLocked implements Failure {
  const VaultLocked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultLocked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.vaultLocked()';
}


}




/// @nodoc


class MigrationFailure implements Failure {
  const MigrationFailure(this.error, {this.provider});
  

 final  MigrationError error;
 final  String? provider;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrationFailureCopyWith<MigrationFailure> get copyWith => _$MigrationFailureCopyWithImpl<MigrationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrationFailure&&(identical(other.error, error) || other.error == error)&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,error,provider);

@override
String toString() {
  return 'Failure.migration(error: $error, provider: $provider)';
}


}

/// @nodoc
abstract mixin class $MigrationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $MigrationFailureCopyWith(MigrationFailure value, $Res Function(MigrationFailure) _then) = _$MigrationFailureCopyWithImpl;
@useResult
$Res call({
 MigrationError error, String? provider
});




}
/// @nodoc
class _$MigrationFailureCopyWithImpl<$Res>
    implements $MigrationFailureCopyWith<$Res> {
  _$MigrationFailureCopyWithImpl(this._self, this._then);

  final MigrationFailure _self;
  final $Res Function(MigrationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,Object? provider = freezed,}) {
  return _then(MigrationFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as MigrationError,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
