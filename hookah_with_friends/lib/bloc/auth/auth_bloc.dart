// ignore_for_file: sort_constructors_first

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../exceptions/auth_exception.dart";
import "../../services/auth_service.dart";
import "../../services/user_service.dart";
import "../../util/locator.dart";

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = getIt.get<AuthService>();
  final UserService userService = getIt.get<UserService>();
  bool creatingUser = false;

  AuthBloc() : super(AuthUnauthenticated()) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        if (userService.currentUser == null && creatingUser == false) {
          await userService.setOrCreateCurrentUser();
        }
        add(AuthLoggedIn(user));
      } else {
        add(AuthLoggedOut());
      }
    });

    on<AuthLogin>((AuthLogin event, Emitter<AuthState> emit) async {
      emit(AuthLoading());

      try {
        await authService.login(event.email, event.password);
        await userService.setOrCreateCurrentUser();
      } on AuthException catch (ex) {
        emit(AuthUnauthenticated(statusMessage: ex.message));
      } on Error catch (err) {
        debugPrintStack(stackTrace: err.stackTrace);
        emit(AuthUnauthenticated(statusMessage: "Unknown Error occurred"));
      }
    });

    on<AuthGoogleLogin>((AuthGoogleLogin event, Emitter<AuthState> emit) async {
      emit(AuthLoading());

      try {
        await authService.googleSignIn();
        await userService.setOrCreateCurrentUser();
      } on AuthException catch (ex) {
        emit(AuthUnauthenticated(statusMessage: ex.message));
      } on Error catch (err) {
        debugPrintStack(stackTrace: err.stackTrace);
        emit(AuthUnauthenticated(statusMessage: "Unknown Error occurred"));
      }
    });

    on<AuthSignUp>((AuthSignUp event, Emitter<AuthState> emit) async {
      emit(AuthLoading());
      final String userName = event.username;

      try {
        creatingUser = true;
        await authService.signUp(event.email, event.password);
        await userService.setOrCreateCurrentUser(userName: userName);
        creatingUser = false;
      } on AuthException catch (ex) {
        emit(AuthUnauthenticated(statusMessage: ex.message));
      } on Error catch (err) {
        debugPrintStack(stackTrace: err.stackTrace);
      }
    });

    on<AuthLogout>((AuthEvent event, Emitter<AuthState> emit) async {
      await authService.logout();
    });

    on<AuthResetPassword>(
        (AuthResetPassword event, Emitter<AuthState> emit) async {
      emit(AuthLoading());
      try {
        await authService.resetPassword(event.email);
        emit(AuthUnauthenticated(
            statusMessage: "Password Reset Email successfully sent!"));
      } on AuthException catch (ex) {
        emit(AuthUnauthenticated(statusMessage: ex.message));
      } on Error catch (err) {
        debugPrintStack(stackTrace: err.stackTrace);
        emit(AuthUnauthenticated(statusMessage: "Unknown Error occurred"));
      }
    });

    on<AuthLoggedIn>((AuthLoggedIn event, Emitter<AuthState> emit) {
      emit(AuthAuthenticated());
    });

    on<AuthLoggedOut>((AuthLoggedOut event, Emitter<AuthState> emit) {
      userService.resetCurrentUser();
      emit(AuthUnauthenticated());
    });
  }
}
