import "tobacco.dart";

// NOT THE FINAL MODEL!!! We will add more fields later. and the participants will become an own model
class Session {
  const Session({
    required this.host,
    required this.tobacco,
    required this.participants,
    required this.startTime,
    required this.endTime,
  });

  final String host;
  final Tobacco tobacco;
  final List<String> participants;
  final DateTime startTime;
  final DateTime endTime;

  double get progress {
    final DateTime now = DateTime.now();
    if (now.isBefore(startTime)) {
      return 0;
    }
    if (now.isAfter(endTime)) {
      return 1;
    } else {
      final Duration duration = endTime.difference(startTime);
      final Duration elapsed = now.difference(startTime);
      return elapsed.inMilliseconds / duration.inMilliseconds;
    }
  }

  Duration get timeLeft {
    final DateTime now = DateTime.now();
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return endTime.difference(now);
    } else {
      return Duration.zero;
    }
  }
}
