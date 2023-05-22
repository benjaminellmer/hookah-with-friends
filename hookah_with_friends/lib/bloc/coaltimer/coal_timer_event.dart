part of "coal_timer_bloc.dart";

@immutable
abstract class CoalTimerEvent {}

class CoalTimerStarted extends CoalTimerEvent {
  CoalTimerStarted(this.duration);

  final Duration duration;
}

class CoalTimerStopped extends CoalTimerEvent {}

class CoalTimerUpdating extends CoalTimerEvent {}

class CoalTimerLoaded extends CoalTimerEvent {
  CoalTimerLoaded(this.coalTimer);

  final CoalTimer coalTimer;
}
