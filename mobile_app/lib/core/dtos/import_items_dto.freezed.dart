// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_items_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportItemsDto {

 String get vaultId; List<ItemDraft> get drafts;
/// Create a copy of ImportItemsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportItemsDtoCopyWith<ImportItemsDto> get copyWith => _$ImportItemsDtoCopyWithImpl<ImportItemsDto>(this as ImportItemsDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportItemsDto&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&const DeepCollectionEquality().equals(other.drafts, drafts));
}


@override
int get hashCode => Object.hash(runtimeType,vaultId,const DeepCollectionEquality().hash(drafts));

@override
String toString() {
  return 'ImportItemsDto(vaultId: $vaultId, drafts: $drafts)';
}


}

/// @nodoc
abstract mixin class $ImportItemsDtoCopyWith<$Res>  {
  factory $ImportItemsDtoCopyWith(ImportItemsDto value, $Res Function(ImportItemsDto) _then) = _$ImportItemsDtoCopyWithImpl;
@useResult
$Res call({
 String vaultId, List<ItemDraft> drafts
});




}
/// @nodoc
class _$ImportItemsDtoCopyWithImpl<$Res>
    implements $ImportItemsDtoCopyWith<$Res> {
  _$ImportItemsDtoCopyWithImpl(this._self, this._then);

  final ImportItemsDto _self;
  final $Res Function(ImportItemsDto) _then;

/// Create a copy of ImportItemsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vaultId = null,Object? drafts = null,}) {
  return _then(_self.copyWith(
vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,drafts: null == drafts ? _self.drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<ItemDraft>,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportItemsDto].
extension ImportItemsDtoPatterns on ImportItemsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportItemsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportItemsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportItemsDto value)  $default,){
final _that = this;
switch (_that) {
case _ImportItemsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportItemsDto value)?  $default,){
final _that = this;
switch (_that) {
case _ImportItemsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String vaultId,  List<ItemDraft> drafts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportItemsDto() when $default != null:
return $default(_that.vaultId,_that.drafts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String vaultId,  List<ItemDraft> drafts)  $default,) {final _that = this;
switch (_that) {
case _ImportItemsDto():
return $default(_that.vaultId,_that.drafts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String vaultId,  List<ItemDraft> drafts)?  $default,) {final _that = this;
switch (_that) {
case _ImportItemsDto() when $default != null:
return $default(_that.vaultId,_that.drafts);case _:
  return null;

}
}

}

/// @nodoc


class _ImportItemsDto implements ImportItemsDto {
  const _ImportItemsDto({required this.vaultId, required final  List<ItemDraft> drafts}): _drafts = drafts;
  

@override final  String vaultId;
 final  List<ItemDraft> _drafts;
@override List<ItemDraft> get drafts {
  if (_drafts is EqualUnmodifiableListView) return _drafts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drafts);
}


/// Create a copy of ImportItemsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportItemsDtoCopyWith<_ImportItemsDto> get copyWith => __$ImportItemsDtoCopyWithImpl<_ImportItemsDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportItemsDto&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&const DeepCollectionEquality().equals(other._drafts, _drafts));
}


@override
int get hashCode => Object.hash(runtimeType,vaultId,const DeepCollectionEquality().hash(_drafts));

@override
String toString() {
  return 'ImportItemsDto(vaultId: $vaultId, drafts: $drafts)';
}


}

/// @nodoc
abstract mixin class _$ImportItemsDtoCopyWith<$Res> implements $ImportItemsDtoCopyWith<$Res> {
  factory _$ImportItemsDtoCopyWith(_ImportItemsDto value, $Res Function(_ImportItemsDto) _then) = __$ImportItemsDtoCopyWithImpl;
@override @useResult
$Res call({
 String vaultId, List<ItemDraft> drafts
});




}
/// @nodoc
class __$ImportItemsDtoCopyWithImpl<$Res>
    implements _$ImportItemsDtoCopyWith<$Res> {
  __$ImportItemsDtoCopyWithImpl(this._self, this._then);

  final _ImportItemsDto _self;
  final $Res Function(_ImportItemsDto) _then;

/// Create a copy of ImportItemsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vaultId = null,Object? drafts = null,}) {
  return _then(_ImportItemsDto(
vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,drafts: null == drafts ? _self._drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<ItemDraft>,
  ));
}


}

// dart format on
