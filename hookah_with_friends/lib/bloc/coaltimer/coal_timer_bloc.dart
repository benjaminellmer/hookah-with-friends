// ignore_for_file: sort_constructors_first

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/coal_timer.dart";
import "../../model/session.dart";
import "../../services/session_service.dart";
import "../../util/formatters/duration_formatters.dart";
import "../../util/locator.dart";

part "coal_timer_event.dart";
part "coal_timer_state.dart";

class CoalTimerBloc extends Bloc<CoalTimerEvent, CoalTimerState> {
  // CoalTimer? currentCoalTimer;
  Timer? updateTimer;
  final SessionLoaded session;
  final SessionService sessionService = getIt.get<SessionService>();

  CoalTimerBloc(this.session) : super(CoalTimerInActive()) {
    on<CoalTimerStarted>(
        (CoalTimerStarted event, Emitter<CoalTimerState> emit) async {
      session.coalTimer = CoalTimer(
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now().add(event.duration),
      );

      await sessionService.saveSession(session);
      emit(CoalTimerActive(session.coalTimer!));

      updateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(CoalTimerUpdating());
      });
    });

    on<CoalTimerLoaded>(
        (CoalTimerLoaded event, Emitter<CoalTimerState> emit) async {
      emit(CoalTimerActive(event.coalTimer));

      updateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(CoalTimerUpdating());
      });
    });

    on<CoalTimerStopped>(
        (CoalTimerStopped event, Emitter<CoalTimerState> emit) async {
      session.coalTimer = null;
      await sessionService.saveSession(session);
      updateTimer?.cancel();

      emit(CoalTimerInActive());
    });

    on<CoalTimerUpdating>(
        (CoalTimerUpdating event, Emitter<CoalTimerState> emit) {
      if (session.coalTimer != null) {
        if (DateTime.now().isAfter(session.coalTimer!.endDateTime)) {
          updateTimer = null;
          session.coalTimer = null;
        } else {
          emit(CoalTimerActive(session.coalTimer!));
        }
      }
    });

    if (session.coalTimer != null &&
        session.coalTimer!.endDateTime.isAfter(DateTime.now())) {
      add(CoalTimerLoaded(session.coalTimer!));
    }
  }

  @override
  Future<void> close() {
    updateTimer?.cancel();
    return super.close();
  }
}
