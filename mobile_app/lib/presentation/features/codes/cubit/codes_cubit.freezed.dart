// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'codes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CodesState {

 CubitStatus get status;/// Every item with a setup key, A to Z (board `Codes` 01).
 List<CodeEntry> get entries;/// What is typed in the search field.
 String get search;
/// Create a copy of CodesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodesStateCopyWith<CodesState> get copyWith => _$CodesStateCopyWithImpl<CodesState>(this as CodesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(entries),search);

@override
String toString() {
  return 'CodesState(status: $status, entries: $entries, search: $search)';
}


}

/// @nodoc
abstract mixin class $CodesStateCopyWith<$Res>  {
  factory $CodesStateCopyWith(CodesState value, $Res Function(CodesState) _then) = _$CodesStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, List<CodeEntry> entries, String search
});




}
/// @nodoc
class _$CodesStateCopyWithImpl<$Res>
    implements $CodesStateCopyWith<$Res> {
  _$CodesStateCopyWithImpl(this._self, this._then);

  final CodesState _self;
  final $Res Function(CodesState) _then;

/// Create a copy of CodesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? entries = null,Object? search = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<CodeEntry>,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CodesState].
extension CodesStatePatterns on CodesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CodesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CodesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CodesState value)  $default,){
final _that = this;
switch (_that) {
case _CodesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CodesState value)?  $default,){
final _that = this;
switch (_that) {
case _CodesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  List<CodeEntry> entries,  String search)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CodesState() when $default != null:
return $default(_that.status,_that.entries,_that.search);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  List<CodeEntry> entries,  String search)  $default,) {final _that = this;
switch (_that) {
case _CodesState():
return $default(_that.status,_that.entries,_that.search);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  List<CodeEntry> entries,  String search)?  $default,) {final _that = this;
switch (_that) {
case _CodesState() when $default != null:
return $default(_that.status,_that.entries,_that.search);case _:
  return null;

}
}

}

/// @nodoc


class _CodesState extends CodesState {
  const _CodesState({this.status = const CubitStatus(), final  List<CodeEntry> entries = const <CodeEntry>[], this.search = ''}): _entries = entries,super._();
  

@override@JsonKey() final  CubitStatus status;
/// Every item with a setup key, A to Z (board `Codes` 01).
 final  List<CodeEntry> _entries;
/// Every item with a setup key, A to Z (board `Codes` 01).
@override@JsonKey() List<CodeEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

/// What is typed in the search field.
@override@JsonKey() final  String search;

/// Create a copy of CodesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodesStateCopyWith<_CodesState> get copyWith => __$CodesStateCopyWithImpl<_CodesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_entries),search);

@override
String toString() {
  return 'CodesState(status: $status, entries: $entries, search: $search)';
}


}

/// @nodoc
abstract mixin class _$CodesStateCopyWith<$Res> implements $CodesStateCopyWith<$Res> {
  factory _$CodesStateCopyWith(_CodesState value, $Res Function(_CodesState) _then) = __$CodesStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, List<CodeEntry> entries, String search
});




}
/// @nodoc
class __$CodesStateCopyWithImpl<$Res>
    implements _$CodesStateCopyWith<$Res> {
  __$CodesStateCopyWithImpl(this._self, this._then);

  final _CodesState _self;
  final $Res Function(_CodesState) _then;

/// Create a copy of CodesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? entries = null,Object? search = null,}) {
  return _then(_CodesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<CodeEntry>,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
