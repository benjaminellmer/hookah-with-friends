import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../enum/invitation_state.dart";
import "../../model/session.dart";
import "../../services/session_service.dart";
import "../../util/locator.dart";
import "sessions_bloc.dart";

part "session_invite_state.dart";

class SessionInviteCubit extends Cubit<SessionInviteState> {
  SessionInviteCubit(this.sessionsBloc) : super(SessionInviteInitial());

  final SessionsBloc sessionsBloc;
  final SessionService sessionService = getIt.get<SessionService>();

  Future<void> accept(final SessionLoaded session) async {
    updateInvitationState(session, InvitationState.accepted);
  }

  Future<void> decline(final SessionLoaded session) async {
    updateInvitationState(session, InvitationState.declined);
  }

  Future<void> updateInvitationState(
      final SessionLoaded session, final InvitationState state) async {
    await sessionService.updateInvitationState(session, state);

    sessionsBloc.add(SessionsRefreshInitialized());

    emit(SessionInviteFinished());
  }
}
