// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ItemDetailState implements DiagnosticableTreeMixin {

 CubitStatus get status; String get itemId;/// The item as its row in the list would draw it (tile, vault, favorite);
/// null before [ItemDetailCubit.open] and once the item is gone.
 VaultRow? get row;/// The item vanished (deleted on another device, or by a reload): the
/// "This item no longer exists." screen (board `S3-28`).
 bool get gone;/// Fields whose secret is shown, by position (web: per field, masked
/// again on leaving).
 Set<int> get revealed;/// "4 minutes ago" — loaded once from the bundled tables.
 RelativeTimeFormatter? get relativeTime;/// Country names by language, for the flag before a country (board
/// `S3-32`).
 Map<String, dynamic> get countryNames;
/// Create a copy of ItemDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemDetailStateCopyWith<ItemDetailState> get copyWith => _$ItemDetailStateCopyWithImpl<ItemDetailState>(this as ItemDetailState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ItemDetailState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('itemId', itemId))..add(DiagnosticsProperty('row', row))..add(DiagnosticsProperty('gone', gone))..add(DiagnosticsProperty('revealed', revealed))..add(DiagnosticsProperty('relativeTime', relativeTime))..add(DiagnosticsProperty('countryNames', countryNames));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.row, row) || other.row == row)&&(identical(other.gone, gone) || other.gone == gone)&&const DeepCollectionEquality().equals(other.revealed, revealed)&&(identical(other.relativeTime, relativeTime) || other.relativeTime == relativeTime)&&const DeepCollectionEquality().equals(other.countryNames, countryNames));
}


@override
int get hashCode => Object.hash(runtimeType,status,itemId,row,gone,const DeepCollectionEquality().hash(revealed),relativeTime,const DeepCollectionEquality().hash(countryNames));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ItemDetailState(status: $status, itemId: $itemId, row: $row, gone: $gone, revealed: $revealed, relativeTime: $relativeTime, countryNames: $countryNames)';
}


}

/// @nodoc
abstract mixin class $ItemDetailStateCopyWith<$Res>  {
  factory $ItemDetailStateCopyWith(ItemDetailState value, $Res Function(ItemDetailState) _then) = _$ItemDetailStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, String itemId, VaultRow? row, bool gone, Set<int> revealed, RelativeTimeFormatter? relativeTime, Map<String, dynamic> countryNames
});




}
/// @nodoc
class _$ItemDetailStateCopyWithImpl<$Res>
    implements $ItemDetailStateCopyWith<$Res> {
  _$ItemDetailStateCopyWithImpl(this._self, this._then);

  final ItemDetailState _self;
  final $Res Function(ItemDetailState) _then;

/// Create a copy of ItemDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? itemId = null,Object? row = freezed,Object? gone = null,Object? revealed = null,Object? relativeTime = freezed,Object? countryNames = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,row: freezed == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as VaultRow?,gone: null == gone ? _self.gone : gone // ignore: cast_nullable_to_non_nullable
as bool,revealed: null == revealed ? _self.revealed : revealed // ignore: cast_nullable_to_non_nullable
as Set<int>,relativeTime: freezed == relativeTime ? _self.relativeTime : relativeTime // ignore: cast_nullable_to_non_nullable
as RelativeTimeFormatter?,countryNames: null == countryNames ? _self.countryNames : countryNames // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemDetailState].
extension ItemDetailStatePatterns on ItemDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemDetailState value)  $default,){
final _that = this;
switch (_that) {
case _ItemDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _ItemDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  String itemId,  VaultRow? row,  bool gone,  Set<int> revealed,  RelativeTimeFormatter? relativeTime,  Map<String, dynamic> countryNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemDetailState() when $default != null:
return $default(_that.status,_that.itemId,_that.row,_that.gone,_that.revealed,_that.relativeTime,_that.countryNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  String itemId,  VaultRow? row,  bool gone,  Set<int> revealed,  RelativeTimeFormatter? relativeTime,  Map<String, dynamic> countryNames)  $default,) {final _that = this;
switch (_that) {
case _ItemDetailState():
return $default(_that.status,_that.itemId,_that.row,_that.gone,_that.revealed,_that.relativeTime,_that.countryNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  String itemId,  VaultRow? row,  bool gone,  Set<int> revealed,  RelativeTimeFormatter? relativeTime,  Map<String, dynamic> countryNames)?  $default,) {final _that = this;
switch (_that) {
case _ItemDetailState() when $default != null:
return $default(_that.status,_that.itemId,_that.row,_that.gone,_that.revealed,_that.relativeTime,_that.countryNames);case _:
  return null;

}
}

}

/// @nodoc


class _ItemDetailState extends ItemDetailState with DiagnosticableTreeMixin {
  const _ItemDetailState({this.status = const CubitStatus(), this.itemId = '', this.row, this.gone = false, final  Set<int> revealed = const <int>{}, this.relativeTime, final  Map<String, dynamic> countryNames = const <String, dynamic>{}}): _revealed = revealed,_countryNames = countryNames,super._();
  

@override@JsonKey() final  CubitStatus status;
@override@JsonKey() final  String itemId;
/// The item as its row in the list would draw it (tile, vault, favorite);
/// null before [ItemDetailCubit.open] and once the item is gone.
@override final  VaultRow? row;
/// The item vanished (deleted on another device, or by a reload): the
/// "This item no longer exists." screen (board `S3-28`).
@override@JsonKey() final  bool gone;
/// Fields whose secret is shown, by position (web: per field, masked
/// again on leaving).
 final  Set<int> _revealed;
/// Fields whose secret is shown, by position (web: per field, masked
/// again on leaving).
@override@JsonKey() Set<int> get revealed {
  if (_revealed is EqualUnmodifiableSetView) return _revealed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_revealed);
}

/// "4 minutes ago" — loaded once from the bundled tables.
@override final  RelativeTimeFormatter? relativeTime;
/// Country names by language, for the flag before a country (board
/// `S3-32`).
 final  Map<String, dynamic> _countryNames;
/// Country names by language, for the flag before a country (board
/// `S3-32`).
@override@JsonKey() Map<String, dynamic> get countryNames {
  if (_countryNames is EqualUnmodifiableMapView) return _countryNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_countryNames);
}


/// Create a copy of ItemDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemDetailStateCopyWith<_ItemDetailState> get copyWith => __$ItemDetailStateCopyWithImpl<_ItemDetailState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ItemDetailState'))
    ..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('itemId', itemId))..add(DiagnosticsProperty('row', row))..add(DiagnosticsProperty('gone', gone))..add(DiagnosticsProperty('revealed', revealed))..add(DiagnosticsProperty('relativeTime', relativeTime))..add(DiagnosticsProperty('countryNames', countryNames));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.row, row) || other.row == row)&&(identical(other.gone, gone) || other.gone == gone)&&const DeepCollectionEquality().equals(other._revealed, _revealed)&&(identical(other.relativeTime, relativeTime) || other.relativeTime == relativeTime)&&const DeepCollectionEquality().equals(other._countryNames, _countryNames));
}


@override
int get hashCode => Object.hash(runtimeType,status,itemId,row,gone,const DeepCollectionEquality().hash(_revealed),relativeTime,const DeepCollectionEquality().hash(_countryNames));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ItemDetailState(status: $status, itemId: $itemId, row: $row, gone: $gone, revealed: $revealed, relativeTime: $relativeTime, countryNames: $countryNames)';
}


}

/// @nodoc
abstract mixin class _$ItemDetailStateCopyWith<$Res> implements $ItemDetailStateCopyWith<$Res> {
  factory _$ItemDetailStateCopyWith(_ItemDetailState value, $Res Function(_ItemDetailState) _then) = __$ItemDetailStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, String itemId, VaultRow? row, bool gone, Set<int> revealed, RelativeTimeFormatter? relativeTime, Map<String, dynamic> countryNames
});




}
/// @nodoc
class __$ItemDetailStateCopyWithImpl<$Res>
    implements _$ItemDetailStateCopyWith<$Res> {
  __$ItemDetailStateCopyWithImpl(this._self, this._then);

  final _ItemDetailState _self;
  final $Res Function(_ItemDetailState) _then;

/// Create a copy of ItemDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? itemId = null,Object? row = freezed,Object? gone = null,Object? revealed = null,Object? relativeTime = freezed,Object? countryNames = null,}) {
  return _then(_ItemDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,row: freezed == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as VaultRow?,gone: null == gone ? _self.gone : gone // ignore: cast_nullable_to_non_nullable
as bool,revealed: null == revealed ? _self._revealed : revealed // ignore: cast_nullable_to_non_nullable
as Set<int>,relativeTime: freezed == relativeTime ? _self.relativeTime : relativeTime // ignore: cast_nullable_to_non_nullable
as RelativeTimeFormatter?,countryNames: null == countryNames ? _self._countryNames : countryNames // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
