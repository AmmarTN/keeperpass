// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generator_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeneratorState {

 CubitStatus get status;/// Your answer, Part 9: the Generator tab's defaults — a passphrase of
/// 4 words, Dash, English; 20 characters of a–z, A–Z and 0–9.
 GeneratorMode get mode; int get wordCount; String get separator; String get language; int get length; bool get lowercase; bool get uppercase; bool get digits; bool get symbols;/// The suggestion; empty while a word list loads or when no kind of
/// character is on.
 String get value;
/// Create a copy of GeneratorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratorStateCopyWith<GeneratorState> get copyWith => _$GeneratorStateCopyWithImpl<GeneratorState>(this as GeneratorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratorState&&(identical(other.status, status) || other.status == status)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.separator, separator) || other.separator == separator)&&(identical(other.language, language) || other.language == language)&&(identical(other.length, length) || other.length == length)&&(identical(other.lowercase, lowercase) || other.lowercase == lowercase)&&(identical(other.uppercase, uppercase) || other.uppercase == uppercase)&&(identical(other.digits, digits) || other.digits == digits)&&(identical(other.symbols, symbols) || other.symbols == symbols)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,status,mode,wordCount,separator,language,length,lowercase,uppercase,digits,symbols,value);

@override
String toString() {
  return 'GeneratorState(status: $status, mode: $mode, wordCount: $wordCount, separator: $separator, language: $language, length: $length, lowercase: $lowercase, uppercase: $uppercase, digits: $digits, symbols: $symbols, value: $value)';
}


}

/// @nodoc
abstract mixin class $GeneratorStateCopyWith<$Res>  {
  factory $GeneratorStateCopyWith(GeneratorState value, $Res Function(GeneratorState) _then) = _$GeneratorStateCopyWithImpl;
@useResult
$Res call({
 CubitStatus status, GeneratorMode mode, int wordCount, String separator, String language, int length, bool lowercase, bool uppercase, bool digits, bool symbols, String value
});




}
/// @nodoc
class _$GeneratorStateCopyWithImpl<$Res>
    implements $GeneratorStateCopyWith<$Res> {
  _$GeneratorStateCopyWithImpl(this._self, this._then);

  final GeneratorState _self;
  final $Res Function(GeneratorState) _then;

/// Create a copy of GeneratorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? mode = null,Object? wordCount = null,Object? separator = null,Object? language = null,Object? length = null,Object? lowercase = null,Object? uppercase = null,Object? digits = null,Object? symbols = null,Object? value = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GeneratorMode,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,separator: null == separator ? _self.separator : separator // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,lowercase: null == lowercase ? _self.lowercase : lowercase // ignore: cast_nullable_to_non_nullable
as bool,uppercase: null == uppercase ? _self.uppercase : uppercase // ignore: cast_nullable_to_non_nullable
as bool,digits: null == digits ? _self.digits : digits // ignore: cast_nullable_to_non_nullable
as bool,symbols: null == symbols ? _self.symbols : symbols // ignore: cast_nullable_to_non_nullable
as bool,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratorState].
extension GeneratorStatePatterns on GeneratorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratorState value)  $default,){
final _that = this;
switch (_that) {
case _GeneratorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratorState value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CubitStatus status,  GeneratorMode mode,  int wordCount,  String separator,  String language,  int length,  bool lowercase,  bool uppercase,  bool digits,  bool symbols,  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratorState() when $default != null:
return $default(_that.status,_that.mode,_that.wordCount,_that.separator,_that.language,_that.length,_that.lowercase,_that.uppercase,_that.digits,_that.symbols,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CubitStatus status,  GeneratorMode mode,  int wordCount,  String separator,  String language,  int length,  bool lowercase,  bool uppercase,  bool digits,  bool symbols,  String value)  $default,) {final _that = this;
switch (_that) {
case _GeneratorState():
return $default(_that.status,_that.mode,_that.wordCount,_that.separator,_that.language,_that.length,_that.lowercase,_that.uppercase,_that.digits,_that.symbols,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CubitStatus status,  GeneratorMode mode,  int wordCount,  String separator,  String language,  int length,  bool lowercase,  bool uppercase,  bool digits,  bool symbols,  String value)?  $default,) {final _that = this;
switch (_that) {
case _GeneratorState() when $default != null:
return $default(_that.status,_that.mode,_that.wordCount,_that.separator,_that.language,_that.length,_that.lowercase,_that.uppercase,_that.digits,_that.symbols,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _GeneratorState extends GeneratorState {
  const _GeneratorState({this.status = const CubitStatus(), this.mode = GeneratorMode.passphrase, this.wordCount = kDefaultWordCount, this.separator = '-', this.language = 'en', this.length = kDefaultLength, this.lowercase = true, this.uppercase = true, this.digits = true, this.symbols = false, this.value = ''}): super._();
  

@override@JsonKey() final  CubitStatus status;
/// Your answer, Part 9: the Generator tab's defaults — a passphrase of
/// 4 words, Dash, English; 20 characters of a–z, A–Z and 0–9.
@override@JsonKey() final  GeneratorMode mode;
@override@JsonKey() final  int wordCount;
@override@JsonKey() final  String separator;
@override@JsonKey() final  String language;
@override@JsonKey() final  int length;
@override@JsonKey() final  bool lowercase;
@override@JsonKey() final  bool uppercase;
@override@JsonKey() final  bool digits;
@override@JsonKey() final  bool symbols;
/// The suggestion; empty while a word list loads or when no kind of
/// character is on.
@override@JsonKey() final  String value;

/// Create a copy of GeneratorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratorStateCopyWith<_GeneratorState> get copyWith => __$GeneratorStateCopyWithImpl<_GeneratorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratorState&&(identical(other.status, status) || other.status == status)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.separator, separator) || other.separator == separator)&&(identical(other.language, language) || other.language == language)&&(identical(other.length, length) || other.length == length)&&(identical(other.lowercase, lowercase) || other.lowercase == lowercase)&&(identical(other.uppercase, uppercase) || other.uppercase == uppercase)&&(identical(other.digits, digits) || other.digits == digits)&&(identical(other.symbols, symbols) || other.symbols == symbols)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,status,mode,wordCount,separator,language,length,lowercase,uppercase,digits,symbols,value);

@override
String toString() {
  return 'GeneratorState(status: $status, mode: $mode, wordCount: $wordCount, separator: $separator, language: $language, length: $length, lowercase: $lowercase, uppercase: $uppercase, digits: $digits, symbols: $symbols, value: $value)';
}


}

/// @nodoc
abstract mixin class _$GeneratorStateCopyWith<$Res> implements $GeneratorStateCopyWith<$Res> {
  factory _$GeneratorStateCopyWith(_GeneratorState value, $Res Function(_GeneratorState) _then) = __$GeneratorStateCopyWithImpl;
@override @useResult
$Res call({
 CubitStatus status, GeneratorMode mode, int wordCount, String separator, String language, int length, bool lowercase, bool uppercase, bool digits, bool symbols, String value
});




}
/// @nodoc
class __$GeneratorStateCopyWithImpl<$Res>
    implements _$GeneratorStateCopyWith<$Res> {
  __$GeneratorStateCopyWithImpl(this._self, this._then);

  final _GeneratorState _self;
  final $Res Function(_GeneratorState) _then;

/// Create a copy of GeneratorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? mode = null,Object? wordCount = null,Object? separator = null,Object? language = null,Object? length = null,Object? lowercase = null,Object? uppercase = null,Object? digits = null,Object? symbols = null,Object? value = null,}) {
  return _then(_GeneratorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CubitStatus,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as GeneratorMode,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,separator: null == separator ? _self.separator : separator // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,lowercase: null == lowercase ? _self.lowercase : lowercase // ignore: cast_nullable_to_non_nullable
as bool,uppercase: null == uppercase ? _self.uppercase : uppercase // ignore: cast_nullable_to_non_nullable
as bool,digits: null == digits ? _self.digits : digits // ignore: cast_nullable_to_non_nullable
as bool,symbols: null == symbols ? _self.symbols : symbols // ignore: cast_nullable_to_non_nullable
as bool,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
