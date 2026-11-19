// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 ClipboardClearDelay get clipboardDelay; bool get hideInSwitcher;/// Android only; while hiding is on, screenshots are blocked anyway.
 bool get blockScreenshots;/// Where the vault could move: configured here, not the one in use.
 List<ProviderId> get moveTargets;/// Exports remembered in the vault (newest first, at most 10).
 List<ExportRecord> get exports;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.clipboardDelay, clipboardDelay) || other.clipboardDelay == clipboardDelay)&&(identical(other.hideInSwitcher, hideInSwitcher) || other.hideInSwitcher == hideInSwitcher)&&(identical(other.blockScreenshots, blockScreenshots) || other.blockScreenshots == blockScreenshots)&&const DeepCollectionEquality().equals(other.moveTargets, moveTargets)&&const DeepCollectionEquality().equals(other.exports, exports));
}


@override
int get hashCode => Object.hash(runtimeType,clipboardDelay,hideInSwitcher,blockScreenshots,const DeepCollectionEquality().hash(moveTargets),const DeepCollectionEquality().hash(exports));

@override
String toString() {
  return 'SettingsState(clipboardDelay: $clipboardDelay, hideInSwitcher: $hideInSwitcher, blockScreenshots: $blockScreenshots, moveTargets: $moveTargets, exports: $exports)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 ClipboardClearDelay clipboardDelay, bool hideInSwitcher, bool blockScreenshots, List<ProviderId> moveTargets, List<ExportRecord> exports
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clipboardDelay = null,Object? hideInSwitcher = null,Object? blockScreenshots = null,Object? moveTargets = null,Object? exports = null,}) {
  return _then(_self.copyWith(
clipboardDelay: null == clipboardDelay ? _self.clipboardDelay : clipboardDelay // ignore: cast_nullable_to_non_nullable
as ClipboardClearDelay,hideInSwitcher: null == hideInSwitcher ? _self.hideInSwitcher : hideInSwitcher // ignore: cast_nullable_to_non_nullable
as bool,blockScreenshots: null == blockScreenshots ? _self.blockScreenshots : blockScreenshots // ignore: cast_nullable_to_non_nullable
as bool,moveTargets: null == moveTargets ? _self.moveTargets : moveTargets // ignore: cast_nullable_to_non_nullable
as List<ProviderId>,exports: null == exports ? _self.exports : exports // ignore: cast_nullable_to_non_nullable
as List<ExportRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ClipboardClearDelay clipboardDelay,  bool hideInSwitcher,  bool blockScreenshots,  List<ProviderId> moveTargets,  List<ExportRecord> exports)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.clipboardDelay,_that.hideInSwitcher,_that.blockScreenshots,_that.moveTargets,_that.exports);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ClipboardClearDelay clipboardDelay,  bool hideInSwitcher,  bool blockScreenshots,  List<ProviderId> moveTargets,  List<ExportRecord> exports)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.clipboardDelay,_that.hideInSwitcher,_that.blockScreenshots,_that.moveTargets,_that.exports);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ClipboardClearDelay clipboardDelay,  bool hideInSwitcher,  bool blockScreenshots,  List<ProviderId> moveTargets,  List<ExportRecord> exports)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.clipboardDelay,_that.hideInSwitcher,_that.blockScreenshots,_that.moveTargets,_that.exports);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.clipboardDelay = ClipboardClearDelay.standard, this.hideInSwitcher = true, this.blockScreenshots = true, final  List<ProviderId> moveTargets = const <ProviderId>[], final  List<ExportRecord> exports = const <ExportRecord>[]}): _moveTargets = moveTargets,_exports = exports;
  

@override@JsonKey() final  ClipboardClearDelay clipboardDelay;
@override@JsonKey() final  bool hideInSwitcher;
/// Android only; while hiding is on, screenshots are blocked anyway.
@override@JsonKey() final  bool blockScreenshots;
/// Where the vault could move: configured here, not the one in use.
 final  List<ProviderId> _moveTargets;
/// Where the vault could move: configured here, not the one in use.
@override@JsonKey() List<ProviderId> get moveTargets {
  if (_moveTargets is EqualUnmodifiableListView) return _moveTargets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moveTargets);
}

/// Exports remembered in the vault (newest first, at most 10).
 final  List<ExportRecord> _exports;
/// Exports remembered in the vault (newest first, at most 10).
@override@JsonKey() List<ExportRecord> get exports {
  if (_exports is EqualUnmodifiableListView) return _exports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exports);
}


/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.clipboardDelay, clipboardDelay) || other.clipboardDelay == clipboardDelay)&&(identical(other.hideInSwitcher, hideInSwitcher) || other.hideInSwitcher == hideInSwitcher)&&(identical(other.blockScreenshots, blockScreenshots) || other.blockScreenshots == blockScreenshots)&&const DeepCollectionEquality().equals(other._moveTargets, _moveTargets)&&const DeepCollectionEquality().equals(other._exports, _exports));
}


@override
int get hashCode => Object.hash(runtimeType,clipboardDelay,hideInSwitcher,blockScreenshots,const DeepCollectionEquality().hash(_moveTargets),const DeepCollectionEquality().hash(_exports));

@override
String toString() {
  return 'SettingsState(clipboardDelay: $clipboardDelay, hideInSwitcher: $hideInSwitcher, blockScreenshots: $blockScreenshots, moveTargets: $moveTargets, exports: $exports)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 ClipboardClearDelay clipboardDelay, bool hideInSwitcher, bool blockScreenshots, List<ProviderId> moveTargets, List<ExportRecord> exports
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clipboardDelay = null,Object? hideInSwitcher = null,Object? blockScreenshots = null,Object? moveTargets = null,Object? exports = null,}) {
  return _then(_SettingsState(
clipboardDelay: null == clipboardDelay ? _self.clipboardDelay : clipboardDelay // ignore: cast_nullable_to_non_nullable
as ClipboardClearDelay,hideInSwitcher: null == hideInSwitcher ? _self.hideInSwitcher : hideInSwitcher // ignore: cast_nullable_to_non_nullable
as bool,blockScreenshots: null == blockScreenshots ? _self.blockScreenshots : blockScreenshots // ignore: cast_nullable_to_non_nullable
as bool,moveTargets: null == moveTargets ? _self._moveTargets : moveTargets // ignore: cast_nullable_to_non_nullable
as List<ProviderId>,exports: null == exports ? _self._exports : exports // ignore: cast_nullable_to_non_nullable
as List<ExportRecord>,
  ));
}


}

// dart format on
