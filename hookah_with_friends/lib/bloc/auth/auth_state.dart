part of "auth_bloc.dart";

@immutable
abstract class AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {}
