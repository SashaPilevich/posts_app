import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// An interceptor for logging Dio network requests, responses and errors.
class DioLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String headers = options.headers.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join('\n');
    debugPrint(
      'NETWORK REQUEST: ${options.method} ${options.uri}\n'
      'Query: ${options.data}\n'
      'Headers:\n$headers',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data != null && response.data != []) {
      debugPrint(
        'NETWORK RESPONSE [code ${response.statusCode}]:\n'
        '${response.data}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      'NETWORK ERROR: ${err.error}: ${err.response}\n'
      'path=${err.requestOptions.path}',
    );
    handler.next(err);
  }
}
