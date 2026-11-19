import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_failure.freezed.dart';

@freezed
sealed class NetworkFailure with _$NetworkFailure {
  const NetworkFailure._();

  const factory NetworkFailure.customBackendError(Map<dynamic, dynamic> error) =
      CustomBackendError;

  const factory NetworkFailure.requestCancelled() = RequestCancelled;

  const factory NetworkFailure.noDataFound() = NoDataFound;

  const factory NetworkFailure.unauthorisedRequest(String? errorMessage) =
      UnauthorisedRequest;

  const factory NetworkFailure.badRequest(dynamic error) = BadRequest;

  const factory NetworkFailure.notFound(dynamic error) = NotFound;

  const factory NetworkFailure.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkFailure.notAcceptable() = NotAcceptable;

  const factory NetworkFailure.requestTimeout() = RequestTimeout;

  const factory NetworkFailure.sendTimeout() = SendTimeout;

  const factory NetworkFailure.receiveTimeout() = ReceiveTimeout;

  const factory NetworkFailure.conflict() = Conflict;

  const factory NetworkFailure.internalServerError() = InternalServerError;

  const factory NetworkFailure.notImplemented() = NotImplemented;

  const factory NetworkFailure.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkFailure.connectionRefused() = ConnectionRefused;

  const factory NetworkFailure.noInternetConnection() = NoInternetConnection;

  const factory NetworkFailure.defaultError(String error) = DefaultError;

  const factory NetworkFailure.unknown(dynamic data) = UnknownError;

  static NetworkFailure getDioException(Object? error) {
    late NetworkFailure networkFailure;
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          networkFailure = const NetworkFailure.requestCancelled();
        case DioExceptionType.connectionTimeout:
          networkFailure = const NetworkFailure.requestTimeout();
        case DioExceptionType.badCertificate:
          networkFailure = const NetworkFailure.connectionRefused();
        case DioExceptionType.sendTimeout:
          networkFailure = const NetworkFailure.sendTimeout();
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.transformTimeout:
          networkFailure = const NetworkFailure.receiveTimeout();
        case DioExceptionType.connectionError:
          networkFailure = const NetworkFailure.noInternetConnection();
        case DioExceptionType.unknown:
          networkFailure = NetworkFailure.unknown(error);
        case DioExceptionType.badResponse:
          final Object? err = error.response?.data;

          if (err != null && err is Map && (err.containsKey('message'))) {
            final dynamic extractedMessage = err['message'];
            final String message =
                (extractedMessage is List && extractedMessage.isNotEmpty)
                ? extractedMessage.first.toString()
                : extractedMessage.toString();
            networkFailure = NetworkFailure.customBackendError(<String, String>{
              'message': message,
            });
          } else {
            switch (error.response?.statusCode) {
              case 400:
                networkFailure = NetworkFailure.badRequest(
                  error.response?.data,
                );
              case 401:
              case 403:
                networkFailure = NetworkFailure.unauthorisedRequest(
                  error.response?.data?.toString(),
                );
              case 404:
                networkFailure = NetworkFailure.notFound(error);
              case 409:
                networkFailure = const NetworkFailure.conflict();
              case 408:
                networkFailure = const NetworkFailure.requestTimeout();
              case 500:
                networkFailure = const NetworkFailure.internalServerError();
              case 503:
                networkFailure = const NetworkFailure.serviceUnavailable();
              default:
                final int? responseCode = error.response?.statusCode;
                networkFailure = NetworkFailure.defaultError(
                  'Received invalid status code: $responseCode',
                );
            }
          }
      }
    } else if (error is SocketException) {
      networkFailure = const NetworkFailure.noInternetConnection();
    } else {
      networkFailure = NetworkFailure.unknown(error);
    }
    return networkFailure;
  }

  bool get isNoInternet => this == const NetworkFailure.noInternetConnection();
}
