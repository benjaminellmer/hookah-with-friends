part of "auth_bloc.dart";

@immutable
abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  AuthLogin({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthSignUp extends AuthEvent {
  AuthSignUp(
      {required this.username, required this.email, required this.password});

  final String username;
  final String email;
  final String password;
}

class AuthLoggedIn extends AuthEvent {
  AuthLoggedIn(this.user);

  final User user;
}

class AuthLoggedOut extends AuthEvent {}

class AuthLogout extends AuthEvent {}
