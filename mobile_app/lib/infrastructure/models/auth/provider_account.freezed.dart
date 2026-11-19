// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProviderProfile {

 String get email; String get name;
/// Create a copy of ProviderProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderProfileCopyWith<ProviderProfile> get copyWith => _$ProviderProfileCopyWithImpl<ProviderProfile>(this as ProviderProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderProfile&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,email,name);

@override
String toString() {
  return 'ProviderProfile(email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class $ProviderProfileCopyWith<$Res>  {
  factory $ProviderProfileCopyWith(ProviderProfile value, $Res Function(ProviderProfile) _then) = _$ProviderProfileCopyWithImpl;
@useResult
$Res call({
 String email, String name
});




}
/// @nodoc
class _$ProviderProfileCopyWithImpl<$Res>
    implements $ProviderProfileCopyWith<$Res> {
  _$ProviderProfileCopyWithImpl(this._self, this._then);

  final ProviderProfile _self;
  final $Res Function(ProviderProfile) _then;

/// Create a copy of ProviderProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? name = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderProfile].
extension ProviderProfilePatterns on ProviderProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderProfile value)  $default,){
final _that = this;
switch (_that) {
case _ProviderProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderProfile value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderProfile() when $default != null:
return $default(_that.email,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String name)  $default,) {final _that = this;
switch (_that) {
case _ProviderProfile():
return $default(_that.email,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String name)?  $default,) {final _that = this;
switch (_that) {
case _ProviderProfile() when $default != null:
return $default(_that.email,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderProfile implements ProviderProfile {
  const _ProviderProfile({required this.email, this.name = ''});
  

@override final  String email;
@override@JsonKey() final  String name;

/// Create a copy of ProviderProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderProfileCopyWith<_ProviderProfile> get copyWith => __$ProviderProfileCopyWithImpl<_ProviderProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderProfile&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,email,name);

@override
String toString() {
  return 'ProviderProfile(email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ProviderProfileCopyWith<$Res> implements $ProviderProfileCopyWith<$Res> {
  factory _$ProviderProfileCopyWith(_ProviderProfile value, $Res Function(_ProviderProfile) _then) = __$ProviderProfileCopyWithImpl;
@override @useResult
$Res call({
 String email, String name
});




}
/// @nodoc
class __$ProviderProfileCopyWithImpl<$Res>
    implements _$ProviderProfileCopyWith<$Res> {
  __$ProviderProfileCopyWithImpl(this._self, this._then);

  final _ProviderProfile _self;
  final $Res Function(_ProviderProfile) _then;

/// Create a copy of ProviderProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? name = null,}) {
  return _then(_ProviderProfile(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ProviderAccount {

 ProviderId get provider; String get email; String get name;
/// Create a copy of ProviderAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderAccountCopyWith<ProviderAccount> get copyWith => _$ProviderAccountCopyWithImpl<ProviderAccount>(this as ProviderAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderAccount&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,provider,email,name);

@override
String toString() {
  return 'ProviderAccount(provider: $provider, email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class $ProviderAccountCopyWith<$Res>  {
  factory $ProviderAccountCopyWith(ProviderAccount value, $Res Function(ProviderAccount) _then) = _$ProviderAccountCopyWithImpl;
@useResult
$Res call({
 ProviderId provider, String email, String name
});




}
/// @nodoc
class _$ProviderAccountCopyWithImpl<$Res>
    implements $ProviderAccountCopyWith<$Res> {
  _$ProviderAccountCopyWithImpl(this._self, this._then);

  final ProviderAccount _self;
  final $Res Function(ProviderAccount) _then;

/// Create a copy of ProviderAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? email = null,Object? name = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderAccount].
extension ProviderAccountPatterns on ProviderAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderAccount value)  $default,){
final _that = this;
switch (_that) {
case _ProviderAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderAccount value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProviderId provider,  String email,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderAccount() when $default != null:
return $default(_that.provider,_that.email,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProviderId provider,  String email,  String name)  $default,) {final _that = this;
switch (_that) {
case _ProviderAccount():
return $default(_that.provider,_that.email,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProviderId provider,  String email,  String name)?  $default,) {final _that = this;
switch (_that) {
case _ProviderAccount() when $default != null:
return $default(_that.provider,_that.email,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderAccount extends ProviderAccount {
  const _ProviderAccount({required this.provider, required this.email, this.name = ''}): super._();
  

@override final  ProviderId provider;
@override final  String email;
@override@JsonKey() final  String name;

/// Create a copy of ProviderAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderAccountCopyWith<_ProviderAccount> get copyWith => __$ProviderAccountCopyWithImpl<_ProviderAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderAccount&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,provider,email,name);

@override
String toString() {
  return 'ProviderAccount(provider: $provider, email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ProviderAccountCopyWith<$Res> implements $ProviderAccountCopyWith<$Res> {
  factory _$ProviderAccountCopyWith(_ProviderAccount value, $Res Function(_ProviderAccount) _then) = __$ProviderAccountCopyWithImpl;
@override @useResult
$Res call({
 ProviderId provider, String email, String name
});




}
/// @nodoc
class __$ProviderAccountCopyWithImpl<$Res>
    implements _$ProviderAccountCopyWith<$Res> {
  __$ProviderAccountCopyWithImpl(this._self, this._then);

  final _ProviderAccount _self;
  final $Res Function(_ProviderAccount) _then;

/// Create a copy of ProviderAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? email = null,Object? name = null,}) {
  return _then(_ProviderAccount(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ProviderSignIn {

 ProviderId get provider; TokenGrant get grant; ProviderProfile get profile;
/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderSignInCopyWith<ProviderSignIn> get copyWith => _$ProviderSignInCopyWithImpl<ProviderSignIn>(this as ProviderSignIn, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderSignIn&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.grant, grant) || other.grant == grant)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,provider,grant,profile);

@override
String toString() {
  return 'ProviderSignIn(provider: $provider, grant: $grant, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $ProviderSignInCopyWith<$Res>  {
  factory $ProviderSignInCopyWith(ProviderSignIn value, $Res Function(ProviderSignIn) _then) = _$ProviderSignInCopyWithImpl;
@useResult
$Res call({
 ProviderId provider, TokenGrant grant, ProviderProfile profile
});


$TokenGrantCopyWith<$Res> get grant;$ProviderProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$ProviderSignInCopyWithImpl<$Res>
    implements $ProviderSignInCopyWith<$Res> {
  _$ProviderSignInCopyWithImpl(this._self, this._then);

  final ProviderSignIn _self;
  final $Res Function(ProviderSignIn) _then;

/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? grant = null,Object? profile = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,grant: null == grant ? _self.grant : grant // ignore: cast_nullable_to_non_nullable
as TokenGrant,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProviderProfile,
  ));
}
/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenGrantCopyWith<$Res> get grant {
  
  return $TokenGrantCopyWith<$Res>(_self.grant, (value) {
    return _then(_self.copyWith(grant: value));
  });
}/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderProfileCopyWith<$Res> get profile {
  
  return $ProviderProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProviderSignIn].
extension ProviderSignInPatterns on ProviderSignIn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderSignIn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderSignIn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderSignIn value)  $default,){
final _that = this;
switch (_that) {
case _ProviderSignIn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderSignIn value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderSignIn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProviderId provider,  TokenGrant grant,  ProviderProfile profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderSignIn() when $default != null:
return $default(_that.provider,_that.grant,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProviderId provider,  TokenGrant grant,  ProviderProfile profile)  $default,) {final _that = this;
switch (_that) {
case _ProviderSignIn():
return $default(_that.provider,_that.grant,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProviderId provider,  TokenGrant grant,  ProviderProfile profile)?  $default,) {final _that = this;
switch (_that) {
case _ProviderSignIn() when $default != null:
return $default(_that.provider,_that.grant,_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderSignIn implements ProviderSignIn {
  const _ProviderSignIn({required this.provider, required this.grant, required this.profile});
  

@override final  ProviderId provider;
@override final  TokenGrant grant;
@override final  ProviderProfile profile;

/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderSignInCopyWith<_ProviderSignIn> get copyWith => __$ProviderSignInCopyWithImpl<_ProviderSignIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderSignIn&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.grant, grant) || other.grant == grant)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,provider,grant,profile);

@override
String toString() {
  return 'ProviderSignIn(provider: $provider, grant: $grant, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$ProviderSignInCopyWith<$Res> implements $ProviderSignInCopyWith<$Res> {
  factory _$ProviderSignInCopyWith(_ProviderSignIn value, $Res Function(_ProviderSignIn) _then) = __$ProviderSignInCopyWithImpl;
@override @useResult
$Res call({
 ProviderId provider, TokenGrant grant, ProviderProfile profile
});


@override $TokenGrantCopyWith<$Res> get grant;@override $ProviderProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$ProviderSignInCopyWithImpl<$Res>
    implements _$ProviderSignInCopyWith<$Res> {
  __$ProviderSignInCopyWithImpl(this._self, this._then);

  final _ProviderSignIn _self;
  final $Res Function(_ProviderSignIn) _then;

/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? grant = null,Object? profile = null,}) {
  return _then(_ProviderSignIn(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as ProviderId,grant: null == grant ? _self.grant : grant // ignore: cast_nullable_to_non_nullable
as TokenGrant,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProviderProfile,
  ));
}

/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokenGrantCopyWith<$Res> get grant {
  
  return $TokenGrantCopyWith<$Res>(_self.grant, (value) {
    return _then(_self.copyWith(grant: value));
  });
}/// Create a copy of ProviderSignIn
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderProfileCopyWith<$Res> get profile {
  
  return $ProviderProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

/// @nodoc
mixin _$RememberedSession {

 ProviderAccount get account;/// Dropbox's; Google's SDK keeps its own sign-in.
 String? get refreshToken;/// The session could not be renewed: the account is kept only to greet
/// the person and offer to sign in again.
 bool get expired;
/// Create a copy of RememberedSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RememberedSessionCopyWith<RememberedSession> get copyWith => _$RememberedSessionCopyWithImpl<RememberedSession>(this as RememberedSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RememberedSession&&(identical(other.account, account) || other.account == account)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expired, expired) || other.expired == expired));
}


@override
int get hashCode => Object.hash(runtimeType,account,refreshToken,expired);

@override
String toString() {
  return 'RememberedSession(account: $account, refreshToken: $refreshToken, expired: $expired)';
}


}

/// @nodoc
abstract mixin class $RememberedSessionCopyWith<$Res>  {
  factory $RememberedSessionCopyWith(RememberedSession value, $Res Function(RememberedSession) _then) = _$RememberedSessionCopyWithImpl;
@useResult
$Res call({
 ProviderAccount account, String? refreshToken, bool expired
});


$ProviderAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$RememberedSessionCopyWithImpl<$Res>
    implements $RememberedSessionCopyWith<$Res> {
  _$RememberedSessionCopyWithImpl(this._self, this._then);

  final RememberedSession _self;
  final $Res Function(RememberedSession) _then;

/// Create a copy of RememberedSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? refreshToken = freezed,Object? expired = null,}) {
  return _then(_self.copyWith(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as ProviderAccount,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RememberedSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderAccountCopyWith<$Res> get account {
  
  return $ProviderAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [RememberedSession].
extension RememberedSessionPatterns on RememberedSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RememberedSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RememberedSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RememberedSession value)  $default,){
final _that = this;
switch (_that) {
case _RememberedSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RememberedSession value)?  $default,){
final _that = this;
switch (_that) {
case _RememberedSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProviderAccount account,  String? refreshToken,  bool expired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RememberedSession() when $default != null:
return $default(_that.account,_that.refreshToken,_that.expired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProviderAccount account,  String? refreshToken,  bool expired)  $default,) {final _that = this;
switch (_that) {
case _RememberedSession():
return $default(_that.account,_that.refreshToken,_that.expired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProviderAccount account,  String? refreshToken,  bool expired)?  $default,) {final _that = this;
switch (_that) {
case _RememberedSession() when $default != null:
return $default(_that.account,_that.refreshToken,_that.expired);case _:
  return null;

}
}

}

/// @nodoc


class _RememberedSession implements RememberedSession {
  const _RememberedSession({required this.account, this.refreshToken, this.expired = false});
  

@override final  ProviderAccount account;
/// Dropbox's; Google's SDK keeps its own sign-in.
@override final  String? refreshToken;
/// The session could not be renewed: the account is kept only to greet
/// the person and offer to sign in again.
@override@JsonKey() final  bool expired;

/// Create a copy of RememberedSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RememberedSessionCopyWith<_RememberedSession> get copyWith => __$RememberedSessionCopyWithImpl<_RememberedSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RememberedSession&&(identical(other.account, account) || other.account == account)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expired, expired) || other.expired == expired));
}


@override
int get hashCode => Object.hash(runtimeType,account,refreshToken,expired);

@override
String toString() {
  return 'RememberedSession(account: $account, refreshToken: $refreshToken, expired: $expired)';
}


}

/// @nodoc
abstract mixin class _$RememberedSessionCopyWith<$Res> implements $RememberedSessionCopyWith<$Res> {
  factory _$RememberedSessionCopyWith(_RememberedSession value, $Res Function(_RememberedSession) _then) = __$RememberedSessionCopyWithImpl;
@override @useResult
$Res call({
 ProviderAccount account, String? refreshToken, bool expired
});


@override $ProviderAccountCopyWith<$Res> get account;

}
/// @nodoc
class __$RememberedSessionCopyWithImpl<$Res>
    implements _$RememberedSessionCopyWith<$Res> {
  __$RememberedSessionCopyWithImpl(this._self, this._then);

  final _RememberedSession _self;
  final $Res Function(_RememberedSession) _then;

/// Create a copy of RememberedSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? refreshToken = freezed,Object? expired = null,}) {
  return _then(_RememberedSession(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as ProviderAccount,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RememberedSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProviderAccountCopyWith<$Res> get account {
  
  return $ProviderAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
