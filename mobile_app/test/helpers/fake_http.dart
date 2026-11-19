import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A request as the fake server received it.
class RecordedRequest {
  RecordedRequest(
    this.method,
    this.uri,
    this.headers,
    this.body, {
    this.sendTimeout,
  });

  final String method;
  final Uri uri;
  final Map<String, dynamic> headers;
  final List<int> body;

  /// How long sending the body may take (Dio's per-request limit).
  final Duration? sendTimeout;

  String get text => utf8.decode(body);

  Object? get json => jsonDecode(text);

  String? header(String name) {
    for (final MapEntry<String, dynamic> entry in headers.entries) {
      if (entry.key.toLowerCase() == name.toLowerCase()) {
        return entry.value.toString();
      }
    }
    return null;
  }
}

typedef Responder = ResponseBody Function(RecordedRequest request);

/// Answers Dio requests from a script, in order, and records them.
class FakeHttpAdapter implements HttpClientAdapter {
  final List<RecordedRequest> requests = <RecordedRequest>[];
  final List<Responder> _responders = <Responder>[];

  void reply(Responder responder) => _responders.add(responder);

  void replyText(
    int status, [
    String body = '',
    Map<String, List<String>> headers = const <String, List<String>>{},
  ]) => reply((_) => ResponseBody.fromString(body, status, headers: headers));

  /// Labelled `application/json`, as Google and Dropbox send it (Dio decodes
  /// such bodies itself unless the request asks for a `String`).
  void replyJson(
    int status,
    Object? body, [
    Map<String, List<String>> headers = const <String, List<String>>{},
  ]) => replyText(status, jsonEncode(body), <String, List<String>>{
    Headers.contentTypeHeader: <String>[Headers.jsonContentType],
    ...headers,
  });

  /// The phone has no connection.
  void replyOffline() => reply((RecordedRequest request) {
    throw DioException(
      requestOptions: RequestOptions(path: request.uri.toString()),
      type: DioExceptionType.connectionError,
    );
  });

  bool get done => _responders.isEmpty;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final List<int> body = <int>[
      if (requestStream != null)
        for (final Uint8List chunk in await requestStream.toList()) ...chunk,
    ];
    final RecordedRequest request = RecordedRequest(
      options.method,
      options.uri,
      options.headers,
      body,
      sendTimeout: options.sendTimeout,
    );
    requests.add(request);
    if (_responders.isEmpty) {
      throw StateError('Unexpected ${options.method} ${options.uri}');
    }
    try {
      return _responders.removeAt(0)(request);
    } on DioException catch (error) {
      throw DioException(
        requestOptions: options,
        type: error.type,
        error: error.error,
      );
    }
  }

  @override
  void close({bool force = false}) {}
}

Dio fakeDio(FakeHttpAdapter adapter) => Dio()..httpClientAdapter = adapter;
