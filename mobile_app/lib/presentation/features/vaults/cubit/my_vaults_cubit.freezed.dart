// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_vaults_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyVaultsState {

/// Your own vaults (web `ownVaults`), the default one first.
 List<VaultEntry> get vaults;/// Every vault, shared ones too: a new vault's name must be new among
/// them (web `CreateVaultDialog`).
 List<Vault> get allVaults; bool get selecting; Set<String> get selected;
/// Create a copy of MyVaultsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyVaultsStateCopyWith<MyVaultsState> get copyWith => _$MyVaultsStateCopyWithImpl<MyVaultsState>(this as MyVaultsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyVaultsState&&const DeepCollectionEquality().equals(other.vaults, vaults)&&const DeepCollectionEquality().equals(other.allVaults, allVaults)&&(identical(other.selecting, selecting) || other.selecting == selecting)&&const DeepCollectionEquality().equals(other.selected, selected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(vaults),const DeepCollectionEquality().hash(allVaults),selecting,const DeepCollectionEquality().hash(selected));

@override
String toString() {
  return 'MyVaultsState(vaults: $vaults, allVaults: $allVaults, selecting: $selecting, selected: $selected)';
}


}

/// @nodoc
abstract mixin class $MyVaultsStateCopyWith<$Res>  {
  factory $MyVaultsStateCopyWith(MyVaultsState value, $Res Function(MyVaultsState) _then) = _$MyVaultsStateCopyWithImpl;
@useResult
$Res call({
 List<VaultEntry> vaults, List<Vault> allVaults, bool selecting, Set<String> selected
});




}
/// @nodoc
class _$MyVaultsStateCopyWithImpl<$Res>
    implements $MyVaultsStateCopyWith<$Res> {
  _$MyVaultsStateCopyWithImpl(this._self, this._then);

  final MyVaultsState _self;
  final $Res Function(MyVaultsState) _then;

/// Create a copy of MyVaultsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vaults = null,Object? allVaults = null,Object? selecting = null,Object? selected = null,}) {
  return _then(_self.copyWith(
vaults: null == vaults ? _self.vaults : vaults // ignore: cast_nullable_to_non_nullable
as List<VaultEntry>,allVaults: null == allVaults ? _self.allVaults : allVaults // ignore: cast_nullable_to_non_nullable
as List<Vault>,selecting: null == selecting ? _self.selecting : selecting // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MyVaultsState].
extension MyVaultsStatePatterns on MyVaultsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyVaultsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyVaultsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyVaultsState value)  $default,){
final _that = this;
switch (_that) {
case _MyVaultsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyVaultsState value)?  $default,){
final _that = this;
switch (_that) {
case _MyVaultsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VaultEntry> vaults,  List<Vault> allVaults,  bool selecting,  Set<String> selected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyVaultsState() when $default != null:
return $default(_that.vaults,_that.allVaults,_that.selecting,_that.selected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VaultEntry> vaults,  List<Vault> allVaults,  bool selecting,  Set<String> selected)  $default,) {final _that = this;
switch (_that) {
case _MyVaultsState():
return $default(_that.vaults,_that.allVaults,_that.selecting,_that.selected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VaultEntry> vaults,  List<Vault> allVaults,  bool selecting,  Set<String> selected)?  $default,) {final _that = this;
switch (_that) {
case _MyVaultsState() when $default != null:
return $default(_that.vaults,_that.allVaults,_that.selecting,_that.selected);case _:
  return null;

}
}

}

/// @nodoc


class _MyVaultsState extends MyVaultsState {
  const _MyVaultsState({final  List<VaultEntry> vaults = const <VaultEntry>[], final  List<Vault> allVaults = const <Vault>[], this.selecting = false, final  Set<String> selected = const <String>{}}): _vaults = vaults,_allVaults = allVaults,_selected = selected,super._();
  

/// Your own vaults (web `ownVaults`), the default one first.
 final  List<VaultEntry> _vaults;
/// Your own vaults (web `ownVaults`), the default one first.
@override@JsonKey() List<VaultEntry> get vaults {
  if (_vaults is EqualUnmodifiableListView) return _vaults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vaults);
}

/// Every vault, shared ones too: a new vault's name must be new among
/// them (web `CreateVaultDialog`).
 final  List<Vault> _allVaults;
/// Every vault, shared ones too: a new vault's name must be new among
/// them (web `CreateVaultDialog`).
@override@JsonKey() List<Vault> get allVaults {
  if (_allVaults is EqualUnmodifiableListView) return _allVaults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allVaults);
}

@override@JsonKey() final  bool selecting;
 final  Set<String> _selected;
@override@JsonKey() Set<String> get selected {
  if (_selected is EqualUnmodifiableSetView) return _selected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selected);
}


/// Create a copy of MyVaultsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyVaultsStateCopyWith<_MyVaultsState> get copyWith => __$MyVaultsStateCopyWithImpl<_MyVaultsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyVaultsState&&const DeepCollectionEquality().equals(other._vaults, _vaults)&&const DeepCollectionEquality().equals(other._allVaults, _allVaults)&&(identical(other.selecting, selecting) || other.selecting == selecting)&&const DeepCollectionEquality().equals(other._selected, _selected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vaults),const DeepCollectionEquality().hash(_allVaults),selecting,const DeepCollectionEquality().hash(_selected));

@override
String toString() {
  return 'MyVaultsState(vaults: $vaults, allVaults: $allVaults, selecting: $selecting, selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$MyVaultsStateCopyWith<$Res> implements $MyVaultsStateCopyWith<$Res> {
  factory _$MyVaultsStateCopyWith(_MyVaultsState value, $Res Function(_MyVaultsState) _then) = __$MyVaultsStateCopyWithImpl;
@override @useResult
$Res call({
 List<VaultEntry> vaults, List<Vault> allVaults, bool selecting, Set<String> selected
});




}
/// @nodoc
class __$MyVaultsStateCopyWithImpl<$Res>
    implements _$MyVaultsStateCopyWith<$Res> {
  __$MyVaultsStateCopyWithImpl(this._self, this._then);

  final _MyVaultsState _self;
  final $Res Function(_MyVaultsState) _then;

/// Create a copy of MyVaultsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vaults = null,Object? allVaults = null,Object? selecting = null,Object? selected = null,}) {
  return _then(_MyVaultsState(
vaults: null == vaults ? _self._vaults : vaults // ignore: cast_nullable_to_non_nullable
as List<VaultEntry>,allVaults: null == allVaults ? _self._allVaults : allVaults // ignore: cast_nullable_to_non_nullable
as List<Vault>,selecting: null == selecting ? _self.selecting : selecting // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self._selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
