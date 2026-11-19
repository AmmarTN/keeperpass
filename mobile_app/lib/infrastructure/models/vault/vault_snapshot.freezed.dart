// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vault_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaultSnapshot {

@JsonKey(toJson: _vaultsToJson) List<Vault> get vaults;@JsonKey(toJson: _itemsToJson) List<VaultItem> get items;@JsonKey(toJson: _organizationsToJson) List<Organization> get organizations; List<String> get favouriteIds;/// Tags known even with no items; older vaults omit it.
@JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson) List<TagRegistryEntry> get tagRegistry;/// The last exports, newest first, at most [kExportHistoryLimit]; older
/// vaults omit it.
@JsonKey(toJson: _exportsToJson) List<ExportRecord> get exportHistory;@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown;
/// Create a copy of VaultSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaultSnapshotCopyWith<VaultSnapshot> get copyWith => _$VaultSnapshotCopyWithImpl<VaultSnapshot>(this as VaultSnapshot, _$identity);

  /// Serializes this VaultSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultSnapshot&&const DeepCollectionEquality().equals(other.vaults, vaults)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.organizations, organizations)&&const DeepCollectionEquality().equals(other.favouriteIds, favouriteIds)&&const DeepCollectionEquality().equals(other.tagRegistry, tagRegistry)&&const DeepCollectionEquality().equals(other.exportHistory, exportHistory)&&const DeepCollectionEquality().equals(other.unknown, unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(vaults),const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(organizations),const DeepCollectionEquality().hash(favouriteIds),const DeepCollectionEquality().hash(tagRegistry),const DeepCollectionEquality().hash(exportHistory),const DeepCollectionEquality().hash(unknown));

@override
String toString() {
  return 'VaultSnapshot(vaults: $vaults, items: $items, organizations: $organizations, favouriteIds: $favouriteIds, tagRegistry: $tagRegistry, exportHistory: $exportHistory, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class $VaultSnapshotCopyWith<$Res>  {
  factory $VaultSnapshotCopyWith(VaultSnapshot value, $Res Function(VaultSnapshot) _then) = _$VaultSnapshotCopyWithImpl;
@useResult
$Res call({
@JsonKey(toJson: _vaultsToJson) List<Vault> vaults,@JsonKey(toJson: _itemsToJson) List<VaultItem> items,@JsonKey(toJson: _organizationsToJson) List<Organization> organizations, List<String> favouriteIds,@JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson) List<TagRegistryEntry> tagRegistry,@JsonKey(toJson: _exportsToJson) List<ExportRecord> exportHistory,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class _$VaultSnapshotCopyWithImpl<$Res>
    implements $VaultSnapshotCopyWith<$Res> {
  _$VaultSnapshotCopyWithImpl(this._self, this._then);

  final VaultSnapshot _self;
  final $Res Function(VaultSnapshot) _then;

/// Create a copy of VaultSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vaults = null,Object? items = null,Object? organizations = null,Object? favouriteIds = null,Object? tagRegistry = null,Object? exportHistory = null,Object? unknown = null,}) {
  return _then(_self.copyWith(
vaults: null == vaults ? _self.vaults : vaults // ignore: cast_nullable_to_non_nullable
as List<Vault>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<VaultItem>,organizations: null == organizations ? _self.organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<Organization>,favouriteIds: null == favouriteIds ? _self.favouriteIds : favouriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,tagRegistry: null == tagRegistry ? _self.tagRegistry : tagRegistry // ignore: cast_nullable_to_non_nullable
as List<TagRegistryEntry>,exportHistory: null == exportHistory ? _self.exportHistory : exportHistory // ignore: cast_nullable_to_non_nullable
as List<ExportRecord>,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [VaultSnapshot].
extension VaultSnapshotPatterns on VaultSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaultSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaultSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaultSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _VaultSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaultSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _VaultSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(toJson: _vaultsToJson)  List<Vault> vaults, @JsonKey(toJson: _itemsToJson)  List<VaultItem> items, @JsonKey(toJson: _organizationsToJson)  List<Organization> organizations,  List<String> favouriteIds, @JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson)  List<TagRegistryEntry> tagRegistry, @JsonKey(toJson: _exportsToJson)  List<ExportRecord> exportHistory, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaultSnapshot() when $default != null:
return $default(_that.vaults,_that.items,_that.organizations,_that.favouriteIds,_that.tagRegistry,_that.exportHistory,_that.unknown);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(toJson: _vaultsToJson)  List<Vault> vaults, @JsonKey(toJson: _itemsToJson)  List<VaultItem> items, @JsonKey(toJson: _organizationsToJson)  List<Organization> organizations,  List<String> favouriteIds, @JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson)  List<TagRegistryEntry> tagRegistry, @JsonKey(toJson: _exportsToJson)  List<ExportRecord> exportHistory, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)  $default,) {final _that = this;
switch (_that) {
case _VaultSnapshot():
return $default(_that.vaults,_that.items,_that.organizations,_that.favouriteIds,_that.tagRegistry,_that.exportHistory,_that.unknown);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(toJson: _vaultsToJson)  List<Vault> vaults, @JsonKey(toJson: _itemsToJson)  List<VaultItem> items, @JsonKey(toJson: _organizationsToJson)  List<Organization> organizations,  List<String> favouriteIds, @JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson)  List<TagRegistryEntry> tagRegistry, @JsonKey(toJson: _exportsToJson)  List<ExportRecord> exportHistory, @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false)  Map<String, Object?> unknown)?  $default,) {final _that = this;
switch (_that) {
case _VaultSnapshot() when $default != null:
return $default(_that.vaults,_that.items,_that.organizations,_that.favouriteIds,_that.tagRegistry,_that.exportHistory,_that.unknown);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false, createFieldMap: true)
class _VaultSnapshot extends VaultSnapshot {
  const _VaultSnapshot({@JsonKey(toJson: _vaultsToJson) final  List<Vault> vaults = const <Vault>[], @JsonKey(toJson: _itemsToJson) final  List<VaultItem> items = const <VaultItem>[], @JsonKey(toJson: _organizationsToJson) final  List<Organization> organizations = const <Organization>[], final  List<String> favouriteIds = const <String>[], @JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson) final  List<TagRegistryEntry> tagRegistry = const <TagRegistryEntry>[], @JsonKey(toJson: _exportsToJson) final  List<ExportRecord> exportHistory = const <ExportRecord>[], @JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) final  Map<String, Object?> unknown = const <String, Object?>{}}): _vaults = vaults,_items = items,_organizations = organizations,_favouriteIds = favouriteIds,_tagRegistry = tagRegistry,_exportHistory = exportHistory,_unknown = unknown,super._();
  factory _VaultSnapshot.fromJson(Map<String, dynamic> json) => _$VaultSnapshotFromJson(json);

 final  List<Vault> _vaults;
@override@JsonKey(toJson: _vaultsToJson) List<Vault> get vaults {
  if (_vaults is EqualUnmodifiableListView) return _vaults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vaults);
}

 final  List<VaultItem> _items;
@override@JsonKey(toJson: _itemsToJson) List<VaultItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<Organization> _organizations;
@override@JsonKey(toJson: _organizationsToJson) List<Organization> get organizations {
  if (_organizations is EqualUnmodifiableListView) return _organizations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_organizations);
}

 final  List<String> _favouriteIds;
@override@JsonKey() List<String> get favouriteIds {
  if (_favouriteIds is EqualUnmodifiableListView) return _favouriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favouriteIds);
}

/// Tags known even with no items; older vaults omit it.
 final  List<TagRegistryEntry> _tagRegistry;
/// Tags known even with no items; older vaults omit it.
@override@JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson) List<TagRegistryEntry> get tagRegistry {
  if (_tagRegistry is EqualUnmodifiableListView) return _tagRegistry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagRegistry);
}

/// The last exports, newest first, at most [kExportHistoryLimit]; older
/// vaults omit it.
 final  List<ExportRecord> _exportHistory;
/// The last exports, newest first, at most [kExportHistoryLimit]; older
/// vaults omit it.
@override@JsonKey(toJson: _exportsToJson) List<ExportRecord> get exportHistory {
  if (_exportHistory is EqualUnmodifiableListView) return _exportHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exportHistory);
}

 final  Map<String, Object?> _unknown;
@override@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> get unknown {
  if (_unknown is EqualUnmodifiableMapView) return _unknown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_unknown);
}


/// Create a copy of VaultSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaultSnapshotCopyWith<_VaultSnapshot> get copyWith => __$VaultSnapshotCopyWithImpl<_VaultSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaultSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaultSnapshot&&const DeepCollectionEquality().equals(other._vaults, _vaults)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._organizations, _organizations)&&const DeepCollectionEquality().equals(other._favouriteIds, _favouriteIds)&&const DeepCollectionEquality().equals(other._tagRegistry, _tagRegistry)&&const DeepCollectionEquality().equals(other._exportHistory, _exportHistory)&&const DeepCollectionEquality().equals(other._unknown, _unknown));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vaults),const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_organizations),const DeepCollectionEquality().hash(_favouriteIds),const DeepCollectionEquality().hash(_tagRegistry),const DeepCollectionEquality().hash(_exportHistory),const DeepCollectionEquality().hash(_unknown));

@override
String toString() {
  return 'VaultSnapshot(vaults: $vaults, items: $items, organizations: $organizations, favouriteIds: $favouriteIds, tagRegistry: $tagRegistry, exportHistory: $exportHistory, unknown: $unknown)';
}


}

/// @nodoc
abstract mixin class _$VaultSnapshotCopyWith<$Res> implements $VaultSnapshotCopyWith<$Res> {
  factory _$VaultSnapshotCopyWith(_VaultSnapshot value, $Res Function(_VaultSnapshot) _then) = __$VaultSnapshotCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(toJson: _vaultsToJson) List<Vault> vaults,@JsonKey(toJson: _itemsToJson) List<VaultItem> items,@JsonKey(toJson: _organizationsToJson) List<Organization> organizations, List<String> favouriteIds,@JsonKey(fromJson: _tagRegistryFromJson, toJson: _tagRegistryToJson) List<TagRegistryEntry> tagRegistry,@JsonKey(toJson: _exportsToJson) List<ExportRecord> exportHistory,@JsonKey(name: kUnknownJsonKey, includeFromJson: false, includeToJson: false) Map<String, Object?> unknown
});




}
/// @nodoc
class __$VaultSnapshotCopyWithImpl<$Res>
    implements _$VaultSnapshotCopyWith<$Res> {
  __$VaultSnapshotCopyWithImpl(this._self, this._then);

  final _VaultSnapshot _self;
  final $Res Function(_VaultSnapshot) _then;

/// Create a copy of VaultSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vaults = null,Object? items = null,Object? organizations = null,Object? favouriteIds = null,Object? tagRegistry = null,Object? exportHistory = null,Object? unknown = null,}) {
  return _then(_VaultSnapshot(
vaults: null == vaults ? _self._vaults : vaults // ignore: cast_nullable_to_non_nullable
as List<Vault>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<VaultItem>,organizations: null == organizations ? _self._organizations : organizations // ignore: cast_nullable_to_non_nullable
as List<Organization>,favouriteIds: null == favouriteIds ? _self._favouriteIds : favouriteIds // ignore: cast_nullable_to_non_nullable
as List<String>,tagRegistry: null == tagRegistry ? _self._tagRegistry : tagRegistry // ignore: cast_nullable_to_non_nullable
as List<TagRegistryEntry>,exportHistory: null == exportHistory ? _self._exportHistory : exportHistory // ignore: cast_nullable_to_non_nullable
as List<ExportRecord>,unknown: null == unknown ? _self._unknown : unknown // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}

// dart format on
