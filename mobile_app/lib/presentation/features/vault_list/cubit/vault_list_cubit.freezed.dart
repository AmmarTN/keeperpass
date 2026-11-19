// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vault_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VaultListState {

 CubitStatus get status; VaultScope get scope;/// The vault shown when [scope] is [VaultScope.vault].
 String? get vaultId;/// The tag chip that is on.
 String? get tag;/// A security filter from the Security tab ("Weak passwords").
 AuditType? get report;/// The search field replaces the header.
 bool get searching; String get search; ItemSort get sort;/// Selection mode: the tab bar gives way to Move and Delete.
 bool get selecting; Set<String> get selected;/// "Reading your vault from Google Drive…".
 bool get refreshing; VaultListView get view;
/// Create a copy of VaultListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaultListStateCopyWith<VaultListState> get copyWith => _$VaultListStateCopyWithImpl<VaultListState>(this as VaultListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultListState&&(identical(other.status, status) || other.status == status)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.report, report) || other.report == report)&&(identical(other.searching, searching) || other.searching == searching)&&(identical(other.search, search) || other.search == search)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.selecting, selecting) || other.selecting == selecting)&&const DeepCollectionEquality().equals(other.selected, selected)&&(identical(other.refreshing, refreshing) || other.refreshing == refreshing)&&(identical(other.view, view) || other.view == view));
}


@override
int get hashCode => Object.hash(runtimeType,status,scope,vaultId,tag,report,searching,search,sort,selecting,const DeepCollectionEquality().hash(selected),refreshing,view);

@override
String toString() {
  return 'VaultListState(status: $status, scope: $scope, vaultId: $vaultId, tag: $tag, report: $report, searching: $searching, search: $search, sort: $sort, selecting: $selecting, selected: $selected, refreshing: $refreshing, view: $view)';
}


}

/// @nodoc
abstract mixin class $VaultListStateCopyWith<$Res>  {
  factory $VaultListStateCopyWith(VaultListState value, $Res Function(VaultListState) _then) = _$VaultListStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, VaultScope scope, String? vaultId, String? tag, AuditType? report, bool searching, String search, ItemSort sort, bool selecting, Set<String> selected, bool refreshing, VaultListView view
});




}
/// @nodoc
class _$VaultListStateCopyWithImpl<$Res>
    implements $VaultListStateCopyWith<$Res> {
  _$VaultListStateCopyWithImpl(this._self, this._then);

  final VaultListState _self;
  final $Res Function(VaultListState) _then;

/// Create a copy of VaultListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? scope = null,Object? vaultId = freezed,Object? tag = freezed,Object? report = freezed,Object? searching = null,Object? search = null,Object? sort = null,Object? selecting = null,Object? selected = null,Object? refreshing = null,Object? view = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as VaultScope,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as AuditType?,searching: null == searching ? _self.searching : searching // ignore: cast_nullable_to_non_nullable
as bool,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ItemSort,selecting: null == selecting ? _self.selecting : selecting // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,refreshing: null == refreshing ? _self.refreshing : refreshing // ignore: cast_nullable_to_non_nullable
as bool,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as VaultListView,
  ));
}

}


/// Adds pattern-matching-related methods to [VaultListState].
extension VaultListStatePatterns on VaultListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaultListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaultListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaultListState value)  $default,){
final _that = this;
switch (_that) {
case _VaultListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaultListState value)?  $default,){
final _that = this;
switch (_that) {
case _VaultListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  VaultScope scope,  String? vaultId,  String? tag,  AuditType? report,  bool searching,  String search,  ItemSort sort,  bool selecting,  Set<String> selected,  bool refreshing,  VaultListView view)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaultListState() when $default != null:
return $default(_that.status,_that.scope,_that.vaultId,_that.tag,_that.report,_that.searching,_that.search,_that.sort,_that.selecting,_that.selected,_that.refreshing,_that.view);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  VaultScope scope,  String? vaultId,  String? tag,  AuditType? report,  bool searching,  String search,  ItemSort sort,  bool selecting,  Set<String> selected,  bool refreshing,  VaultListView view)  $default,) {final _that = this;
switch (_that) {
case _VaultListState():
return $default(_that.status,_that.scope,_that.vaultId,_that.tag,_that.report,_that.searching,_that.search,_that.sort,_that.selecting,_that.selected,_that.refreshing,_that.view);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  VaultScope scope,  String? vaultId,  String? tag,  AuditType? report,  bool searching,  String search,  ItemSort sort,  bool selecting,  Set<String> selected,  bool refreshing,  VaultListView view)?  $default,) {final _that = this;
switch (_that) {
case _VaultListState() when $default != null:
return $default(_that.status,_that.scope,_that.vaultId,_that.tag,_that.report,_that.searching,_that.search,_that.sort,_that.selecting,_that.selected,_that.refreshing,_that.view);case _:
  return null;

}
}

}

/// @nodoc


class _VaultListState extends VaultListState {
  const _VaultListState({this.status = const CubitStatus(), this.scope = VaultScope.all, this.vaultId, this.tag, this.report, this.searching = false, this.search = '', this.sort = ItemSort.newestFirst, this.selecting = false, final  Set<String> selected = const <String>{}, this.refreshing = false, this.view = const VaultListView()}): _selected = selected,super._();
  

@override@JsonKey() final  CubitStatus status;
@override@JsonKey() final  VaultScope scope;
/// The vault shown when [scope] is [VaultScope.vault].
@override final  String? vaultId;
/// The tag chip that is on.
@override final  String? tag;
/// A security filter from the Security tab ("Weak passwords").
@override final  AuditType? report;
/// The search field replaces the header.
@override@JsonKey() final  bool searching;
@override@JsonKey() final  String search;
@override@JsonKey() final  ItemSort sort;
/// Selection mode: the tab bar gives way to Move and Delete.
@override@JsonKey() final  bool selecting;
 final  Set<String> _selected;
@override@JsonKey() Set<String> get selected {
  if (_selected is EqualUnmodifiableSetView) return _selected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selected);
}

/// "Reading your vault from Google Drive…".
@override@JsonKey() final  bool refreshing;
@override@JsonKey() final  VaultListView view;

/// Create a copy of VaultListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaultListStateCopyWith<_VaultListState> get copyWith => __$VaultListStateCopyWithImpl<_VaultListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaultListState&&(identical(other.status, status) || other.status == status)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.report, report) || other.report == report)&&(identical(other.searching, searching) || other.searching == searching)&&(identical(other.search, search) || other.search == search)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.selecting, selecting) || other.selecting == selecting)&&const DeepCollectionEquality().equals(other._selected, _selected)&&(identical(other.refreshing, refreshing) || other.refreshing == refreshing)&&(identical(other.view, view) || other.view == view));
}


@override
int get hashCode => Object.hash(runtimeType,status,scope,vaultId,tag,report,searching,search,sort,selecting,const DeepCollectionEquality().hash(_selected),refreshing,view);

@override
String toString() {
  return 'VaultListState(status: $status, scope: $scope, vaultId: $vaultId, tag: $tag, report: $report, searching: $searching, search: $search, sort: $sort, selecting: $selecting, selected: $selected, refreshing: $refreshing, view: $view)';
}


}

/// @nodoc
abstract mixin class _$VaultListStateCopyWith<$Res> implements $VaultListStateCopyWith<$Res> {
  factory _$VaultListStateCopyWith(_VaultListState value, $Res Function(_VaultListState) _then) = __$VaultListStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, VaultScope scope, String? vaultId, String? tag, AuditType? report, bool searching, String search, ItemSort sort, bool selecting, Set<String> selected, bool refreshing, VaultListView view
});




}
/// @nodoc
class __$VaultListStateCopyWithImpl<$Res>
    implements _$VaultListStateCopyWith<$Res> {
  __$VaultListStateCopyWithImpl(this._self, this._then);

  final _VaultListState _self;
  final $Res Function(_VaultListState) _then;

/// Create a copy of VaultListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? scope = null,Object? vaultId = freezed,Object? tag = freezed,Object? report = freezed,Object? searching = null,Object? search = null,Object? sort = null,Object? selecting = null,Object? selected = null,Object? refreshing = null,Object? view = null,}) {
  return _then(_VaultListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as VaultScope,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as String?,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as AuditType?,searching: null == searching ? _self.searching : searching // ignore: cast_nullable_to_non_nullable
as bool,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ItemSort,selecting: null == selecting ? _self.selecting : selecting // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self._selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,refreshing: null == refreshing ? _self.refreshing : refreshing // ignore: cast_nullable_to_non_nullable
as bool,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as VaultListView,
  ));
}


}

// dart format on
