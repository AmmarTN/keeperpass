// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_nav_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BottomNavState {

 int get selectedIndex; List<int> get history; int get reselectionSerial;/// Asks the shell to show [rootTab] at its first screen; bumped by
/// [BottomNavCubit.openTabRoot].
 int get rootSerial; int get rootTab;/// Selection mode swaps the tab bar for its counted actions (board C4
/// "Selection").
 bool get barHidden;
/// Create a copy of BottomNavState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BottomNavStateCopyWith<BottomNavState> get copyWith => _$BottomNavStateCopyWithImpl<BottomNavState>(this as BottomNavState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BottomNavState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.reselectionSerial, reselectionSerial) || other.reselectionSerial == reselectionSerial)&&(identical(other.rootSerial, rootSerial) || other.rootSerial == rootSerial)&&(identical(other.rootTab, rootTab) || other.rootTab == rootTab)&&(identical(other.barHidden, barHidden) || other.barHidden == barHidden));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,const DeepCollectionEquality().hash(history),reselectionSerial,rootSerial,rootTab,barHidden);

@override
String toString() {
  return 'BottomNavState(selectedIndex: $selectedIndex, history: $history, reselectionSerial: $reselectionSerial, rootSerial: $rootSerial, rootTab: $rootTab, barHidden: $barHidden)';
}


}

/// @nodoc
abstract mixin class $BottomNavStateCopyWith<$Res>  {
  factory $BottomNavStateCopyWith(BottomNavState value, $Res Function(BottomNavState) _then) = _$BottomNavStateCopyWithImpl;
@useResult
$Res call({
 int selectedIndex, List<int> history, int reselectionSerial, int rootSerial, int rootTab, bool barHidden
});




}
/// @nodoc
class _$BottomNavStateCopyWithImpl<$Res>
    implements $BottomNavStateCopyWith<$Res> {
  _$BottomNavStateCopyWithImpl(this._self, this._then);

  final BottomNavState _self;
  final $Res Function(BottomNavState) _then;

/// Create a copy of BottomNavState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndex = null,Object? history = null,Object? reselectionSerial = null,Object? rootSerial = null,Object? rootTab = null,Object? barHidden = null,}) {
  return _then(_self.copyWith(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<int>,reselectionSerial: null == reselectionSerial ? _self.reselectionSerial : reselectionSerial // ignore: cast_nullable_to_non_nullable
as int,rootSerial: null == rootSerial ? _self.rootSerial : rootSerial // ignore: cast_nullable_to_non_nullable
as int,rootTab: null == rootTab ? _self.rootTab : rootTab // ignore: cast_nullable_to_non_nullable
as int,barHidden: null == barHidden ? _self.barHidden : barHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BottomNavState].
extension BottomNavStatePatterns on BottomNavState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BottomNavState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BottomNavState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BottomNavState value)  $default,){
final _that = this;
switch (_that) {
case _BottomNavState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BottomNavState value)?  $default,){
final _that = this;
switch (_that) {
case _BottomNavState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int selectedIndex,  List<int> history,  int reselectionSerial,  int rootSerial,  int rootTab,  bool barHidden)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BottomNavState() when $default != null:
return $default(_that.selectedIndex,_that.history,_that.reselectionSerial,_that.rootSerial,_that.rootTab,_that.barHidden);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int selectedIndex,  List<int> history,  int reselectionSerial,  int rootSerial,  int rootTab,  bool barHidden)  $default,) {final _that = this;
switch (_that) {
case _BottomNavState():
return $default(_that.selectedIndex,_that.history,_that.reselectionSerial,_that.rootSerial,_that.rootTab,_that.barHidden);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int selectedIndex,  List<int> history,  int reselectionSerial,  int rootSerial,  int rootTab,  bool barHidden)?  $default,) {final _that = this;
switch (_that) {
case _BottomNavState() when $default != null:
return $default(_that.selectedIndex,_that.history,_that.reselectionSerial,_that.rootSerial,_that.rootTab,_that.barHidden);case _:
  return null;

}
}

}

/// @nodoc


class _BottomNavState implements BottomNavState {
  const _BottomNavState({this.selectedIndex = 0, final  List<int> history = const <int>[0], this.reselectionSerial = 0, this.rootSerial = 0, this.rootTab = 0, this.barHidden = false}): _history = history;
  

@override@JsonKey() final  int selectedIndex;
 final  List<int> _history;
@override@JsonKey() List<int> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  int reselectionSerial;
/// Asks the shell to show [rootTab] at its first screen; bumped by
/// [BottomNavCubit.openTabRoot].
@override@JsonKey() final  int rootSerial;
@override@JsonKey() final  int rootTab;
/// Selection mode swaps the tab bar for its counted actions (board C4
/// "Selection").
@override@JsonKey() final  bool barHidden;

/// Create a copy of BottomNavState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BottomNavStateCopyWith<_BottomNavState> get copyWith => __$BottomNavStateCopyWithImpl<_BottomNavState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BottomNavState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.reselectionSerial, reselectionSerial) || other.reselectionSerial == reselectionSerial)&&(identical(other.rootSerial, rootSerial) || other.rootSerial == rootSerial)&&(identical(other.rootTab, rootTab) || other.rootTab == rootTab)&&(identical(other.barHidden, barHidden) || other.barHidden == barHidden));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex,const DeepCollectionEquality().hash(_history),reselectionSerial,rootSerial,rootTab,barHidden);

@override
String toString() {
  return 'BottomNavState(selectedIndex: $selectedIndex, history: $history, reselectionSerial: $reselectionSerial, rootSerial: $rootSerial, rootTab: $rootTab, barHidden: $barHidden)';
}


}

/// @nodoc
abstract mixin class _$BottomNavStateCopyWith<$Res> implements $BottomNavStateCopyWith<$Res> {
  factory _$BottomNavStateCopyWith(_BottomNavState value, $Res Function(_BottomNavState) _then) = __$BottomNavStateCopyWithImpl;
@override @useResult
$Res call({
 int selectedIndex, List<int> history, int reselectionSerial, int rootSerial, int rootTab, bool barHidden
});




}
/// @nodoc
class __$BottomNavStateCopyWithImpl<$Res>
    implements _$BottomNavStateCopyWith<$Res> {
  __$BottomNavStateCopyWithImpl(this._self, this._then);

  final _BottomNavState _self;
  final $Res Function(_BottomNavState) _then;

/// Create a copy of BottomNavState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndex = null,Object? history = null,Object? reselectionSerial = null,Object? rootSerial = null,Object? rootTab = null,Object? barHidden = null,}) {
  return _then(_BottomNavState(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<int>,reselectionSerial: null == reselectionSerial ? _self.reselectionSerial : reselectionSerial // ignore: cast_nullable_to_non_nullable
as int,rootSerial: null == rootSerial ? _self.rootSerial : rootSerial // ignore: cast_nullable_to_non_nullable
as int,rootTab: null == rootTab ? _self.rootTab : rootTab // ignore: cast_nullable_to_non_nullable
as int,barHidden: null == barHidden ? _self.barHidden : barHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
