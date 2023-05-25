import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/session.dart";
import "../../model/tobacco.dart";
import "../../services/session_service.dart";
import "../../services/tobacco_service.dart";
import "../../util/locator.dart";
import "sessions_bloc.dart";

part "active_session_state.dart";

class ActiveSessionCubit extends Cubit<ActiveSessionState> {
  ActiveSessionCubit(this.sessionsBloc, {required SessionLoaded session})
      : super(ActiveSessionLoaded(session));

  final SessionsBloc sessionsBloc;

  Future<void> endSession(final SessionLoaded session) async {
    await getIt.get<SessionService>().endSession(session);

    sessionsBloc.add(SessionsRefreshInitialized());

    emit(ActiveSessionFinished());
  }

  Future<void> requestRenewTobacco(SessionLoaded session) async {
    final List<TobaccoLoaded> tobaccos =
        await getIt.get<TobaccoService>().getTobaccosForUser();

    emit(ActiveSessionLoadedRenewTobacco(session, availableTobaccos: tobaccos));
  }

  Future<void> renewTobacco(
      final SessionLoaded session, final Tobacco newTobacco) async {
    final SessionLoaded newSession = await getIt
        .get<SessionService>()
        .renewTobacco(session: session, newTobacco: newTobacco);

    sessionsBloc.add(SessionsRefreshInitialized());

    emit(ActiveSessionLoaded(newSession));
  }
}
