part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSendData extends AuthEvent {
  final String email;
  final String password;

  AuthSendData({required this.email, required this.password});
}

class AuthLogout extends AuthEvent {}
