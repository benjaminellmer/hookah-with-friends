part of "auth_bloc.dart";

@immutable
abstract class AuthState {}

class AuthUnauthenticated extends AuthState {
  AuthUnauthenticated({this.errorMessage});

  final String? errorMessage;
}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}
