part of "coal_timer_bloc.dart";

@immutable
abstract class CoalTimerState {}

class CoalTimerActive extends CoalTimerState {
  CoalTimerActive(this.coalTimer);

  final CoalTimer coalTimer;

  String get timeLeftString {
    return DurationFormatters.hms(coalTimer.end.difference(DateTime.now()));
  }

  double get progress {
    final DateTime now = DateTime.now();
    if (now.isBefore(coalTimer.start)) {
      return 1;
    }
    if (now.isAfter(coalTimer.end)) {
      return 0;
    } else {
      final Duration duration = coalTimer.end.difference(coalTimer.start);
      final Duration elapsed = now.difference(coalTimer.start);
      return 1 - elapsed.inMilliseconds / duration.inMilliseconds;
    }
  }
}
class CoalTimerInActive extends CoalTimerState {}
