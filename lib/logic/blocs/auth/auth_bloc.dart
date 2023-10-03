import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:test_task_auth/logic/api/controller/auth_controller.dart';
import 'package:test_task_auth/logic/model/user_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthController authController = AuthController();

  AuthBloc() : super(AuthInitial()) {
    on<AuthSendData>(authSendData);
    on<AuthLogout>(authLogout);
  }

  FutureOr<void> authSendData(AuthSendData event, emit) async {
    emit(AuthSendResponse());

    Response? response =
        await authController.authorize(event.email, event.password);

    if (response == null) {
      emit(AuthConnectionLost());
      return;
    }
    if (response.data['name'] == 'BAD_REQUEST') {
      emit(AuthFailed());
      return;
    }
    User user = User.fromMap(response.data['user']);

    emit(AuthComplete(user: user));
  }

  FutureOr<void> authLogout(AuthLogout event, emit) {
    emit(AuthInitial());
  }
}
