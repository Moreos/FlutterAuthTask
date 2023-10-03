import 'package:dio/dio.dart';
import 'package:test_task_auth/logic/api/common_api.dart';

class AuthApi {
  CommonApi commonApi = CommonApi();

  Future<Response?> authorize(String email, String password) async {
    return await commonApi.post(
      '/api/v1/auth/login', data: {
      'email': email,
      'password': password,
    }
    );
  }
}
