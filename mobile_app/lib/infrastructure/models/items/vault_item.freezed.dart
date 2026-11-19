// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vault_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaultItem {

 String get id; String get vaultId; String get name;@JsonKey(toJson: fieldsToVaultJson) List<Field> get fields; List<String> get tags;/// When the item was first added; absent in vaults written before it
/// existed (see [createdOrUpdated]).
@WebDateNullableConverter() DateTime? get created;@WebDateConverter() DateTime get updated;/// Days after an update before the item counts as expired.
 int? get expiresAfter;@WebDateNullableConverter() DateTime? get expiresAt;/// Newest first, at most [kItemHistoryLimit].
@JsonKey(toJson: _historyToJson) List<HistoryEntry> get history;/// Overrides the icon derived from the item's field types (an app icon
/// name).
 String? get icon;/// A Font Awesome code point picked from the catalogue (hex); wins over
/// [icon].
 String? get iconGlyph;@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown;
/// Create a copy of VaultItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaultItemCopyWith<VaultItem> get copyWith => _$VaultItemCopyWithImpl<VaultItem>(this as VaultItem, _$identity);

  /// Serializes this VaultItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultItem&&(identical(other.id, id) || other.id == id)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.expiresAfter, expiresAfter) || other.expiresAfter == expiresAfter)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&const DeepCollectionEquality().equals(other.unknown, unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vaultId,name,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(tags),created,updated,expiresAfter,expiresAt,const DeepCollectionEquality().hash(history),icon,iconGlyph,const DeepCollectionEquality().hash(unknown));

@override
String toString() {
  return 'VaultItem(id: $id, vaultId: $vaultId, name: $name, fields: $fields, tags: $tags, created: $created, updated: $updated, expiresAfter: $expiresAfter, expiresAt: $expiresAt, history: $history, icon: $icon, iconGlyph: $iconGlyph, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class $VaultItemCopyWith<$Res>  {
  factory $VaultItemCopyWith(VaultItem value, $Res Function(VaultItem) _then) = _$VaultItemCopyWithImpl;
@useResult
$Res call({
 String id, String vaultId, String name,@JsonKey(toJson: fieldsToVaultJson) List<Field> fields, List<String> tags,@WebDateNullableConverter() DateTime? created,@WebDateConverter() DateTime updated, int? expiresAfter,@WebDateNullableConverter() DateTime? expiresAt,@JsonKey(toJson: _historyToJson) List<HistoryEntry> history, String? icon, String? iconGlyph,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class _$VaultItemCopyWithImpl<$Res>
    implements $VaultItemCopyWith<$Res> {
  _$VaultItemCopyWithImpl(this._self, this._then);

  final VaultItem _self;
  final $Res Function(VaultItem) _then;

/// Create a copy of VaultItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vaultId = null,Object? name = null,Object? fields = null,Object? tags = null,Object? created = freezed,Object? updated = null,Object? expiresAfter = freezed,Object? expiresAt = freezed,Object? history = null,Object? icon = freezed,Object? iconGlyph = freezed,Object? unknown = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<Field>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAfter: freezed == expiresAfter ? _self.expiresAfter : expiresAfter // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<HistoryEntry>,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [VaultItem].
extension VaultItemPatterns on VaultItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaultItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaultItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaultItem value)  $default,){
final _that = this;
switch (_that) {
case _VaultItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaultItem value)?  $default,){
final _that = this;
switch (_that) {
case _VaultItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vaultId,  String name, @JsonKey(toJson: fieldsToVaultJson)  List<Field> fields,  List<String> tags, @WebDateNullableConverter()  DateTime? created, @WebDateConverter()  DateTime updated,  int? expiresAfter, @WebDateNullableConverter()  DateTime? expiresAt, @JsonKey(toJson: _historyToJson)  List<HistoryEntry> history,  String? icon,  String? iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaultItem() when $default != null:
return $default(_that.id,_that.vaultId,_that.name,_that.fields,_that.tags,_that.created,_that.updated,_that.expiresAfter,_that.expiresAt,_that.history,_that.icon,_that.iconGlyph,_that.unknown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vaultId,  String name, @JsonKey(toJson: fieldsToVaultJson)  List<Field> fields,  List<String> tags, @WebDateNullableConverter()  DateTime? created, @WebDateConverter()  DateTime updated,  int? expiresAfter, @WebDateNullableConverter()  DateTime? expiresAt, @JsonKey(toJson: _historyToJson)  List<HistoryEntry> history,  String? icon,  String? iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)  $default,) {final _that = this;
switch (_that) {
case _VaultItem():
return $default(_that.id,_that.vaultId,_that.name,_that.fields,_that.tags,_that.created,_that.updated,_that.expiresAfter,_that.expiresAt,_that.history,_that.icon,_that.iconGlyph,_that.unknown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vaultId,  String name, @JsonKey(toJson: fieldsToVaultJson)  List<Field> fields,  List<String> tags, @WebDateNullableConverter()  DateTime? created, @WebDateConverter()  DateTime updated,  int? expiresAfter, @WebDateNullableConverter()  DateTime? expiresAt, @JsonKey(toJson: _historyToJson)  List<HistoryEntry> history,  String? icon,  String? iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,) {final _that = this;
switch (_that) {
case _VaultItem() when $default != null:
return $default(_that.id,_that.vaultId,_that.name,_that.fields,_that.tags,_that.created,_that.updated,_that.expiresAfter,_that.expiresAt,_that.history,_that.icon,_that.iconGlyph,_that.unknown);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, createFieldMap: true)
class _VaultItem extends VaultItem {
  const _VaultItem({required this.id, required this.vaultId, required this.name, @JsonKey(toJson: fieldsToVaultJson) final  List<Field> fields = const <Field>[], final  List<String> tags = const <String>[], @WebDateNullableConverter() this.created, @WebDateConverter() required this.updated, this.expiresAfter, @WebDateNullableConverter() this.expiresAt, @JsonKey(toJson: _historyToJson) final  List<HistoryEntry> history = const <HistoryEntry>[], this.icon, this.iconGlyph, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) final  Map<String, Object?> unknown = const <String, Object?>{}}): _fields = fields,_tags = tags,_history = history,_unknown = unknown,super._();
  factory _VaultItem.fromJson(Map<String, dynamic> json) => _$VaultItemFromJson(json);

@override final  String id;
@override final  String vaultId;
@override final  String name;
 final  List<Field> _fields;
@override@JsonKey(toJson: fieldsToVaultJson) List<Field> get fields {
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

/// When the item was first added; absent in vaults written before it
/// existed (see [createdOrUpdated]).
@override@WebDateNullableConverter() final  DateTime? created;
@override@WebDateConverter() final  DateTime updated;
/// Days after an update before the item counts as expired.
@override final  int? expiresAfter;
@override@WebDateNullableConverter() final  DateTime? expiresAt;
/// Newest first, at most [kItemHistoryLimit].
 final  List<HistoryEntry> _history;
/// Newest first, at most [kItemHistoryLimit].
@override@JsonKey(toJson: _historyToJson) List<HistoryEntry> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

/// Overrides the icon derived from the item's field types (an app icon
/// name).
@override final  String? icon;
/// A Font Awesome code point picked from the catalogue (hex); wins over
/// [icon].
@override final  String? iconGlyph;
 final  Map<String, Object?> _unknown;
@override@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown {
  if (_unknown is EqualUnmodifiableMapView) return _unknown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unknown);
}


/// Create a copy of VaultItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaultItemCopyWith<_VaultItem> get copyWith => __$VaultItemCopyWithImpl<_VaultItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaultItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaultItem&&(identical(other.id, id) || other.id == id)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._fields, _fields)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.expiresAfter, expiresAfter) || other.expiresAfter == expiresAfter)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconGlyph, iconGlyph) || other.iconGlyph == iconGlyph)&&const DeepCollectionEquality().equals(other._unknown, _unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vaultId,name,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_tags),created,updated,expiresAfter,expiresAt,const DeepCollectionEquality().hash(_history),icon,iconGlyph,const DeepCollectionEquality().hash(_unknown));

@override
String toString() {
  return 'VaultItem(id: $id, vaultId: $vaultId, name: $name, fields: $fields, tags: $tags, created: $created, updated: $updated, expiresAfter: $expiresAfter, expiresAt: $expiresAt, history: $history, icon: $icon, iconGlyph: $iconGlyph, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class _$VaultItemCopyWith<$Res> implements $VaultItemCopyWith<$Res> {
  factory _$VaultItemCopyWith(_VaultItem value, $Res Function(_VaultItem) _then) = __$VaultItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String vaultId, String name,@JsonKey(toJson: fieldsToVaultJson) List<Field> fields, List<String> tags,@WebDateNullableConverter() DateTime? created,@WebDateConverter() DateTime updated, int? expiresAfter,@WebDateNullableConverter() DateTime? expiresAt,@JsonKey(toJson: _historyToJson) List<HistoryEntry> history, String? icon, String? iconGlyph,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class __$VaultItemCopyWithImpl<$Res>
    implements _$VaultItemCopyWith<$Res> {
  __$VaultItemCopyWithImpl(this._self, this._then);

  final _VaultItem _self;
  final $Res Function(_VaultItem) _then;

/// Create a copy of VaultItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vaultId = null,Object? name = null,Object? fields = null,Object? tags = null,Object? created = freezed,Object? updated = null,Object? expiresAfter = freezed,Object? expiresAt = freezed,Object? history = null,Object? icon = freezed,Object? iconGlyph = freezed,Object? unknown = null,}) {
  return _then(_VaultItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vaultId: null == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<Field>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAfter: freezed == expiresAfter ? _self.expiresAfter : expiresAfter // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<HistoryEntry>,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,iconGlyph: freezed == iconGlyph ? _self.iconGlyph : iconGlyph // ignore: cast_nullable_to_non_nullable
as String?,unknown: null == unknown ? _self._unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
