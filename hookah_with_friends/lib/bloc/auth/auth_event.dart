part of "auth_bloc.dart";

@immutable
abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  AuthLogin({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthLoggedIn extends AuthEvent {
  AuthLoggedIn(this.user);

  final User user;
}

class AuthLoggedOut extends AuthEvent {}

class AuthLogout extends AuthEvent {}
