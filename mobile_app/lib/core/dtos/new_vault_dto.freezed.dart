// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_vault_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewVaultDto {

 PreparedVault get vault;/// Start a new vault only: when the old file is renamed, and its name.
 DateTime? get backupAt;/// Start a new vault only: the old file is out of the way.
 void Function()? get onBackedUp; UploadProgress? get onProgress;
/// Create a copy of NewVaultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewVaultDtoCopyWith<NewVaultDto> get copyWith => _$NewVaultDtoCopyWithImpl<NewVaultDto>(this as NewVaultDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewVaultDto&&(identical(other.vault, vault) || other.vault == vault)&&(identical(other.backupAt, backupAt) || other.backupAt == backupAt)&&(identical(other.onBackedUp, onBackedUp) || other.onBackedUp == onBackedUp)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,vault,backupAt,onBackedUp,onProgress);

@override
String toString() {
  return 'NewVaultDto(vault: $vault, backupAt: $backupAt, onBackedUp: $onBackedUp, onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class $NewVaultDtoCopyWith<$Res>  {
  factory $NewVaultDtoCopyWith(NewVaultDto value, $Res Function(NewVaultDto) _then) = _$NewVaultDtoCopyWithImpl;
@useResult
$Res call({
 PreparedVault vault, DateTime? backupAt, void Function()? onBackedUp, UploadProgress? onProgress
});


$PreparedVaultCopyWith<$Res> get vault;

}
/// @nodoc
class _$NewVaultDtoCopyWithImpl<$Res>
    implements $NewVaultDtoCopyWith<$Res> {
  _$NewVaultDtoCopyWithImpl(this._self, this._then);

  final NewVaultDto _self;
  final $Res Function(NewVaultDto) _then;

/// Create a copy of NewVaultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vault = null,Object? backupAt = freezed,Object? onBackedUp = freezed,Object? onProgress = freezed,}) {
  return _then(_self.copyWith(
vault: null == vault ? _self.vault : vault // ignore: cast_nullable_to_non_nullable
as PreparedVault,backupAt: freezed == backupAt ? _self.backupAt : backupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,onBackedUp: freezed == onBackedUp ? _self.onBackedUp : onBackedUp // ignore: cast_nullable_to_non_nullable
as void Function()?,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as UploadProgress?,
  ));
}
/// Create a copy of NewVaultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreparedVaultCopyWith<$Res> get vault {
  
  return $PreparedVaultCopyWith<$Res>(_self.vault, (value) {
    return _then(_self.copyWith(vault: value));
  });
}
}


/// Adds pattern-matching-related methods to [NewVaultDto].
extension NewVaultDtoPatterns on NewVaultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewVaultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewVaultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewVaultDto value)  $default,){
final _that = this;
switch (_that) {
case _NewVaultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewVaultDto value)?  $default,){
final _that = this;
switch (_that) {
case _NewVaultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PreparedVault vault,  DateTime? backupAt,  void Function()? onBackedUp,  UploadProgress? onProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewVaultDto() when $default != null:
return $default(_that.vault,_that.backupAt,_that.onBackedUp,_that.onProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PreparedVault vault,  DateTime? backupAt,  void Function()? onBackedUp,  UploadProgress? onProgress)  $default,) {final _that = this;
switch (_that) {
case _NewVaultDto():
return $default(_that.vault,_that.backupAt,_that.onBackedUp,_that.onProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PreparedVault vault,  DateTime? backupAt,  void Function()? onBackedUp,  UploadProgress? onProgress)?  $default,) {final _that = this;
switch (_that) {
case _NewVaultDto() when $default != null:
return $default(_that.vault,_that.backupAt,_that.onBackedUp,_that.onProgress);case _:
  return null;

}
}

}

/// @nodoc


class _NewVaultDto implements NewVaultDto {
  const _NewVaultDto({required this.vault, this.backupAt, this.onBackedUp, this.onProgress});
  

@override final  PreparedVault vault;
/// Start a new vault only: when the old file is renamed, and its name.
@override final  DateTime? backupAt;
/// Start a new vault only: the old file is out of the way.
@override final  void Function()? onBackedUp;
@override final  UploadProgress? onProgress;

/// Create a copy of NewVaultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewVaultDtoCopyWith<_NewVaultDto> get copyWith => __$NewVaultDtoCopyWithImpl<_NewVaultDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewVaultDto&&(identical(other.vault, vault) || other.vault == vault)&&(identical(other.backupAt, backupAt) || other.backupAt == backupAt)&&(identical(other.onBackedUp, onBackedUp) || other.onBackedUp == onBackedUp)&&(identical(other.onProgress, onProgress) || other.onProgress == onProgress));
}


@override
int get hashCode => Object.hash(runtimeType,vault,backupAt,onBackedUp,onProgress);

@override
String toString() {
  return 'NewVaultDto(vault: $vault, backupAt: $backupAt, onBackedUp: $onBackedUp, onProgress: $onProgress)';
}


}

/// @nodoc
abstract mixin class _$NewVaultDtoCopyWith<$Res> implements $NewVaultDtoCopyWith<$Res> {
  factory _$NewVaultDtoCopyWith(_NewVaultDto value, $Res Function(_NewVaultDto) _then) = __$NewVaultDtoCopyWithImpl;
@override @useResult
$Res call({
 PreparedVault vault, DateTime? backupAt, void Function()? onBackedUp, UploadProgress? onProgress
});


@override $PreparedVaultCopyWith<$Res> get vault;

}
/// @nodoc
class __$NewVaultDtoCopyWithImpl<$Res>
    implements _$NewVaultDtoCopyWith<$Res> {
  __$NewVaultDtoCopyWithImpl(this._self, this._then);

  final _NewVaultDto _self;
  final $Res Function(_NewVaultDto) _then;

/// Create a copy of NewVaultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vault = null,Object? backupAt = freezed,Object? onBackedUp = freezed,Object? onProgress = freezed,}) {
  return _then(_NewVaultDto(
vault: null == vault ? _self.vault : vault // ignore: cast_nullable_to_non_nullable
as PreparedVault,backupAt: freezed == backupAt ? _self.backupAt : backupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,onBackedUp: freezed == onBackedUp ? _self.onBackedUp : onBackedUp // ignore: cast_nullable_to_non_nullable
as void Function()?,onProgress: freezed == onProgress ? _self.onProgress : onProgress // ignore: cast_nullable_to_non_nullable
as UploadProgress?,
  ));
}

/// Create a copy of NewVaultDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreparedVaultCopyWith<$Res> get vault {
  
  return $PreparedVaultCopyWith<$Res>(_self.vault, (value) {
    return _then(_self.copyWith(vault: value));
  });
}
}

// dart format on
