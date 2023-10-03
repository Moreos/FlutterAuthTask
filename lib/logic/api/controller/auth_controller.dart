import 'package:dio/dio.dart';
import 'package:test_task_auth/logic/api/auth_api.dart';
import 'package:test_task_auth/logic/model/user_model.dart';

class AuthController {
  AuthApi api = AuthApi();

  Future<User?> authorize(String email, String password) async {
    Response? response = await api.authorize(email, password);

    if (response != null) {
      return User.fromMap(response.data['user']);
    } else {
      return null;
    }
  }
}
