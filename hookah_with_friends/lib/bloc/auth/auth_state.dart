part of "auth_bloc.dart";

@immutable
abstract class AuthState {}

class AuthUnauthenticated extends AuthState {
  AuthUnauthenticated({this.statusMessage});

  final String? statusMessage;
}

class AuthLoading extends AuthState {}

class AuthRequireUsername extends AuthState {}

class AuthAuthenticated extends AuthState {}
