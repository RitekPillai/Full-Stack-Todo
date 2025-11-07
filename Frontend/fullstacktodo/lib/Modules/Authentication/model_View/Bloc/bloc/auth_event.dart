part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthAppStarted extends AuthEvent {}

class AuthAppLoginRequest extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthAppLoginRequest({
    required this.username,
    required this.email,
    required this.password,
  });
}

class AuthAppSignUpRequest extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthAppSignUpRequest({
    required this.username,
    required this.email,
    required this.password,
  });
}

class AuthTokenRequest extends AuthEvent {}
