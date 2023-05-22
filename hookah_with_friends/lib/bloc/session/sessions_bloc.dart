// ignore_for_file: sort_constructors_first

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/session.dart";
import "../../model/session_invite.dart";
import "../../services/session_service.dart";
import "../../services/user_service.dart";
import "../../util/locator.dart";

part "sessions_event.dart";
part "sessions_state.dart";

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final SessionService sessionService = getIt.get<SessionService>();
  final UserService userService = getIt.get<UserService>();

  SessionsBloc() : super(SessionsLoading()) {
    on<SessionsLoadInitialized>((
      SessionsLoadInitialized event,
      Emitter<SessionsState> emit,
    ) async {
      emit(SessionsLoading());
      await userService.refreshUser();

      final SessionsResult<SessionInviteLoaded> inviteSessionsResult =
          await sessionService.loadInvites();
      final SessionsResult<Session> mySessionsResult =
          await sessionService.loadMySessions();
      final List<SessionLoaded> activeSessions = inviteSessionsResult
          .activeSessions
        ..addAll(mySessionsResult.activeSessions);

      mySessionsResult.result
          .sort((Session a, Session b) => b.startTime.compareTo(a.startTime));

      emit(SessionsLoaded(
        activeSessions,
        mySessionsResult.result,
        inviteSessionsResult.result,
      ));
    });
  }
}

class SessionsResult<T> {
  SessionsResult(this.result, this.activeSessions);

  final List<T> result;
  final List<SessionLoaded> activeSessions;
}
