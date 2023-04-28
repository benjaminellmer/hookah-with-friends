part of "coal_timer_bloc.dart";

@immutable
abstract class CoalTimerState {}

class CoalTimerActive extends CoalTimerState {
  CoalTimerActive(this.coalTimer);

  final CoalTimer coalTimer;

  String get timeLeftString {
    return DurationFormatters.hms(
        coalTimer.endDateTime.difference(DateTime.now()));
  }

  double get progress {
    final DateTime now = DateTime.now();
    if (now.isBefore(coalTimer.startDateTime)) {
      return 1;
    }
    if (now.isAfter(coalTimer.endDateTime)) {
      return 0;
    } else {
      final Duration duration =
          coalTimer.endDateTime.difference(coalTimer.startDateTime);
      final Duration elapsed = now.difference(coalTimer.startDateTime);
      return 1 - elapsed.inMilliseconds / duration.inMilliseconds;
    }
  }
}

class CoalTimerInActive extends CoalTimerState {}
