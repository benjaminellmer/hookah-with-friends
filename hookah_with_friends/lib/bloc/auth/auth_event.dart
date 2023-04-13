part of "auth_bloc.dart";

@immutable
abstract class AuthEvent {}

class AuthLogin extends AuthEvent {}

class AuthLogout extends AuthEvent {}
