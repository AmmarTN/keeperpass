// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanState {

 CubitStatus get status; ScanStep get step;/// The code read, while "Code Found" is up.
 OtpauthCode? get found;/// The items named like [found]'s site, A to Z (plan, Part 15 rule 5).
 List<VaultRow> get matches;/// Where "Save code" puts it: one of [matches], or null for a new
/// Authenticator item.
 String? get targetId;/// The last thing to say over the camera; [notices] counts them, so the
/// same one shows again.
 ScanNotice? get notice; int get notices;
/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanStateCopyWith<ScanState> get copyWith => _$ScanStateCopyWithImpl<ScanState>(this as ScanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanState&&(identical(other.status, status) || other.status == status)&&(identical(other.step, step) || other.step == step)&&(identical(other.found, found) || other.found == found)&&const DeepCollectionEquality().equals(other.matches, matches)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.notice, notice) || other.notice == notice)&&(identical(other.notices, notices) || other.notices == notices));
}


@override
int get hashCode => Object.hash(runtimeType,status,step,found,const DeepCollectionEquality().hash(matches),targetId,notice,notices);

@override
String toString() {
  return 'ScanState(status: $status, step: $step, found: $found, matches: $matches, targetId: $targetId, notice: $notice, notices: $notices)';
}


}

/// @nodoc
abstract mixin class $ScanStateCopyWith<$Res>  {
  factory $ScanStateCopyWith(ScanState value, $Res Function(ScanState) _then) = _$ScanStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, ScanStep step, OtpauthCode? found, List<VaultRow> matches, String? targetId, ScanNotice? notice, int notices
});




}
/// @nodoc
class _$ScanStateCopyWithImpl<$Res>
    implements $ScanStateCopyWith<$Res> {
  _$ScanStateCopyWithImpl(this._self, this._then);

  final ScanState _self;
  final $Res Function(ScanState) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? step = null,Object? found = freezed,Object? matches = null,Object? targetId = freezed,Object? notice = freezed,Object? notices = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ScanStep,found: freezed == found ? _self.found : found // ignore: cast_nullable_to_non_nullable
as OtpauthCode?,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<VaultRow>,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as ScanNotice?,notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanState].
extension ScanStatePatterns on ScanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanState value)  $default,){
final _that = this;
switch (_that) {
case _ScanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanState value)?  $default,){
final _that = this;
switch (_that) {
case _ScanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  ScanStep step,  OtpauthCode? found,  List<VaultRow> matches,  String? targetId,  ScanNotice? notice,  int notices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanState() when $default != null:
return $default(_that.status,_that.step,_that.found,_that.matches,_that.targetId,_that.notice,_that.notices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  ScanStep step,  OtpauthCode? found,  List<VaultRow> matches,  String? targetId,  ScanNotice? notice,  int notices)  $default,) {final _that = this;
switch (_that) {
case _ScanState():
return $default(_that.status,_that.step,_that.found,_that.matches,_that.targetId,_that.notice,_that.notices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  ScanStep step,  OtpauthCode? found,  List<VaultRow> matches,  String? targetId,  ScanNotice? notice,  int notices)?  $default,) {final _that = this;
switch (_that) {
case _ScanState() when $default != null:
return $default(_that.status,_that.step,_that.found,_that.matches,_that.targetId,_that.notice,_that.notices);case _:
  return null;

}
}

}

/// @nodoc


class _ScanState extends ScanState {
  const _ScanState({this.status = const CubitStatus(), this.step = ScanStep.primer, this.found, final  List<VaultRow> matches = const <VaultRow>[], this.targetId, this.notice, this.notices = 0}): _matches = matches,super._();
  

@override@JsonKey() final  CubitStatus status;
@override@JsonKey() final  ScanStep step;
/// The code read, while "Code Found" is up.
@override final  OtpauthCode? found;
/// The items named like [found]'s site, A to Z (plan, Part 15 rule 5).
 final  List<VaultRow> _matches;
/// The items named like [found]'s site, A to Z (plan, Part 15 rule 5).
@override@JsonKey() List<VaultRow> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}

/// Where "Save code" puts it: one of [matches], or null for a new
/// Authenticator item.
@override final  String? targetId;
/// The last thing to say over the camera; [notices] counts them, so the
/// same one shows again.
@override final  ScanNotice? notice;
@override@JsonKey() final  int notices;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanStateCopyWith<_ScanState> get copyWith => __$ScanStateCopyWithImpl<_ScanState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanState&&(identical(other.status, status) || other.status == status)&&(identical(other.step, step) || other.step == step)&&(identical(other.found, found) || other.found == found)&&const DeepCollectionEquality().equals(other._matches, _matches)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.notice, notice) || other.notice == notice)&&(identical(other.notices, notices) || other.notices == notices));
}


@override
int get hashCode => Object.hash(runtimeType,status,step,found,const DeepCollectionEquality().hash(_matches),targetId,notice,notices);

@override
String toString() {
  return 'ScanState(status: $status, step: $step, found: $found, matches: $matches, targetId: $targetId, notice: $notice, notices: $notices)';
}


}

/// @nodoc
abstract mixin class _$ScanStateCopyWith<$Res> implements $ScanStateCopyWith<$Res> {
  factory _$ScanStateCopyWith(_ScanState value, $Res Function(_ScanState) _then) = __$ScanStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, ScanStep step, OtpauthCode? found, List<VaultRow> matches, String? targetId, ScanNotice? notice, int notices
});




}
/// @nodoc
class __$ScanStateCopyWithImpl<$Res>
    implements _$ScanStateCopyWith<$Res> {
  __$ScanStateCopyWithImpl(this._self, this._then);

  final _ScanState _self;
  final $Res Function(_ScanState) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? step = null,Object? found = freezed,Object? matches = null,Object? targetId = freezed,Object? notice = freezed,Object? notices = null,}) {
  return _then(_ScanState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as ScanStep,found: freezed == found ? _self.found : found // ignore: cast_nullable_to_non_nullable
as OtpauthCode?,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<VaultRow>,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as ScanNotice?,notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
