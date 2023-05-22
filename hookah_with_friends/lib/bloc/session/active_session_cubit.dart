import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/session.dart";
import "../../services/session_service.dart";
import "../../util/locator.dart";
import "sessions_bloc.dart";

part "active_session_state.dart";

class ActiveSessionCubit extends Cubit<ActiveSessionState> {
  ActiveSessionCubit(this.sessionsBloc) : super(ActiveSessionInitial());

  final SessionsBloc sessionsBloc;

  Future<void> endSession(final SessionLoaded session) async {
    await getIt.get<SessionService>().endSession(session);

    sessionsBloc.add(SessionsRefreshInitialized());

    emit(ActiveSessionFinished());
  }
}
