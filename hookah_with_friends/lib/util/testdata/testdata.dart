import "../../enum/availability.dart";
import "../../model/session.dart";
import "../../model/tobacco.dart";

// ignore: avoid_classes_with_only_static_members
class TestData {
  static Session activeSession = Session(
    host: "Benjamin",
    tobacco: Tobacco(
      name: "Black Nana",
      availability: Availability.high,
    ),
    participants: <String>[
      "Simon",
      "Jakob",
      "David",
    ],
    startTime: DateTime.now().subtract(const Duration(minutes: 55)),
    endTime: DateTime.now().add(const Duration(minutes: 10)),
  );
}
