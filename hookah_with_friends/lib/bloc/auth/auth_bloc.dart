// ignore_for_file: sort_constructors_first

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../exceptions/auth_exception.dart";
import "../../services/auth_service.dart";
import "../../util/locator.dart";

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = getIt.get<AuthService>();

  AuthBloc() : super(AuthUnauthenticated()) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        add(AuthLoggedIn(user));
      } else {
        add(AuthLoggedOut());
      }
    });

    on<AuthLogin>((AuthLogin event, Emitter<AuthState> emit) async {
      emit(AuthLoading());

      try {
        await authService.googleSignIn();
        // await authService.login(event.email, event.password);
      } on AuthException catch (ex) {
        emit(AuthUnauthenticated(statusMessage: ex.message));
      } on Error {
        emit(AuthUnauthenticated(statusMessage: "Unknown Error occured"));
      }
    });

    on<AuthGoogleLogin>((AuthGoogleLogin event, Emitter<AuthState> emit) {
      emit(AuthLoading());

      try {} on AuthException catch (ex) {
        emit(AuthUnauthenticated(statusMessage: ex.message));
      }
    });

    on<AuthSignUp>((AuthSignUp event, Emitter<AuthState> emit) async {
      emit(AuthLoading());

      try {
        await authService.signUp(event.email, event.password);
      } on AuthException catch (ex) {
        emit(AuthUnauthenticated(statusMessage: ex.message));
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
      }
    });

    on<AuthLoggedIn>((AuthLoggedIn event, Emitter<AuthState> emit) {
      emit(AuthAuthenticated());
    });

    on<AuthLoggedOut>((AuthLoggedOut event, Emitter<AuthState> emit) {
      emit(AuthUnauthenticated());
    });
  }
}
