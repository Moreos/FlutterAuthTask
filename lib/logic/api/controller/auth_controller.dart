import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_auth/logic/api/auth_api.dart';
import 'package:test_task_auth/logic/model/user_model.dart';

class AuthController {
  AuthApi api = AuthApi();

  Future<Response?> authorize(String email, String password) async {
    Response? response = await api.authorize(email, password);


    if (response != null) {
    //   return User.fromMap(response.data['user']);
      log(response.toString());
      return response;
    }
      return null;
    // }
  }
}
