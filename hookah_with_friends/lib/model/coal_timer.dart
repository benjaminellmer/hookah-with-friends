class CoalTimer {
  CoalTimer({
    required this.startDateTime,
    required this.endDateTime,
  });

  factory CoalTimer.fromJson(Map<String, dynamic> json) {
    return CoalTimer(
      startDateTime: DateTime.parse(json["start"] as String),
      endDateTime: DateTime.parse(json["end"] as String),
    );
  }

  final DateTime startDateTime;
  final DateTime endDateTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "start": startDateTime.toIso8601String(),
        "end": endDateTime.toIso8601String(),
      };
}
