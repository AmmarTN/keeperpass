// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_grant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenGrant {

 String get accessToken;/// Already shortened by a safety margin. Null when the provider does not
/// say (Google's SDK): the token is then used until a call is refused.
 DateTime? get expiresAt;/// Only providers that renew without UI hand one back (Dropbox).
 String? get refreshToken;
/// Create a copy of TokenGrant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenGrantCopyWith<TokenGrant> get copyWith => _$TokenGrantCopyWithImpl<TokenGrant>(this as TokenGrant, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenGrant&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,expiresAt,refreshToken);

@override
String toString() {
  return 'TokenGrant(accessToken: $accessToken, expiresAt: $expiresAt, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $TokenGrantCopyWith<$Res>  {
  factory $TokenGrantCopyWith(TokenGrant value, $Res Function(TokenGrant) _then) = _$TokenGrantCopyWithImpl;
@useResult
$Res call({
 String accessToken, DateTime? expiresAt, String? refreshToken
});




}
/// @nodoc
class _$TokenGrantCopyWithImpl<$Res>
    implements $TokenGrantCopyWith<$Res> {
  _$TokenGrantCopyWithImpl(this._self, this._then);

  final TokenGrant _self;
  final $Res Function(TokenGrant) _then;

/// Create a copy of TokenGrant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? expiresAt = freezed,Object? refreshToken = freezed,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenGrant].
extension TokenGrantPatterns on TokenGrant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenGrant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenGrant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenGrant value)  $default,){
final _that = this;
switch (_that) {
case _TokenGrant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenGrant value)?  $default,){
final _that = this;
switch (_that) {
case _TokenGrant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  DateTime? expiresAt,  String? refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenGrant() when $default != null:
return $default(_that.accessToken,_that.expiresAt,_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  DateTime? expiresAt,  String? refreshToken)  $default,) {final _that = this;
switch (_that) {
case _TokenGrant():
return $default(_that.accessToken,_that.expiresAt,_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  DateTime? expiresAt,  String? refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _TokenGrant() when $default != null:
return $default(_that.accessToken,_that.expiresAt,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc


class _TokenGrant extends TokenGrant {
  const _TokenGrant({required this.accessToken, this.expiresAt, this.refreshToken}): super._();
  

@override final  String accessToken;
/// Already shortened by a safety margin. Null when the provider does not
/// say (Google's SDK): the token is then used until a call is refused.
@override final  DateTime? expiresAt;
/// Only providers that renew without UI hand one back (Dropbox).
@override final  String? refreshToken;

/// Create a copy of TokenGrant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenGrantCopyWith<_TokenGrant> get copyWith => __$TokenGrantCopyWithImpl<_TokenGrant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenGrant&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}


@override
int get hashCode => Object.hash(runtimeType,accessToken,expiresAt,refreshToken);

@override
String toString() {
  return 'TokenGrant(accessToken: $accessToken, expiresAt: $expiresAt, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$TokenGrantCopyWith<$Res> implements $TokenGrantCopyWith<$Res> {
  factory _$TokenGrantCopyWith(_TokenGrant value, $Res Function(_TokenGrant) _then) = __$TokenGrantCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, DateTime? expiresAt, String? refreshToken
});




}
/// @nodoc
class __$TokenGrantCopyWithImpl<$Res>
    implements _$TokenGrantCopyWith<$Res> {
  __$TokenGrantCopyWithImpl(this._self, this._then);

  final _TokenGrant _self;
  final $Res Function(_TokenGrant) _then;

/// Create a copy of TokenGrant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? expiresAt = freezed,Object? refreshToken = freezed,}) {
  return _then(_TokenGrant(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
