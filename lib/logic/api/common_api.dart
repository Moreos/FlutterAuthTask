import 'dart:developer';

import 'package:dio/dio.dart';

class CommonApi {
  Dio dio = Dio();

  static final CommonApi _commonApi = CommonApi._internal();

  final Options defOptions = Options(
    headers: {
      "Accept": "application/json",
    },
  );

  CommonApi._internal() {
    dio.options.baseUrl = 'http://45.10.110.181:8080';
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          log('exception');
          if (error.response?.statusCode == 422) {
            log('bad data');
            log(error.response!.toString());
            handler.resolve(error.response!);
          }
          if (error.type == DioExceptionType.connectionError) {
            log('connection');
            handler.reject(error);
          }
        },
      ),
    );
  }

  factory CommonApi() {
    return _commonApi;
  }

  Future<Response?> get(
    String url, {
    Options? options,
  }) async {
    Response? response;
    try {
      response = await dio.get(
        url,
        options: options ?? defOptions,
      );
    } on DioException catch (e) {}

    return response;
  }

  Future<Response?> post(
    String url, {
    Options? options,
    required Map<String, dynamic> data,
  }) async {
    Response? response;
    try {
      response = await dio.post(
        url,
        options: options ?? defOptions,
        data: data,
      );
    } catch (e) {
      log(e.toString());
    }

    return response;
  }
}
