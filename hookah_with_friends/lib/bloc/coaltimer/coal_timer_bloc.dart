// ignore_for_file: sort_constructors_first

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/coal_timer.dart";
import "../../util/formatters/duration_formatters.dart";

part "coal_timer_event.dart";

part "coal_timer_state.dart";

class CoalTimerBloc extends Bloc<CoalTimerEvent, CoalTimerState> {
  CoalTimer? currentCoalTimer;
  Timer? updateTimer;

  CoalTimerBloc() : super(CoalTimerInActive()) {
    on<CoalTimerStarted>(
        (CoalTimerStarted event, Emitter<CoalTimerState> emit) {
      currentCoalTimer = CoalTimer(
        start: DateTime.now(),
        end: DateTime.now().add(event.duration),
      );

      emit(CoalTimerActive(currentCoalTimer!));

      updateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(CoalTimerUpdating());
      });
    });

    on<CoalTimerStopped>(
        (CoalTimerStopped event, Emitter<CoalTimerState> emit) {
      currentCoalTimer = null;
      updateTimer?.cancel();

      emit(CoalTimerInActive());
    });

    on<CoalTimerUpdating>(
        (CoalTimerUpdating event, Emitter<CoalTimerState> emit) {
      if (currentCoalTimer != null) {
        emit(CoalTimerActive(currentCoalTimer!));
      }
    });
  }

  @override
  Future<void> close() {
    updateTimer?.cancel();
    return super.close();
  }
}
