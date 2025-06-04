import 'package:dio/dio.dart';
import 'interceptors/dio_logger_interceptor.dart';

/// A class that provides a configured Dio client for making network requests.
class DioClient {
  final Dio _dio;

  DioClient({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 10),
  }) : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );

    _dio.interceptors.add(DioLoggerInterceptor());
  }

  Dio get dio => _dio;
}
