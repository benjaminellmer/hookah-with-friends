import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthUnauthenticated()) {
    on<AuthLogin>((AuthEvent event, Emitter<AuthState> emit) {
      emit(AuthAuthenticated());
    });

    on<AuthLogout>((AuthEvent event, Emitter<AuthState> emit) {
      emit(AuthUnauthenticated());
    });
  }
}
