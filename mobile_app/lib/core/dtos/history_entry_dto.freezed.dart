// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryEntryDto {

 String get itemId; int get index;
/// Create a copy of HistoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryEntryDtoCopyWith<HistoryEntryDto> get copyWith => _$HistoryEntryDtoCopyWithImpl<HistoryEntryDto>(this as HistoryEntryDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryEntryDto&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,index);

@override
String toString() {
  return 'HistoryEntryDto(itemId: $itemId, index: $index)';
}


}

/// @nodoc
abstract mixin class $HistoryEntryDtoCopyWith<$Res>  {
  factory $HistoryEntryDtoCopyWith(HistoryEntryDto value, $Res Function(HistoryEntryDto) _then) = _$HistoryEntryDtoCopyWithImpl;
@useResult
$Res call({
 String itemId, int index
});




}
/// @nodoc
class _$HistoryEntryDtoCopyWithImpl<$Res>
    implements $HistoryEntryDtoCopyWith<$Res> {
  _$HistoryEntryDtoCopyWithImpl(this._self, this._then);

  final HistoryEntryDto _self;
  final $Res Function(HistoryEntryDto) _then;

/// Create a copy of HistoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? index = null,}) {
  return _then(_self.copyWith(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryEntryDto].
extension HistoryEntryDtoPatterns on HistoryEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _HistoryEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemId,  int index)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryEntryDto() when $default != null:
return $default(_that.itemId,_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemId,  int index)  $default,) {final _that = this;
switch (_that) {
case _HistoryEntryDto():
return $default(_that.itemId,_that.index);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemId,  int index)?  $default,) {final _that = this;
switch (_that) {
case _HistoryEntryDto() when $default != null:
return $default(_that.itemId,_that.index);case _:
  return null;

}
}

}

/// @nodoc


class _HistoryEntryDto implements HistoryEntryDto {
  const _HistoryEntryDto({required this.itemId, required this.index});
  

@override final  String itemId;
@override final  int index;

/// Create a copy of HistoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryEntryDtoCopyWith<_HistoryEntryDto> get copyWith => __$HistoryEntryDtoCopyWithImpl<_HistoryEntryDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryEntryDto&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,index);

@override
String toString() {
  return 'HistoryEntryDto(itemId: $itemId, index: $index)';
}


}

/// @nodoc
abstract mixin class _$HistoryEntryDtoCopyWith<$Res> implements $HistoryEntryDtoCopyWith<$Res> {
  factory _$HistoryEntryDtoCopyWith(_HistoryEntryDto value, $Res Function(_HistoryEntryDto) _then) = __$HistoryEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String itemId, int index
});




}
/// @nodoc
class __$HistoryEntryDtoCopyWithImpl<$Res>
    implements _$HistoryEntryDtoCopyWith<$Res> {
  __$HistoryEntryDtoCopyWithImpl(this._self, this._then);

  final _HistoryEntryDto _self;
  final $Res Function(_HistoryEntryDto) _then;

/// Create a copy of HistoryEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? index = null,}) {
  return _then(_HistoryEntryDto(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
