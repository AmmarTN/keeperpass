// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'move_vault_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoveVaultDto {

 ProviderId get targetProvider; MigrationTarget get target;/// The secret the moved vault is encrypted with: the current one, or a
/// new one chosen for the destination.
 String get secret;/// The person agreed that the destination's vault is kept as a backup
/// and replaced.
 bool get replaceExisting; void Function(MigrationStage stage)? get onStage;/// The upload's share, 0–1 ("Saving to Dropbox…", board `S5-28`).
 void Function(double fraction)? get onProgress;
/// Create a copy of MoveVaultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoveVaultDtoCopyWith<MoveVaultDto> get copyWith => _$MoveVaultDtoCopyWithImpl<MoveVaultDto>(this as MoveVaultDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoveVaultDto&&(identical(other.targetProvider, targetProvider) || other.targetProvider == targetProvider)&&(identical(other.target, target) || other.target == target)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.replaceExisting, replaceExisting) || other.replaceExisting == replaceExisting)&&(identical(other.onStage, onStage) || other.onStage == onStage)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,targetProvider,target,secret,replaceExisting,onStage,onProgress);

@override
String toString() {
  return 'MoveVaultDto(targetProvider: $targetProvider, target: $target, secret: $secret, replaceExisting: $replaceExisting, onStage: $onStage, onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class $MoveVaultDtoCopyWith<$Res>  {
  factory $MoveVaultDtoCopyWith(MoveVaultDto value, $Res Function(MoveVaultDto) _then) = _$MoveVaultDtoCopyWithImpl;
@useResult
$Res call({
 ProviderId targetProvider, MigrationTarget target, String secret, bool replaceExisting, void Function(MigrationStage stage)? onStage, void Function(double fraction)? onProgress
});


$MigrationTargetCopyWith<$Res> get target;

}
/// @nodoc
class _$MoveVaultDtoCopyWithImpl<$Res>
    implements $MoveVaultDtoCopyWith<$Res> {
  _$MoveVaultDtoCopyWithImpl(this._self, this._then);

  final MoveVaultDto _self;
  final $Res Function(MoveVaultDto) _then;

/// Create a copy of MoveVaultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetProvider = null,Object? target = null,Object? secret = null,Object? replaceExisting = null,Object? onStage = freezed,Object? onProgress = freezed,}) {
  return _then(_self.copyWith(
targetProvider: null == targetProvider ? _self.targetProvider : targetProvider // ignore: cast_nullable_to_non_nullable
as ProviderId,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MigrationTarget,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,replaceExisting: null == replaceExisting ? _self.replaceExisting : replaceExisting // ignore: cast_nullable_to_non_nullable
as bool,onStage: freezed == onStage ? _self.onStage : onStage // ignore: cast_nullable_to_non_nullable
as void Function(MigrationStage stage)?,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as void Function(double fraction)?,
  ));
}
/// Create a copy of MoveVaultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MigrationTargetCopyWith<$Res> get target {
  
  return $MigrationTargetCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [MoveVaultDto].
extension MoveVaultDtoPatterns on MoveVaultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoveVaultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoveVaultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoveVaultDto value)  $default,){
final _that = this;
switch (_that) {
case _MoveVaultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoveVaultDto value)?  $default,){
final _that = this;
switch (_that) {
case _MoveVaultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProviderId targetProvider,  MigrationTarget target,  String secret,  bool replaceExisting,  void Function(MigrationStage stage)? onStage,  void Function(double fraction)? onProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoveVaultDto() when $default != null:
return $default(_that.targetProvider,_that.target,_that.secret,_that.replaceExisting,_that.onStage,_that.onProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProviderId targetProvider,  MigrationTarget target,  String secret,  bool replaceExisting,  void Function(MigrationStage stage)? onStage,  void Function(double fraction)? onProgress)  $default,) {final _that = this;
switch (_that) {
case _MoveVaultDto():
return $default(_that.targetProvider,_that.target,_that.secret,_that.replaceExisting,_that.onStage,_that.onProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProviderId targetProvider,  MigrationTarget target,  String secret,  bool replaceExisting,  void Function(MigrationStage stage)? onStage,  void Function(double fraction)? onProgress)?  $default,) {final _that = this;
switch (_that) {
case _MoveVaultDto() when $default != null:
return $default(_that.targetProvider,_that.target,_that.secret,_that.replaceExisting,_that.onStage,_that.onProgress);case _:
  return null;

}
}

}

/// @nodoc


class _MoveVaultDto implements MoveVaultDto {
  const _MoveVaultDto({required this.targetProvider, required this.target, required this.secret, required this.replaceExisting, this.onStage, this.onProgress});
  

@override final  ProviderId targetProvider;
@override final  MigrationTarget target;
/// The secret the moved vault is encrypted with: the current one, or a
/// new one chosen for the destination.
@override final  String secret;
/// The person agreed that the destination's vault is kept as a backup
/// and replaced.
@override final  bool replaceExisting;
@override final  void Function(MigrationStage stage)? onStage;
/// The upload's share, 0–1 ("Saving to Dropbox…", board `S5-28`).
@override final  void Function(double fraction)? onProgress;

/// Create a copy of MoveVaultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoveVaultDtoCopyWith<_MoveVaultDto> get copyWith => __$MoveVaultDtoCopyWithImpl<_MoveVaultDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoveVaultDto&&(identical(other.targetProvider, targetProvider) || other.targetProvider == targetProvider)&&(identical(other.target, target) || other.target == target)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.replaceExisting, replaceExisting) || other.replaceExisting == replaceExisting)&&(identical(other.onStage, onStage) || other.onStage == onStage)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,targetProvider,target,secret,replaceExisting,onStage,onProgress);

@override
String toString() {
  return 'MoveVaultDto(targetProvider: $targetProvider, target: $target, secret: $secret, replaceExisting: $replaceExisting, onStage: $onStage, onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class _$MoveVaultDtoCopyWith<$Res> implements $MoveVaultDtoCopyWith<$Res> {
  factory _$MoveVaultDtoCopyWith(_MoveVaultDto value, $Res Function(_MoveVaultDto) _then) = __$MoveVaultDtoCopyWithImpl;
@override @useResult
$Res call({
 ProviderId targetProvider, MigrationTarget target, String secret, bool replaceExisting, void Function(MigrationStage stage)? onStage, void Function(double fraction)? onProgress
});


@override $MigrationTargetCopyWith<$Res> get target;

}
/// @nodoc
class __$MoveVaultDtoCopyWithImpl<$Res>
    implements _$MoveVaultDtoCopyWith<$Res> {
  __$MoveVaultDtoCopyWithImpl(this._self, this._then);

  final _MoveVaultDto _self;
  final $Res Function(_MoveVaultDto) _then;

/// Create a copy of MoveVaultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetProvider = null,Object? target = null,Object? secret = null,Object? replaceExisting = null,Object? onStage = freezed,Object? onProgress = freezed,}) {
  return _then(_MoveVaultDto(
targetProvider: null == targetProvider ? _self.targetProvider : targetProvider // ignore: cast_nullable_to_non_nullable
as ProviderId,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MigrationTarget,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,replaceExisting: null == replaceExisting ? _self.replaceExisting : replaceExisting // ignore: cast_nullable_to_non_nullable
as bool,onStage: freezed == onStage ? _self.onStage : onStage // ignore: cast_nullable_to_non_nullable
as void Function(MigrationStage stage)?,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as void Function(double fraction)?,
  ));
}

/// Create a copy of MoveVaultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MigrationTargetCopyWith<$Res> get target {
  
  return $MigrationTargetCopyWith<$Res>(_self.target, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}

// dart format on
