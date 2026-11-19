// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tags_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TagsState {

/// Every known tag, most used first (web `VaultStore.tags`).
 List<TagInfo> get tags; bool get selecting; Set<String> get selected;
/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagsStateCopyWith<TagsState> get copyWith => _$TagsStateCopyWithImpl<TagsState>(this as TagsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagsState&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.selecting, selecting) || other.selecting == selecting)&&const DeepCollectionEquality().equals(other.selected, selected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tags),selecting,const DeepCollectionEquality().hash(selected));

@override
String toString() {
  return 'TagsState(tags: $tags, selecting: $selecting, selected: $selected)';
}


}

/// @nodoc
abstract mixin class $TagsStateCopyWith<$Res>  {
  factory $TagsStateCopyWith(TagsState value, $Res Function(TagsState) _then) = _$TagsStateCopyWithImpl;
@useResult
$Res call({
 List<TagInfo> tags, bool selecting, Set<String> selected
});




}
/// @nodoc
class _$TagsStateCopyWithImpl<$Res>
    implements $TagsStateCopyWith<$Res> {
  _$TagsStateCopyWithImpl(this._self, this._then);

  final TagsState _self;
  final $Res Function(TagsState) _then;

/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tags = null,Object? selecting = null,Object? selected = null,}) {
  return _then(_self.copyWith(
tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagInfo>,selecting: null == selecting ? _self.selecting : selecting // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TagsState].
extension TagsStatePatterns on TagsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagsState value)  $default,){
final _that = this;
switch (_that) {
case _TagsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagsState value)?  $default,){
final _that = this;
switch (_that) {
case _TagsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TagInfo> tags,  bool selecting,  Set<String> selected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagsState() when $default != null:
return $default(_that.tags,_that.selecting,_that.selected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TagInfo> tags,  bool selecting,  Set<String> selected)  $default,) {final _that = this;
switch (_that) {
case _TagsState():
return $default(_that.tags,_that.selecting,_that.selected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TagInfo> tags,  bool selecting,  Set<String> selected)?  $default,) {final _that = this;
switch (_that) {
case _TagsState() when $default != null:
return $default(_that.tags,_that.selecting,_that.selected);case _:
  return null;

}
}

}

/// @nodoc


class _TagsState extends TagsState {
  const _TagsState({final  List<TagInfo> tags = const <TagInfo>[], this.selecting = false, final  Set<String> selected = const <String>{}}): _tags = tags,_selected = selected,super._();
  

/// Every known tag, most used first (web `VaultStore.tags`).
 final  List<TagInfo> _tags;
/// Every known tag, most used first (web `VaultStore.tags`).
@override@JsonKey() List<TagInfo> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool selecting;
 final  Set<String> _selected;
@override@JsonKey() Set<String> get selected {
  if (_selected is EqualUnmodifiableSetView) return _selected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selected);
}


/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagsStateCopyWith<_TagsState> get copyWith => __$TagsStateCopyWithImpl<_TagsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagsState&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.selecting, selecting) || other.selecting == selecting)&&const DeepCollectionEquality().equals(other._selected, _selected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tags),selecting,const DeepCollectionEquality().hash(_selected));

@override
String toString() {
  return 'TagsState(tags: $tags, selecting: $selecting, selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$TagsStateCopyWith<$Res> implements $TagsStateCopyWith<$Res> {
  factory _$TagsStateCopyWith(_TagsState value, $Res Function(_TagsState) _then) = __$TagsStateCopyWithImpl;
@override @useResult
$Res call({
 List<TagInfo> tags, bool selecting, Set<String> selected
});




}
/// @nodoc
class __$TagsStateCopyWithImpl<$Res>
    implements _$TagsStateCopyWith<$Res> {
  __$TagsStateCopyWithImpl(this._self, this._then);

  final _TagsState _self;
  final $Res Function(_TagsState) _then;

/// Create a copy of TagsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tags = null,Object? selecting = null,Object? selected = null,}) {
  return _then(_TagsState(
tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagInfo>,selecting: null == selecting ? _self.selecting : selecting // ignore: cast_nullable_to_non_nullable
as bool,selected: null == selected ? _self._selected : selected // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
