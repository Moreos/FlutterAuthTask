part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLogIn extends AuthState {}

class AuthSignUp extends AuthState {}

class AuthSendResponse extends AuthState {}

class AuthCheckResult extends AuthState {}

class AuthComplete extends AuthState {
  final User user;

  AuthComplete({required this.user});
}

class AuthFailed extends AuthState {}

class AuthConnectionLost extends AuthState {}

class AuthBadResponse extends AuthState {}
