// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_edit_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ItemEditDto {

 String get itemId; String get name; List<Field> get fields; List<String> get tags; String? get iconGlyph;/// New items only: where it goes, and its template's icon name.
 String? get vaultId; String? get icon;
/// Create a copy of ItemEditDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemEditDtoCopyWith<ItemEditDto> get copyWith => _$ItemEditDtoCopyWithImpl<ItemEditDto>(this as ItemEditDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemEditDto&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,name,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(tags),iconGlyph,vaultId,icon);

@override
String toString() {
  return 'ItemEditDto(itemId: $itemId, name: $name, fields: $fields, tags: $tags, iconGlyph: $iconGlyph, vaultId: $vaultId, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $ItemEditDtoCopyWith<$Res>  {
  factory $ItemEditDtoCopyWith(ItemEditDto value, $Res Function(ItemEditDto) _then) = _$ItemEditDtoCopyWithImpl;
@useResult
$Res call({
 String itemId, String name, List<Field> fields, List<String> tags, String? iconGlyph, String? vaultId, String? icon
});




}
/// @nodoc
class _$ItemEditDtoCopyWithImpl<$Res>
    implements $ItemEditDtoCopyWith<$Res> {
  _$ItemEditDtoCopyWithImpl(this._self, this._then);

  final ItemEditDto _self;
  final $Res Function(ItemEditDto) _then;

/// Create a copy of ItemEditDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? name = null,Object? fields = null,Object? tags = null,Object? iconGlyph = freezed,Object? vaultId = freezed,Object? icon = freezed,}) {
  return _then(_self.copyWith(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<Field>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemEditDto].
extension ItemEditDtoPatterns on ItemEditDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemEditDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemEditDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemEditDto value)  $default,){
final _that = this;
switch (_that) {
case _ItemEditDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemEditDto value)?  $default,){
final _that = this;
switch (_that) {
case _ItemEditDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemId,  String name,  List<Field> fields,  List<String> tags,  String? iconGlyph,  String? vaultId,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemEditDto() when $default != null:
return $default(_that.itemId,_that.name,_that.fields,_that.tags,_that.iconGlyph,_that.vaultId,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemId,  String name,  List<Field> fields,  List<String> tags,  String? iconGlyph,  String? vaultId,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _ItemEditDto():
return $default(_that.itemId,_that.name,_that.fields,_that.tags,_that.iconGlyph,_that.vaultId,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemId,  String name,  List<Field> fields,  List<String> tags,  String? iconGlyph,  String? vaultId,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _ItemEditDto() when $default != null:
return $default(_that.itemId,_that.name,_that.fields,_that.tags,_that.iconGlyph,_that.vaultId,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class _ItemEditDto implements ItemEditDto {
  const _ItemEditDto({required this.itemId, required this.name, required final  List<Field> fields, required final  List<String> tags, this.iconGlyph, this.vaultId, this.icon}): _fields = fields,_tags = tags;
  

@override final  String itemId;
@override final  String name;
 final  List<Field> _fields;
@override List<Field> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}

 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? iconGlyph;
/// New items only: where it goes, and its template's icon name.
@override final  String? vaultId;
@override final  String? icon;

/// Create a copy of ItemEditDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemEditDtoCopyWith<_ItemEditDto> get copyWith => __$ItemEditDtoCopyWithImpl<_ItemEditDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemEditDto&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._fields, _fields)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,itemId,name,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_tags),iconGlyph,vaultId,icon);

@override
String toString() {
  return 'ItemEditDto(itemId: $itemId, name: $name, fields: $fields, tags: $tags, iconGlyph: $iconGlyph, vaultId: $vaultId, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$ItemEditDtoCopyWith<$Res> implements $ItemEditDtoCopyWith<$Res> {
  factory _$ItemEditDtoCopyWith(_ItemEditDto value, $Res Function(_ItemEditDto) _then) = __$ItemEditDtoCopyWithImpl;
@override @useResult
$Res call({
 String itemId, String name, List<Field> fields, List<String> tags, String? iconGlyph, String? vaultId, String? icon
});




}
/// @nodoc
class __$ItemEditDtoCopyWithImpl<$Res>
    implements _$ItemEditDtoCopyWith<$Res> {
  __$ItemEditDtoCopyWithImpl(this._self, this._then);

  final _ItemEditDto _self;
  final $Res Function(_ItemEditDto) _then;

/// Create a copy of ItemEditDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? name = null,Object? fields = null,Object? tags = null,Object? iconGlyph = freezed,Object? vaultId = freezed,Object? icon = freezed,}) {
  return _then(_ItemEditDto(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<Field>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
