// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure()';
}


}

/// @nodoc
class $NetworkFailureCopyWith<$Res>  {
$NetworkFailureCopyWith(NetworkFailure _, $Res Function(NetworkFailure) __);
}


/// Adds pattern-matching-related methods to [NetworkFailure].
extension NetworkFailurePatterns on NetworkFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CustomBackendError value)?  customBackendError,TResult Function( RequestCancelled value)?  requestCancelled,TResult Function( NoDataFound value)?  noDataFound,TResult Function( UnauthorisedRequest value)?  unauthorisedRequest,TResult Function( BadRequest value)?  badRequest,TResult Function( NotFound value)?  notFound,TResult Function( MethodNotAllowed value)?  methodNotAllowed,TResult Function( NotAcceptable value)?  notAcceptable,TResult Function( RequestTimeout value)?  requestTimeout,TResult Function( SendTimeout value)?  sendTimeout,TResult Function( ReceiveTimeout value)?  receiveTimeout,TResult Function( Conflict value)?  conflict,TResult Function( InternalServerError value)?  internalServerError,TResult Function( NotImplemented value)?  notImplemented,TResult Function( ServiceUnavailable value)?  serviceUnavailable,TResult Function( ConnectionRefused value)?  connectionRefused,TResult Function( NoInternetConnection value)?  noInternetConnection,TResult Function( DefaultError value)?  defaultError,TResult Function( UnknownError value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CustomBackendError() when customBackendError != null:
return customBackendError(_that);case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case NoDataFound() when noDataFound != null:
return noDataFound(_that);case UnauthorisedRequest() when unauthorisedRequest != null:
return unauthorisedRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed(_that);case NotAcceptable() when notAcceptable != null:
return notAcceptable(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that);case ReceiveTimeout() when receiveTimeout != null:
return receiveTimeout(_that);case Conflict() when conflict != null:
return conflict(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case NotImplemented() when notImplemented != null:
return notImplemented(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case ConnectionRefused() when connectionRefused != null:
return connectionRefused(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case DefaultError() when defaultError != null:
return defaultError(_that);case UnknownError() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CustomBackendError value)  customBackendError,required TResult Function( RequestCancelled value)  requestCancelled,required TResult Function( NoDataFound value)  noDataFound,required TResult Function( UnauthorisedRequest value)  unauthorisedRequest,required TResult Function( BadRequest value)  badRequest,required TResult Function( NotFound value)  notFound,required TResult Function( MethodNotAllowed value)  methodNotAllowed,required TResult Function( NotAcceptable value)  notAcceptable,required TResult Function( RequestTimeout value)  requestTimeout,required TResult Function( SendTimeout value)  sendTimeout,required TResult Function( ReceiveTimeout value)  receiveTimeout,required TResult Function( Conflict value)  conflict,required TResult Function( InternalServerError value)  internalServerError,required TResult Function( NotImplemented value)  notImplemented,required TResult Function( ServiceUnavailable value)  serviceUnavailable,required TResult Function( ConnectionRefused value)  connectionRefused,required TResult Function( NoInternetConnection value)  noInternetConnection,required TResult Function( DefaultError value)  defaultError,required TResult Function( UnknownError value)  unknown,}){
final _that = this;
switch (_that) {
case CustomBackendError():
return customBackendError(_that);case RequestCancelled():
return requestCancelled(_that);case NoDataFound():
return noDataFound(_that);case UnauthorisedRequest():
return unauthorisedRequest(_that);case BadRequest():
return badRequest(_that);case NotFound():
return notFound(_that);case MethodNotAllowed():
return methodNotAllowed(_that);case NotAcceptable():
return notAcceptable(_that);case RequestTimeout():
return requestTimeout(_that);case SendTimeout():
return sendTimeout(_that);case ReceiveTimeout():
return receiveTimeout(_that);case Conflict():
return conflict(_that);case InternalServerError():
return internalServerError(_that);case NotImplemented():
return notImplemented(_that);case ServiceUnavailable():
return serviceUnavailable(_that);case ConnectionRefused():
return connectionRefused(_that);case NoInternetConnection():
return noInternetConnection(_that);case DefaultError():
return defaultError(_that);case UnknownError():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CustomBackendError value)?  customBackendError,TResult? Function( RequestCancelled value)?  requestCancelled,TResult? Function( NoDataFound value)?  noDataFound,TResult? Function( UnauthorisedRequest value)?  unauthorisedRequest,TResult? Function( BadRequest value)?  badRequest,TResult? Function( NotFound value)?  notFound,TResult? Function( MethodNotAllowed value)?  methodNotAllowed,TResult? Function( NotAcceptable value)?  notAcceptable,TResult? Function( RequestTimeout value)?  requestTimeout,TResult? Function( SendTimeout value)?  sendTimeout,TResult? Function( ReceiveTimeout value)?  receiveTimeout,TResult? Function( Conflict value)?  conflict,TResult? Function( InternalServerError value)?  internalServerError,TResult? Function( NotImplemented value)?  notImplemented,TResult? Function( ServiceUnavailable value)?  serviceUnavailable,TResult? Function( ConnectionRefused value)?  connectionRefused,TResult? Function( NoInternetConnection value)?  noInternetConnection,TResult? Function( DefaultError value)?  defaultError,TResult? Function( UnknownError value)?  unknown,}){
final _that = this;
switch (_that) {
case CustomBackendError() when customBackendError != null:
return customBackendError(_that);case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case NoDataFound() when noDataFound != null:
return noDataFound(_that);case UnauthorisedRequest() when unauthorisedRequest != null:
return unauthorisedRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed(_that);case NotAcceptable() when notAcceptable != null:
return notAcceptable(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that);case ReceiveTimeout() when receiveTimeout != null:
return receiveTimeout(_that);case Conflict() when conflict != null:
return conflict(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case NotImplemented() when notImplemented != null:
return notImplemented(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case ConnectionRefused() when connectionRefused != null:
return connectionRefused(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case DefaultError() when defaultError != null:
return defaultError(_that);case UnknownError() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Map<dynamic, dynamic> error)?  customBackendError,TResult Function()?  requestCancelled,TResult Function()?  noDataFound,TResult Function( String? errorMessage)?  unauthorisedRequest,TResult Function( dynamic error)?  badRequest,TResult Function( dynamic error)?  notFound,TResult Function()?  methodNotAllowed,TResult Function()?  notAcceptable,TResult Function()?  requestTimeout,TResult Function()?  sendTimeout,TResult Function()?  receiveTimeout,TResult Function()?  conflict,TResult Function()?  internalServerError,TResult Function()?  notImplemented,TResult Function()?  serviceUnavailable,TResult Function()?  connectionRefused,TResult Function()?  noInternetConnection,TResult Function( String error)?  defaultError,TResult Function( dynamic data)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CustomBackendError() when customBackendError != null:
return customBackendError(_that.error);case RequestCancelled() when requestCancelled != null:
return requestCancelled();case NoDataFound() when noDataFound != null:
return noDataFound();case UnauthorisedRequest() when unauthorisedRequest != null:
return unauthorisedRequest(_that.errorMessage);case BadRequest() when badRequest != null:
return badRequest(_that.error);case NotFound() when notFound != null:
return notFound(_that.error);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed();case NotAcceptable() when notAcceptable != null:
return notAcceptable();case RequestTimeout() when requestTimeout != null:
return requestTimeout();case SendTimeout() when sendTimeout != null:
return sendTimeout();case ReceiveTimeout() when receiveTimeout != null:
return receiveTimeout();case Conflict() when conflict != null:
return conflict();case InternalServerError() when internalServerError != null:
return internalServerError();case NotImplemented() when notImplemented != null:
return notImplemented();case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable();case ConnectionRefused() when connectionRefused != null:
return connectionRefused();case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection();case DefaultError() when defaultError != null:
return defaultError(_that.error);case UnknownError() when unknown != null:
return unknown(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Map<dynamic, dynamic> error)  customBackendError,required TResult Function()  requestCancelled,required TResult Function()  noDataFound,required TResult Function( String? errorMessage)  unauthorisedRequest,required TResult Function( dynamic error)  badRequest,required TResult Function( dynamic error)  notFound,required TResult Function()  methodNotAllowed,required TResult Function()  notAcceptable,required TResult Function()  requestTimeout,required TResult Function()  sendTimeout,required TResult Function()  receiveTimeout,required TResult Function()  conflict,required TResult Function()  internalServerError,required TResult Function()  notImplemented,required TResult Function()  serviceUnavailable,required TResult Function()  connectionRefused,required TResult Function()  noInternetConnection,required TResult Function( String error)  defaultError,required TResult Function( dynamic data)  unknown,}) {final _that = this;
switch (_that) {
case CustomBackendError():
return customBackendError(_that.error);case RequestCancelled():
return requestCancelled();case NoDataFound():
return noDataFound();case UnauthorisedRequest():
return unauthorisedRequest(_that.errorMessage);case BadRequest():
return badRequest(_that.error);case NotFound():
return notFound(_that.error);case MethodNotAllowed():
return methodNotAllowed();case NotAcceptable():
return notAcceptable();case RequestTimeout():
return requestTimeout();case SendTimeout():
return sendTimeout();case ReceiveTimeout():
return receiveTimeout();case Conflict():
return conflict();case InternalServerError():
return internalServerError();case NotImplemented():
return notImplemented();case ServiceUnavailable():
return serviceUnavailable();case ConnectionRefused():
return connectionRefused();case NoInternetConnection():
return noInternetConnection();case DefaultError():
return defaultError(_that.error);case UnknownError():
return unknown(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Map<dynamic, dynamic> error)?  customBackendError,TResult? Function()?  requestCancelled,TResult? Function()?  noDataFound,TResult? Function( String? errorMessage)?  unauthorisedRequest,TResult? Function( dynamic error)?  badRequest,TResult? Function( dynamic error)?  notFound,TResult? Function()?  methodNotAllowed,TResult? Function()?  notAcceptable,TResult? Function()?  requestTimeout,TResult? Function()?  sendTimeout,TResult? Function()?  receiveTimeout,TResult? Function()?  conflict,TResult? Function()?  internalServerError,TResult? Function()?  notImplemented,TResult? Function()?  serviceUnavailable,TResult? Function()?  connectionRefused,TResult? Function()?  noInternetConnection,TResult? Function( String error)?  defaultError,TResult? Function( dynamic data)?  unknown,}) {final _that = this;
switch (_that) {
case CustomBackendError() when customBackendError != null:
return customBackendError(_that.error);case RequestCancelled() when requestCancelled != null:
return requestCancelled();case NoDataFound() when noDataFound != null:
return noDataFound();case UnauthorisedRequest() when unauthorisedRequest != null:
return unauthorisedRequest(_that.errorMessage);case BadRequest() when badRequest != null:
return badRequest(_that.error);case NotFound() when notFound != null:
return notFound(_that.error);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed();case NotAcceptable() when notAcceptable != null:
return notAcceptable();case RequestTimeout() when requestTimeout != null:
return requestTimeout();case SendTimeout() when sendTimeout != null:
return sendTimeout();case ReceiveTimeout() when receiveTimeout != null:
return receiveTimeout();case Conflict() when conflict != null:
return conflict();case InternalServerError() when internalServerError != null:
return internalServerError();case NotImplemented() when notImplemented != null:
return notImplemented();case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable();case ConnectionRefused() when connectionRefused != null:
return connectionRefused();case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection();case DefaultError() when defaultError != null:
return defaultError(_that.error);case UnknownError() when unknown != null:
return unknown(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class CustomBackendError extends NetworkFailure {
  const CustomBackendError(final  Map<dynamic, dynamic> error): _error = error,super._();
  

 final  Map<dynamic, dynamic> _error;
 Map<dynamic, dynamic> get error {
  if (_error is EqualUnmodifiableMapView) return _error;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_error);
}


/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomBackendErrorCopyWith<CustomBackendError> get copyWith => _$CustomBackendErrorCopyWithImpl<CustomBackendError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomBackendError&&const DeepCollectionEquality().equals(other._error, _error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_error));

@override
String toString() {
  return 'NetworkFailure.customBackendError(error: $error)';
}


}

/// @nodoc
abstract mixin class $CustomBackendErrorCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $CustomBackendErrorCopyWith(CustomBackendError value, $Res Function(CustomBackendError) _then) = _$CustomBackendErrorCopyWithImpl;
@useResult
$Res call({
 Map<dynamic, dynamic> error
});




}
/// @nodoc
class _$CustomBackendErrorCopyWithImpl<$Res>
    implements $CustomBackendErrorCopyWith<$Res> {
  _$CustomBackendErrorCopyWithImpl(this._self, this._then);

  final CustomBackendError _self;
  final $Res Function(CustomBackendError) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(CustomBackendError(
null == error ? _self._error : error // ignore: cast_nullable_to_non_nullable
as Map<dynamic, dynamic>,
  ));
}


}

/// @nodoc


class RequestCancelled extends NetworkFailure {
  const RequestCancelled(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.requestCancelled()';
}


}




/// @nodoc


class NoDataFound extends NetworkFailure {
  const NoDataFound(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoDataFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.noDataFound()';
}


}




/// @nodoc


class UnauthorisedRequest extends NetworkFailure {
  const UnauthorisedRequest(this.errorMessage): super._();
  

 final  String? errorMessage;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnauthorisedRequestCopyWith<UnauthorisedRequest> get copyWith => _$UnauthorisedRequestCopyWithImpl<UnauthorisedRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorisedRequest&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'NetworkFailure.unauthorisedRequest(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UnauthorisedRequestCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $UnauthorisedRequestCopyWith(UnauthorisedRequest value, $Res Function(UnauthorisedRequest) _then) = _$UnauthorisedRequestCopyWithImpl;
@useResult
$Res call({
 String? errorMessage
});




}
/// @nodoc
class _$UnauthorisedRequestCopyWithImpl<$Res>
    implements $UnauthorisedRequestCopyWith<$Res> {
  _$UnauthorisedRequestCopyWithImpl(this._self, this._then);

  final UnauthorisedRequest _self;
  final $Res Function(UnauthorisedRequest) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = freezed,}) {
  return _then(UnauthorisedRequest(
freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BadRequest extends NetworkFailure {
  const BadRequest(this.error): super._();
  

 final  dynamic error;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadRequestCopyWith<BadRequest> get copyWith => _$BadRequestCopyWithImpl<BadRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadRequest&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'NetworkFailure.badRequest(error: $error)';
}


}

/// @nodoc
abstract mixin class $BadRequestCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $BadRequestCopyWith(BadRequest value, $Res Function(BadRequest) _then) = _$BadRequestCopyWithImpl;
@useResult
$Res call({
 dynamic error
});




}
/// @nodoc
class _$BadRequestCopyWithImpl<$Res>
    implements $BadRequestCopyWith<$Res> {
  _$BadRequestCopyWithImpl(this._self, this._then);

  final BadRequest _self;
  final $Res Function(BadRequest) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(BadRequest(
freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class NotFound extends NetworkFailure {
  const NotFound(this.error): super._();
  

 final  dynamic error;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundCopyWith<NotFound> get copyWith => _$NotFoundCopyWithImpl<NotFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFound&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'NetworkFailure.notFound(error: $error)';
}


}

/// @nodoc
abstract mixin class $NotFoundCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $NotFoundCopyWith(NotFound value, $Res Function(NotFound) _then) = _$NotFoundCopyWithImpl;
@useResult
$Res call({
 dynamic error
});




}
/// @nodoc
class _$NotFoundCopyWithImpl<$Res>
    implements $NotFoundCopyWith<$Res> {
  _$NotFoundCopyWithImpl(this._self, this._then);

  final NotFound _self;
  final $Res Function(NotFound) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(NotFound(
freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class MethodNotAllowed extends NetworkFailure {
  const MethodNotAllowed(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MethodNotAllowed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.methodNotAllowed()';
}


}




/// @nodoc


class NotAcceptable extends NetworkFailure {
  const NotAcceptable(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotAcceptable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.notAcceptable()';
}


}




/// @nodoc


class RequestTimeout extends NetworkFailure {
  const RequestTimeout(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestTimeout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.requestTimeout()';
}


}




/// @nodoc


class SendTimeout extends NetworkFailure {
  const SendTimeout(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendTimeout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.sendTimeout()';
}


}




/// @nodoc


class ReceiveTimeout extends NetworkFailure {
  const ReceiveTimeout(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveTimeout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.receiveTimeout()';
}


}




/// @nodoc


class Conflict extends NetworkFailure {
  const Conflict(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conflict);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.conflict()';
}


}




/// @nodoc


class InternalServerError extends NetworkFailure {
  const InternalServerError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternalServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.internalServerError()';
}


}




/// @nodoc


class NotImplemented extends NetworkFailure {
  const NotImplemented(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotImplemented);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.notImplemented()';
}


}




/// @nodoc


class ServiceUnavailable extends NetworkFailure {
  const ServiceUnavailable(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceUnavailable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.serviceUnavailable()';
}


}




/// @nodoc


class ConnectionRefused extends NetworkFailure {
  const ConnectionRefused(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionRefused);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.connectionRefused()';
}


}




/// @nodoc


class NoInternetConnection extends NetworkFailure {
  const NoInternetConnection(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoInternetConnection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NetworkFailure.noInternetConnection()';
}


}




/// @nodoc


class DefaultError extends NetworkFailure {
  const DefaultError(this.error): super._();
  

 final  String error;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefaultErrorCopyWith<DefaultError> get copyWith => _$DefaultErrorCopyWithImpl<DefaultError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'NetworkFailure.defaultError(error: $error)';
}


}

/// @nodoc
abstract mixin class $DefaultErrorCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $DefaultErrorCopyWith(DefaultError value, $Res Function(DefaultError) _then) = _$DefaultErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$DefaultErrorCopyWithImpl<$Res>
    implements $DefaultErrorCopyWith<$Res> {
  _$DefaultErrorCopyWithImpl(this._self, this._then);

  final DefaultError _self;
  final $Res Function(DefaultError) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(DefaultError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UnknownError extends NetworkFailure {
  const UnknownError(this.data): super._();
  

 final  dynamic data;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownErrorCopyWith<UnknownError> get copyWith => _$UnknownErrorCopyWithImpl<UnknownError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownError&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'NetworkFailure.unknown(data: $data)';
}


}

/// @nodoc
abstract mixin class $UnknownErrorCopyWith<$Res> implements $NetworkFailureCopyWith<$Res> {
  factory $UnknownErrorCopyWith(UnknownError value, $Res Function(UnknownError) _then) = _$UnknownErrorCopyWithImpl;
@useResult
$Res call({
 dynamic data
});




}
/// @nodoc
class _$UnknownErrorCopyWithImpl<$Res>
    implements $UnknownErrorCopyWith<$Res> {
  _$UnknownErrorCopyWithImpl(this._self, this._then);

  final UnknownError _self;
  final $Res Function(UnknownError) _then;

/// Create a copy of NetworkFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(UnknownError(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
