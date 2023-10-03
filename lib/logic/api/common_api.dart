import 'dart:developer';
import 'dart:io';

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
    dio.options.baseUrl =
    'http://45.10.110.181:8080';
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
    } on DioException catch (e) {
      log(e.toString());
    }
    return response;
  }
}