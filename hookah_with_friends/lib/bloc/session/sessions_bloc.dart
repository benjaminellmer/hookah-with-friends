// ignore_for_file: sort_constructors_first

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/session.dart";
import "../../model/session_invite.dart";
import "../../services/session_service.dart";
import "../../util/locator.dart";

part "sessions_event.dart";
part "sessions_state.dart";

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final SessionService sessionService = getIt.get<SessionService>();

  SessionsBloc() : super(SessionsLoading()) {
    on<SessionsLoadInitialized>((
      SessionsLoadInitialized event,
      Emitter<SessionsState> emit,
    ) async {
      emit(SessionsLoading());

      final inviteSessions = await sessionService.loadInvites();
      debugPrint(inviteSessions.toString());

      emit(SessionsLoaded([], [], inviteSessions));
    });
  }
}
