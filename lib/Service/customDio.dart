// ignore_for_file: strict_raw_type,non_constant_identifier_names

import 'package:boosic/Service/customIntercepter.dart';
import 'package:dio/dio.dart';

final API = BasicAPI();

String stErrFunction(DioException e) {
  switch (e.hashCode) {
    //register error
    case 500:
    default:
      return e.message!;
  }
}

//option이 헤더
class BasicAPI {
  late Dio dio;

  final String baseUrl = "";

  BasicAPI() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
    );
    dio = Dio(options);
    dio.interceptors.add(
      custrom_interceptor,
    );
  }

  Future<Response> GET({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Function errFunction = stErrFunction,
  }) async {
    Response res;

    try {
      res = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw stErrFunction(e);
    }

    return res;
  }

  Future<Response> POST({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Function errFunction = stErrFunction,
  }) async {
    Response res;

    try {
      res = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw stErrFunction(e);
    }

    return res;
  }

  dynamic PUT({
    required String path,
    required data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Function errFunction = stErrFunction,
  }) async {
    Response res;

    try {
      res = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw stErrFunction(e);
    }

    return res;
  }

  dynamic DELETE({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Function errFunction = stErrFunction,
  }) async {
    Response res;

    try {
      res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw stErrFunction(e);
    }

    return res;
  }

  dynamic PATCH({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required Function errFunction,
  }) async {
    Response res;

    try {
      res = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw stErrFunction(e);
    }

    return res;
  }
}
