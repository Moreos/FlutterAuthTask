import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_task_auth/logic/api/controller/auth_controller.dart';
import 'package:test_task_auth/logic/model/user_model.dart';
import 'package:test_task_auth/tools/app_router.gr.dart';

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

    User? user = await authController.authorize(event.email, event.password);

    if (user == null) {
      emit(AuthFailed());
      return;
    }

    emit(AuthComplete(user: user));
  }

  FutureOr<void> authLogout(AuthLogout event, emit) {
    emit(AuthInitial());
  }
}
