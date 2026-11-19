// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportSource {

 String get label; int get items;/// Null for All Vaults.
 String? get vaultId;
/// Create a copy of ExportSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportSourceCopyWith<ExportSource> get copyWith => _$ExportSourceCopyWithImpl<ExportSource>(this as ExportSource, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportSource&&(identical(other.label, label) || other.label == label)&&(identical(other.items, items) || other.items == items)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId));
}


@override
int get hashCode => Object.hash(runtimeType,label,items,vaultId);

@override
String toString() {
  return 'ExportSource(label: $label, items: $items, vaultId: $vaultId)';
}


}

/// @nodoc
abstract mixin class $ExportSourceCopyWith<$Res>  {
  factory $ExportSourceCopyWith(ExportSource value, $Res Function(ExportSource) _then) = _$ExportSourceCopyWithImpl;
@useResult
$Res call({
 String label, int items, String? vaultId
});




}
/// @nodoc
class _$ExportSourceCopyWithImpl<$Res>
    implements $ExportSourceCopyWith<$Res> {
  _$ExportSourceCopyWithImpl(this._self, this._then);

  final ExportSource _self;
  final $Res Function(ExportSource) _then;

/// Create a copy of ExportSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? items = null,Object? vaultId = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as int,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportSource].
extension ExportSourcePatterns on ExportSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportSource value)  $default,){
final _that = this;
switch (_that) {
case _ExportSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportSource value)?  $default,){
final _that = this;
switch (_that) {
case _ExportSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int items,  String? vaultId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportSource() when $default != null:
return $default(_that.label,_that.items,_that.vaultId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int items,  String? vaultId)  $default,) {final _that = this;
switch (_that) {
case _ExportSource():
return $default(_that.label,_that.items,_that.vaultId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int items,  String? vaultId)?  $default,) {final _that = this;
switch (_that) {
case _ExportSource() when $default != null:
return $default(_that.label,_that.items,_that.vaultId);case _:
  return null;

}
}

}

/// @nodoc


class _ExportSource implements ExportSource {
  const _ExportSource({required this.label, required this.items, this.vaultId});
  

@override final  String label;
@override final  int items;
/// Null for All Vaults.
@override final  String? vaultId;

/// Create a copy of ExportSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportSourceCopyWith<_ExportSource> get copyWith => __$ExportSourceCopyWithImpl<_ExportSource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportSource&&(identical(other.label, label) || other.label == label)&&(identical(other.items, items) || other.items == items)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId));
}


@override
int get hashCode => Object.hash(runtimeType,label,items,vaultId);

@override
String toString() {
  return 'ExportSource(label: $label, items: $items, vaultId: $vaultId)';
}


}

/// @nodoc
abstract mixin class _$ExportSourceCopyWith<$Res> implements $ExportSourceCopyWith<$Res> {
  factory _$ExportSourceCopyWith(_ExportSource value, $Res Function(_ExportSource) _then) = __$ExportSourceCopyWithImpl;
@override @useResult
$Res call({
 String label, int items, String? vaultId
});




}
/// @nodoc
class __$ExportSourceCopyWithImpl<$Res>
    implements _$ExportSourceCopyWith<$Res> {
  __$ExportSourceCopyWithImpl(this._self, this._then);

  final _ExportSource _self;
  final $Res Function(_ExportSource) _then;

/// Create a copy of ExportSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? items = null,Object? vaultId = freezed,}) {
  return _then(_ExportSource(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as int,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ExportState {

 List<ExportSource> get sources;/// The chosen vault; null is All Vaults (web: the default).
 String? get vaultId;/// The share sheet is up.
 bool get exporting;
/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportStateCopyWith<ExportState> get copyWith => _$ExportStateCopyWithImpl<ExportState>(this as ExportState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportState&&const DeepCollectionEquality().equals(other.sources, sources)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.exporting, exporting) || other.exporting == exporting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sources),vaultId,exporting);

@override
String toString() {
  return 'ExportState(sources: $sources, vaultId: $vaultId, exporting: $exporting)';
}


}

/// @nodoc
abstract mixin class $ExportStateCopyWith<$Res>  {
  factory $ExportStateCopyWith(ExportState value, $Res Function(ExportState) _then) = _$ExportStateCopyWithImpl;
@useResult
$Res call({
 List<ExportSource> sources, String? vaultId, bool exporting
});




}
/// @nodoc
class _$ExportStateCopyWithImpl<$Res>
    implements $ExportStateCopyWith<$Res> {
  _$ExportStateCopyWithImpl(this._self, this._then);

  final ExportState _self;
  final $Res Function(ExportState) _then;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sources = null,Object? vaultId = freezed,Object? exporting = null,}) {
  return _then(_self.copyWith(
sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<ExportSource>,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,exporting: null == exporting ? _self.exporting : exporting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportState].
extension ExportStatePatterns on ExportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExportState value)  $default,){
final _that = this;
switch (_that) {
case _ExportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExportState value)?  $default,){
final _that = this;
switch (_that) {
case _ExportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ExportSource> sources,  String? vaultId,  bool exporting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportState() when $default != null:
return $default(_that.sources,_that.vaultId,_that.exporting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ExportSource> sources,  String? vaultId,  bool exporting)  $default,) {final _that = this;
switch (_that) {
case _ExportState():
return $default(_that.sources,_that.vaultId,_that.exporting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ExportSource> sources,  String? vaultId,  bool exporting)?  $default,) {final _that = this;
switch (_that) {
case _ExportState() when $default != null:
return $default(_that.sources,_that.vaultId,_that.exporting);case _:
  return null;

}
}

}

/// @nodoc


class _ExportState extends ExportState {
  const _ExportState({final  List<ExportSource> sources = const <ExportSource>[], this.vaultId, this.exporting = false}): _sources = sources,super._();
  

 final  List<ExportSource> _sources;
@override@JsonKey() List<ExportSource> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

/// The chosen vault; null is All Vaults (web: the default).
@override final  String? vaultId;
/// The share sheet is up.
@override@JsonKey() final  bool exporting;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportStateCopyWith<_ExportState> get copyWith => __$ExportStateCopyWithImpl<_ExportState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportState&&const DeepCollectionEquality().equals(other._sources, _sources)&&(identical(other.vaultId, vaultId) || other.vaultId == vaultId)&&(identical(other.exporting, exporting) || other.exporting == exporting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sources),vaultId,exporting);

@override
String toString() {
  return 'ExportState(sources: $sources, vaultId: $vaultId, exporting: $exporting)';
}


}

/// @nodoc
abstract mixin class _$ExportStateCopyWith<$Res> implements $ExportStateCopyWith<$Res> {
  factory _$ExportStateCopyWith(_ExportState value, $Res Function(_ExportState) _then) = __$ExportStateCopyWithImpl;
@override @useResult
$Res call({
 List<ExportSource> sources, String? vaultId, bool exporting
});




}
/// @nodoc
class __$ExportStateCopyWithImpl<$Res>
    implements _$ExportStateCopyWith<$Res> {
  __$ExportStateCopyWithImpl(this._self, this._then);

  final _ExportState _self;
  final $Res Function(_ExportState) _then;

/// Create a copy of ExportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sources = null,Object? vaultId = freezed,Object? exporting = null,}) {
  return _then(_ExportState(
sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<ExportSource>,vaultId: freezed == vaultId ? _self.vaultId : vaultId // ignore: cast_nullable_to_non_nullable
as String?,exporting: null == exporting ? _self.exporting : exporting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
