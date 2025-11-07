part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthUnauthenticated extends AuthState {
  AuthException authException;
  AuthUnauthenticated({required this.authException});
}

final class AuthenticationLoading extends AuthState {}

final class AuthSignUpSucess extends AuthState {}

final class Authauthenticated extends AuthState {
  final Userresponsedto user;
  const Authauthenticated({required this.user});
}
