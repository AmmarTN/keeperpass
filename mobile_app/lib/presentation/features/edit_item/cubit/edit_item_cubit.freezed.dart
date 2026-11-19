// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_item_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditableField {

/// Stable while the screen is open, for the widgets.
 int get key; String get typeValue; String get name; String get value;/// The effective flag (`secret ?? type default`).
 bool get secret; String? get iconGlyph;/// The stored field it came from: its keys this version does not know
/// are written back unchanged (X9).
 Field? get original;
/// Create a copy of EditableField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditableFieldCopyWith<EditableField> get copyWith => _$EditableFieldCopyWithImpl<EditableField>(this as EditableField, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditableField&&(identical(other.key, key) || other.key == key)&&(identical(other.typeValue, typeValue) || other.typeValue == typeValue)&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&(identical(other.original, original) || other.original == original));
}


@override
int get hashCode => Object.hash(runtimeType,key,typeValue,name,value,secret,iconGlyph,original);

@override
String toString() {
  return 'EditableField(key: $key, typeValue: $typeValue, name: $name, value: $value, secret: $secret, iconGlyph: $iconGlyph, original: $original)';
}


}

/// @nodoc
abstract mixin class $EditableFieldCopyWith<$Res>  {
  factory $EditableFieldCopyWith(EditableField value, $Res Function(EditableField) _then) = _$EditableFieldCopyWithImpl;
@useResult
$Res call({
 int key, String typeValue, String name, String value, bool secret, String? iconGlyph, Field? original
});


$FieldCopyWith<$Res>? get original;

}
/// @nodoc
class _$EditableFieldCopyWithImpl<$Res>
    implements $EditableFieldCopyWith<$Res> {
  _$EditableFieldCopyWithImpl(this._self, this._then);

  final EditableField _self;
  final $Res Function(EditableField) _then;

/// Create a copy of EditableField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? typeValue = null,Object? name = null,Object? value = null,Object? secret = null,Object? iconGlyph = freezed,Object? original = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as int,typeValue: null == typeValue ? _self.typeValue : typeValue // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as bool,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Field?,
  ));
}
/// Create a copy of EditableField
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $FieldCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditableField].
extension EditableFieldPatterns on EditableField {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditableField value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditableField() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditableField value)  $default,){
final _that = this;
switch (_that) {
case _EditableField():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditableField value)?  $default,){
final _that = this;
switch (_that) {
case _EditableField() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int key,  String typeValue,  String name,  String value,  bool secret,  String? iconGlyph,  Field? original)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditableField() when $default != null:
return $default(_that.key,_that.typeValue,_that.name,_that.value,_that.secret,_that.iconGlyph,_that.original);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int key,  String typeValue,  String name,  String value,  bool secret,  String? iconGlyph,  Field? original)  $default,) {final _that = this;
switch (_that) {
case _EditableField():
return $default(_that.key,_that.typeValue,_that.name,_that.value,_that.secret,_that.iconGlyph,_that.original);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int key,  String typeValue,  String name,  String value,  bool secret,  String? iconGlyph,  Field? original)?  $default,) {final _that = this;
switch (_that) {
case _EditableField() when $default != null:
return $default(_that.key,_that.typeValue,_that.name,_that.value,_that.secret,_that.iconGlyph,_that.original);case _:
  return null;

}
}

}

/// @nodoc


class _EditableField extends EditableField {
  const _EditableField({required this.key, required this.typeValue, required this.name, required this.value, required this.secret, this.iconGlyph, this.original}): super._();
  

/// Stable while the screen is open, for the widgets.
@override final  int key;
@override final  String typeValue;
@override final  String name;
@override final  String value;
/// The effective flag (`secret ?? type default`).
@override final  bool secret;
@override final  String? iconGlyph;
/// The stored field it came from: its keys this version does not know
/// are written back unchanged (X9).
@override final  Field? original;

/// Create a copy of EditableField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditableFieldCopyWith<_EditableField> get copyWith => __$EditableFieldCopyWithImpl<_EditableField>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditableField&&(identical(other.key, key) || other.key == key)&&(identical(other.typeValue, typeValue) || other.typeValue == typeValue)&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&(identical(other.original, original) || other.original == original));
}


@override
int get hashCode => Object.hash(runtimeType,key,typeValue,name,value,secret,iconGlyph,original);

@override
String toString() {
  return 'EditableField(key: $key, typeValue: $typeValue, name: $name, value: $value, secret: $secret, iconGlyph: $iconGlyph, original: $original)';
}


}

/// @nodoc
abstract mixin class _$EditableFieldCopyWith<$Res> implements $EditableFieldCopyWith<$Res> {
  factory _$EditableFieldCopyWith(_EditableField value, $Res Function(_EditableField) _then) = __$EditableFieldCopyWithImpl;
@override @useResult
$Res call({
 int key, String typeValue, String name, String value, bool secret, String? iconGlyph, Field? original
});


@override $FieldCopyWith<$Res>? get original;

}
/// @nodoc
class __$EditableFieldCopyWithImpl<$Res>
    implements _$EditableFieldCopyWith<$Res> {
  __$EditableFieldCopyWithImpl(this._self, this._then);

  final _EditableField _self;
  final $Res Function(_EditableField) _then;

/// Create a copy of EditableField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? typeValue = null,Object? name = null,Object? value = null,Object? secret = null,Object? iconGlyph = freezed,Object? original = freezed,}) {
  return _then(_EditableField(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as int,typeValue: null == typeValue ? _self.typeValue : typeValue // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as bool,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Field?,
  ));
}

/// Create a copy of EditableField
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $FieldCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

/// @nodoc
mixin _$EditItemState {

 CubitStatus get status;/// A new item from a template: nothing reaches the vault before Save.
 bool get isNew;/// The item's id; a new item's id is made up front (web draft id).
 String get itemId; String get vaultId;/// A new item's template icon (web `ItemTemplate.icon`).
 String? get icon; String get name; String? get iconGlyph; List<EditableField> get fields; List<String> get tags;/// How it started, to tell whether anything changed.
 String get startName; String? get startIconGlyph; List<EditableField> get startFields; List<String> get startTags;/// Every tag the vault knows, for the picker.
 List<String> get knownTags;/// The item was deleted elsewhere while this was open.
 bool get gone; bool get saving;
/// Create a copy of EditItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditItemStateCopyWith<EditItemState> get copyWith => _$EditItemStateCopyWithImpl<EditItemState>(this as EditItemState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditItemState&&(identical(other.status, status) || other.status == status)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.startName, startName) || other.startName == startName)&&(identical(other.startIconGlyph, startIconGlyph) || other.startIconGlyph == startIconGlyph)&&const DeepCollectionEquality().equals(other.startFields, startFields)&&const DeepCollectionEquality().equals(other.startTags, startTags)&&const DeepCollectionEquality().equals(other.knownTags, knownTags)&&(identical(other.gone, gone) || other.gone == gone)&&(identical(other.saving, saving) || other.saving == saving));
}


@override
int get hashCode => Object.hash(runtimeType,status,isNew,itemId,vaultId,icon,name,iconGlyph,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(tags),startName,startIconGlyph,const DeepCollectionEquality().hash(startFields),const DeepCollectionEquality().hash(startTags),const DeepCollectionEquality().hash(knownTags),gone,saving);

@override
String toString() {
  return 'EditItemState(status: $status, isNew: $isNew, itemId: $itemId, vaultId: $vaultId, icon: $icon, name: $name, iconGlyph: $iconGlyph, fields: $fields, tags: $tags, startName: $startName, startIconGlyph: $startIconGlyph, startFields: $startFields, startTags: $startTags, knownTags: $knownTags, gone: $gone, saving: $saving)';
}


}

/// @nodoc
abstract mixin class $EditItemStateCopyWith<$Res>  {
  factory $EditItemStateCopyWith(EditItemState value, $Res Function(EditItemState) _then) = _$EditItemStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, bool isNew, String itemId, String vaultId, String? icon, String name, String? iconGlyph, List<EditableField> fields, List<String> tags, String startName, String? startIconGlyph, List<EditableField> startFields, List<String> startTags, List<String> knownTags, bool gone, bool saving
});




}
/// @nodoc
class _$EditItemStateCopyWithImpl<$Res>
    implements $EditItemStateCopyWith<$Res> {
  _$EditItemStateCopyWithImpl(this._self, this._then);

  final EditItemState _self;
  final $Res Function(EditItemState) _then;

/// Create a copy of EditItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? isNew = null,Object? itemId = null,Object? vaultId = null,Object? icon = freezed,Object? name = null,Object? iconGlyph = freezed,Object? fields = null,Object? tags = null,Object? startName = null,Object? startIconGlyph = freezed,Object? startFields = null,Object? startTags = null,Object? knownTags = null,Object? gone = null,Object? saving = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<EditableField>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,startName: null == startName ? _self.startName : startName // ignore: cast_nullable_to_non_nullable
as String,startIconGlyph: freezed == startIconGlyph ? _self.startIconGlyph : startIconGlyph // ignore: cast_nullable_to_non_nullable
as String?,startFields: null == startFields ? _self.startFields : startFields // ignore: cast_nullable_to_non_nullable
as List<EditableField>,startTags: null == startTags ? _self.startTags : startTags // ignore: cast_nullable_to_non_nullable
as List<String>,knownTags: null == knownTags ? _self.knownTags : knownTags // ignore: cast_nullable_to_non_nullable
as List<String>,gone: null == gone ? _self.gone : gone // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EditItemState].
extension EditItemStatePatterns on EditItemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditItemState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditItemState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditItemState value)  $default,){
final _that = this;
switch (_that) {
case _EditItemState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditItemState value)?  $default,){
final _that = this;
switch (_that) {
case _EditItemState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  bool isNew,  String itemId,  String vaultId,  String? icon,  String name,  String? iconGlyph,  List<EditableField> fields,  List<String> tags,  String startName,  String? startIconGlyph,  List<EditableField> startFields,  List<String> startTags,  List<String> knownTags,  bool gone,  bool saving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditItemState() when $default != null:
return $default(_that.status,_that.isNew,_that.itemId,_that.vaultId,_that.icon,_that.name,_that.iconGlyph,_that.fields,_that.tags,_that.startName,_that.startIconGlyph,_that.startFields,_that.startTags,_that.knownTags,_that.gone,_that.saving);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  bool isNew,  String itemId,  String vaultId,  String? icon,  String name,  String? iconGlyph,  List<EditableField> fields,  List<String> tags,  String startName,  String? startIconGlyph,  List<EditableField> startFields,  List<String> startTags,  List<String> knownTags,  bool gone,  bool saving)  $default,) {final _that = this;
switch (_that) {
case _EditItemState():
return $default(_that.status,_that.isNew,_that.itemId,_that.vaultId,_that.icon,_that.name,_that.iconGlyph,_that.fields,_that.tags,_that.startName,_that.startIconGlyph,_that.startFields,_that.startTags,_that.knownTags,_that.gone,_that.saving);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  bool isNew,  String itemId,  String vaultId,  String? icon,  String name,  String? iconGlyph,  List<EditableField> fields,  List<String> tags,  String startName,  String? startIconGlyph,  List<EditableField> startFields,  List<String> startTags,  List<String> knownTags,  bool gone,  bool saving)?  $default,) {final _that = this;
switch (_that) {
case _EditItemState() when $default != null:
return $default(_that.status,_that.isNew,_that.itemId,_that.vaultId,_that.icon,_that.name,_that.iconGlyph,_that.fields,_that.tags,_that.startName,_that.startIconGlyph,_that.startFields,_that.startTags,_that.knownTags,_that.gone,_that.saving);case _:
  return null;

}
}

}

/// @nodoc


class _EditItemState extends EditItemState {
  const _EditItemState({this.status = const CubitStatus(), this.isNew = false, this.itemId = '', this.vaultId = '', this.icon, this.name = '', this.iconGlyph, final  List<EditableField> fields = const <EditableField>[], final  List<String> tags = const <String>[], this.startName = '', this.startIconGlyph, final  List<EditableField> startFields = const <EditableField>[], final  List<String> startTags = const <String>[], final  List<String> knownTags = const <String>[], this.gone = false, this.saving = false}): _fields = fields,_tags = tags,_startFields = startFields,_startTags = startTags,_knownTags = knownTags,super._();
  

@override@JsonKey() final  CubitStatus status;
/// A new item from a template: nothing reaches the vault before Save.
@override@JsonKey() final  bool isNew;
/// The item's id; a new item's id is made up front (web draft id).
@override@JsonKey() final  String itemId;
@override@JsonKey() final  String vaultId;
/// A new item's template icon (web `ItemTemplate.icon`).
@override final  String? icon;
@override@JsonKey() final  String name;
@override final  String? iconGlyph;
 final  List<EditableField> _fields;
@override@JsonKey() List<EditableField> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// How it started, to tell whether anything changed.
@override@JsonKey() final  String startName;
@override final  String? startIconGlyph;
 final  List<EditableField> _startFields;
@override@JsonKey() List<EditableField> get startFields {
  if (_startFields is EqualUnmodifiableListView) return _startFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_startFields);
}

 final  List<String> _startTags;
@override@JsonKey() List<String> get startTags {
  if (_startTags is EqualUnmodifiableListView) return _startTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_startTags);
}

/// Every tag the vault knows, for the picker.
 final  List<String> _knownTags;
/// Every tag the vault knows, for the picker.
@override@JsonKey() List<String> get knownTags {
  if (_knownTags is EqualUnmodifiableListView) return _knownTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_knownTags);
}

/// The item was deleted elsewhere while this was open.
@override@JsonKey() final  bool gone;
@override@JsonKey() final  bool saving;

/// Create a copy of EditItemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditItemStateCopyWith<_EditItemState> get copyWith => __$EditItemStateCopyWithImpl<_EditItemState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditItemState&&(identical(other.status, status) || other.status == status)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&const DeepCollectionEquality().equals(other._fields, _fields)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.startName, startName) || other.startName == startName)&&(identical(other.startIconGlyph, startIconGlyph) || other.startIconGlyph == startIconGlyph)&&const DeepCollectionEquality().equals(other._startFields, _startFields)&&const DeepCollectionEquality().equals(other._startTags, _startTags)&&const DeepCollectionEquality().equals(other._knownTags, _knownTags)&&(identical(other.gone, gone) || other.gone == gone)&&(identical(other.saving, saving) || other.saving == saving));
}


@override
int get hashCode => Object.hash(runtimeType,status,isNew,itemId,vaultId,icon,name,iconGlyph,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_tags),startName,startIconGlyph,const DeepCollectionEquality().hash(_startFields),const DeepCollectionEquality().hash(_startTags),const DeepCollectionEquality().hash(_knownTags),gone,saving);

@override
String toString() {
  return 'EditItemState(status: $status, isNew: $isNew, itemId: $itemId, vaultId: $vaultId, icon: $icon, name: $name, iconGlyph: $iconGlyph, fields: $fields, tags: $tags, startName: $startName, startIconGlyph: $startIconGlyph, startFields: $startFields, startTags: $startTags, knownTags: $knownTags, gone: $gone, saving: $saving)';
}


}

/// @nodoc
abstract mixin class _$EditItemStateCopyWith<$Res> implements $EditItemStateCopyWith<$Res> {
  factory _$EditItemStateCopyWith(_EditItemState value, $Res Function(_EditItemState) _then) = __$EditItemStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, bool isNew, String itemId, String vaultId, String? icon, String name, String? iconGlyph, List<EditableField> fields, List<String> tags, String startName, String? startIconGlyph, List<EditableField> startFields, List<String> startTags, List<String> knownTags, bool gone, bool saving
});




}
/// @nodoc
class __$EditItemStateCopyWithImpl<$Res>
    implements _$EditItemStateCopyWith<$Res> {
  __$EditItemStateCopyWithImpl(this._self, this._then);

  final _EditItemState _self;
  final $Res Function(_EditItemState) _then;

/// Create a copy of EditItemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isNew = null,Object? itemId = null,Object? vaultId = null,Object? icon = freezed,Object? name = null,Object? iconGlyph = freezed,Object? fields = null,Object? tags = null,Object? startName = null,Object? startIconGlyph = freezed,Object? startFields = null,Object? startTags = null,Object? knownTags = null,Object? gone = null,Object? saving = null,}) {
  return _then(_EditItemState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<EditableField>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,startName: null == startName ? _self.startName : startName // ignore: cast_nullable_to_non_nullable
as String,startIconGlyph: freezed == startIconGlyph ? _self.startIconGlyph : startIconGlyph // ignore: cast_nullable_to_non_nullable
as String?,startFields: null == startFields ? _self._startFields : startFields // ignore: cast_nullable_to_non_nullable
as List<EditableField>,startTags: null == startTags ? _self._startTags : startTags // ignore: cast_nullable_to_non_nullable
as List<String>,knownTags: null == knownTags ? _self._knownTags : knownTags // ignore: cast_nullable_to_non_nullable
as List<String>,gone: null == gone ? _self.gone : gone // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
