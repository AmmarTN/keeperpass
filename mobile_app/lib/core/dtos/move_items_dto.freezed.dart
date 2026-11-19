// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'move_items_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoveItemsDto {

 List<String> get itemIds; String get vaultId;
/// Create a copy of MoveItemsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoveItemsDtoCopyWith<MoveItemsDto> get copyWith => _$MoveItemsDtoCopyWithImpl<MoveItemsDto>(this as MoveItemsDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoveItemsDto&&const DeepCollectionEquality().equals(other.itemIds, itemIds)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(itemIds),vaultId);

@override
String toString() {
  return 'MoveItemsDto(itemIds: $itemIds, vaultId: $vaultId)';
}


}

/// @nodoc
abstract mixin class $MoveItemsDtoCopyWith<$Res>  {
  factory $MoveItemsDtoCopyWith(MoveItemsDto value, $Res Function(MoveItemsDto) _then) = _$MoveItemsDtoCopyWithImpl;
@useResult
$Res call({
 List<String> itemIds, String vaultId
});




}
/// @nodoc
class _$MoveItemsDtoCopyWithImpl<$Res>
    implements $MoveItemsDtoCopyWith<$Res> {
  _$MoveItemsDtoCopyWithImpl(this._self, this._then);

  final MoveItemsDto _self;
  final $Res Function(MoveItemsDto) _then;

/// Create a copy of MoveItemsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemIds = null,Object? vaultId = null,}) {
  return _then(_self.copyWith(
itemIds: null == itemIds ? _self.itemIds : itemIds // ignore: cast_nullable_to_non_nullable
as List<String>,vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MoveItemsDto].
extension MoveItemsDtoPatterns on MoveItemsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoveItemsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoveItemsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoveItemsDto value)  $default,){
final _that = this;
switch (_that) {
case _MoveItemsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoveItemsDto value)?  $default,){
final _that = this;
switch (_that) {
case _MoveItemsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> itemIds,  String vaultId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoveItemsDto() when $default != null:
return $default(_that.itemIds,_that.vaultId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> itemIds,  String vaultId)  $default,) {final _that = this;
switch (_that) {
case _MoveItemsDto():
return $default(_that.itemIds,_that.vaultId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> itemIds,  String vaultId)?  $default,) {final _that = this;
switch (_that) {
case _MoveItemsDto() when $default != null:
return $default(_that.itemIds,_that.vaultId);case _:
  return null;

}
}

}

/// @nodoc


class _MoveItemsDto implements MoveItemsDto {
  const _MoveItemsDto({required final  List<String> itemIds, required this.vaultId}): _itemIds = itemIds;
  

 final  List<String> _itemIds;
@override List<String> get itemIds {
  if (_itemIds is EqualUnmodifiableListView) return _itemIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_itemIds);
}

@override final  String vaultId;

/// Create a copy of MoveItemsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoveItemsDtoCopyWith<_MoveItemsDto> get copyWith => __$MoveItemsDtoCopyWithImpl<_MoveItemsDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoveItemsDto&&const DeepCollectionEquality().equals(other._itemIds, _itemIds)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_itemIds),vaultId);

@override
String toString() {
  return 'MoveItemsDto(itemIds: $itemIds, vaultId: $vaultId)';
}


}

/// @nodoc
abstract mixin class _$MoveItemsDtoCopyWith<$Res> implements $MoveItemsDtoCopyWith<$Res> {
  factory _$MoveItemsDtoCopyWith(_MoveItemsDto value, $Res Function(_MoveItemsDto) _then) = __$MoveItemsDtoCopyWithImpl;
@override @useResult
$Res call({
 List<String> itemIds, String vaultId
});




}
/// @nodoc
class __$MoveItemsDtoCopyWithImpl<$Res>
    implements _$MoveItemsDtoCopyWith<$Res> {
  __$MoveItemsDtoCopyWithImpl(this._self, this._then);

  final _MoveItemsDto _self;
  final $Res Function(_MoveItemsDto) _then;

/// Create a copy of MoveItemsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemIds = null,Object? vaultId = null,}) {
  return _then(_MoveItemsDto(
itemIds: null == itemIds ? _self._itemIds : itemIds // ignore: cast_nullable_to_non_nullable
as List<String>,vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
