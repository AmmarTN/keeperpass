// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportVault {

 String get id; String get label; int get items;
/// Create a copy of ImportVault
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportVaultCopyWith<ImportVault> get copyWith => _$ImportVaultCopyWithImpl<ImportVault>(this as ImportVault, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportVault&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.items, items) || other.items == items));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,items);

@override
String toString() {
  return 'ImportVault(id: $id, label: $label, items: $items)';
}


}

/// @nodoc
abstract mixin class $ImportVaultCopyWith<$Res>  {
  factory $ImportVaultCopyWith(ImportVault value, $Res Function(ImportVault) _then) = _$ImportVaultCopyWithImpl;
@useResult
$Res call({
 String id, String label, int items
});




}
/// @nodoc
class _$ImportVaultCopyWithImpl<$Res>
    implements $ImportVaultCopyWith<$Res> {
  _$ImportVaultCopyWithImpl(this._self, this._then);

  final ImportVault _self;
  final $Res Function(ImportVault) _then;

/// Create a copy of ImportVault
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportVault].
extension ImportVaultPatterns on ImportVault {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportVault value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportVault() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportVault value)  $default,){
final _that = this;
switch (_that) {
case _ImportVault():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportVault value)?  $default,){
final _that = this;
switch (_that) {
case _ImportVault() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  int items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportVault() when $default != null:
return $default(_that.id,_that.label,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  int items)  $default,) {final _that = this;
switch (_that) {
case _ImportVault():
return $default(_that.id,_that.label,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  int items)?  $default,) {final _that = this;
switch (_that) {
case _ImportVault() when $default != null:
return $default(_that.id,_that.label,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _ImportVault implements ImportVault {
  const _ImportVault({required this.id, required this.label, required this.items});
  

@override final  String id;
@override final  String label;
@override final  int items;

/// Create a copy of ImportVault
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportVaultCopyWith<_ImportVault> get copyWith => __$ImportVaultCopyWithImpl<_ImportVault>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportVault&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.items, items) || other.items == items));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,items);

@override
String toString() {
  return 'ImportVault(id: $id, label: $label, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ImportVaultCopyWith<$Res> implements $ImportVaultCopyWith<$Res> {
  factory _$ImportVaultCopyWith(_ImportVault value, $Res Function(_ImportVault) _then) = __$ImportVaultCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, int items
});




}
/// @nodoc
class __$ImportVaultCopyWithImpl<$Res>
    implements _$ImportVaultCopyWith<$Res> {
  __$ImportVaultCopyWithImpl(this._self, this._then);

  final _ImportVault _self;
  final $Res Function(_ImportVault) _then;

/// Create a copy of ImportVault
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? items = null,}) {
  return _then(_ImportVault(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ImportState {

 String get fileName;/// In bytes, when known.
 int? get size; List<ItemDraft> get drafts; ImportError? get error; List<ImportVault> get vaults; String? get vaultId;
/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportStateCopyWith<ImportState> get copyWith => _$ImportStateCopyWithImpl<ImportState>(this as ImportState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportState&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other.drafts, drafts)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.vaults, vaults)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId));
}


@override
int get hashCode => Object.hash(runtimeType,fileName,size,const DeepCollectionEquality().hash(drafts),error,const DeepCollectionEquality().hash(vaults),vaultId);

@override
String toString() {
  return 'ImportState(fileName: $fileName, size: $size, drafts: $drafts, error: $error, vaults: $vaults, vaultId: $vaultId)';
}


}

/// @nodoc
abstract mixin class $ImportStateCopyWith<$Res>  {
  factory $ImportStateCopyWith(ImportState value, $Res Function(ImportState) _then) = _$ImportStateCopyWithImpl;
@useResult
$Res call({
 String fileName, int? size, List<ItemDraft> drafts, ImportError? error, List<ImportVault> vaults, String? vaultId
});




}
/// @nodoc
class _$ImportStateCopyWithImpl<$Res>
    implements $ImportStateCopyWith<$Res> {
  _$ImportStateCopyWithImpl(this._self, this._then);

  final ImportState _self;
  final $Res Function(ImportState) _then;

/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = null,Object? size = freezed,Object? drafts = null,Object? error = freezed,Object? vaults = null,Object? vaultId = freezed,}) {
  return _then(_self.copyWith(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,drafts: null == drafts ? _self.drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<ItemDraft>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ImportError?,vaults: null == vaults ? _self.vaults : vaults // ignore: cast_nullable_to_non_nullable
as List<ImportVault>,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportState].
extension ImportStatePatterns on ImportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportState value)  $default,){
final _that = this;
switch (_that) {
case _ImportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportState value)?  $default,){
final _that = this;
switch (_that) {
case _ImportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileName,  int? size,  List<ItemDraft> drafts,  ImportError? error,  List<ImportVault> vaults,  String? vaultId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportState() when $default != null:
return $default(_that.fileName,_that.size,_that.drafts,_that.error,_that.vaults,_that.vaultId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileName,  int? size,  List<ItemDraft> drafts,  ImportError? error,  List<ImportVault> vaults,  String? vaultId)  $default,) {final _that = this;
switch (_that) {
case _ImportState():
return $default(_that.fileName,_that.size,_that.drafts,_that.error,_that.vaults,_that.vaultId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileName,  int? size,  List<ItemDraft> drafts,  ImportError? error,  List<ImportVault> vaults,  String? vaultId)?  $default,) {final _that = this;
switch (_that) {
case _ImportState() when $default != null:
return $default(_that.fileName,_that.size,_that.drafts,_that.error,_that.vaults,_that.vaultId);case _:
  return null;

}
}

}

/// @nodoc


class _ImportState extends ImportState {
  const _ImportState({this.fileName = '', this.size, final  List<ItemDraft> drafts = const <ItemDraft>[], this.error, final  List<ImportVault> vaults = const <ImportVault>[], this.vaultId}): _drafts = drafts,_vaults = vaults,super._();
  

@override@JsonKey() final  String fileName;
/// In bytes, when known.
@override final  int? size;
 final  List<ItemDraft> _drafts;
@override@JsonKey() List<ItemDraft> get drafts {
  if (_drafts is EqualUnmodifiableListView) return _drafts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drafts);
}

@override final  ImportError? error;
 final  List<ImportVault> _vaults;
@override@JsonKey() List<ImportVault> get vaults {
  if (_vaults is EqualUnmodifiableListView) return _vaults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vaults);
}

@override final  String? vaultId;

/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportStateCopyWith<_ImportState> get copyWith => __$ImportStateCopyWithImpl<_ImportState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportState&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.size, size) || other.size == size)&&const DeepCollectionEquality().equals(other._drafts, _drafts)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._vaults, _vaults)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId));
}


@override
int get hashCode => Object.hash(runtimeType,fileName,size,const DeepCollectionEquality().hash(_drafts),error,const DeepCollectionEquality().hash(_vaults),vaultId);

@override
String toString() {
  return 'ImportState(fileName: $fileName, size: $size, drafts: $drafts, error: $error, vaults: $vaults, vaultId: $vaultId)';
}


}

/// @nodoc
abstract mixin class _$ImportStateCopyWith<$Res> implements $ImportStateCopyWith<$Res> {
  factory _$ImportStateCopyWith(_ImportState value, $Res Function(_ImportState) _then) = __$ImportStateCopyWithImpl;
@override @useResult
$Res call({
 String fileName, int? size, List<ItemDraft> drafts, ImportError? error, List<ImportVault> vaults, String? vaultId
});




}
/// @nodoc
class __$ImportStateCopyWithImpl<$Res>
    implements _$ImportStateCopyWith<$Res> {
  __$ImportStateCopyWithImpl(this._self, this._then);

  final _ImportState _self;
  final $Res Function(_ImportState) _then;

/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = null,Object? size = freezed,Object? drafts = null,Object? error = freezed,Object? vaults = null,Object? vaultId = freezed,}) {
  return _then(_ImportState(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,drafts: null == drafts ? _self._drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<ItemDraft>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ImportError?,vaults: null == vaults ? _self._vaults : vaults // ignore: cast_nullable_to_non_nullable
as List<ImportVault>,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
