import 'package:buuk_test/core/api/dio_logging_interceptor.dart';
import 'package:buuk_test/core/helpers/global_configs.dart';
import 'package:dio/dio.dart';

abstract class NetworkModule {
  static Dio provideDio() {
    BaseOptions options = BaseOptions(
      receiveTimeout: GlobalConfig.receiveTimeout,
      connectTimeout: GlobalConfig.connectTimeOut,
    );
    final dio = Dio(options);
    dio.interceptors.add(DioLoggingInterceptor());
    return dio;
  }
}
