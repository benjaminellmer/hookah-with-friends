class CoalTimer {
  CoalTimer({
    required this.startDateTime,
    required this.endDateTime,
  });

  final DateTime startDateTime;
  final DateTime endDateTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "start": startDateTime.toIso8601String(),
        "end": startDateTime.toIso8601String(),
      };
}
