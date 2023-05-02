import "dart:convert";

import "../components/indicators/flavour_indicator.dart";
import "../enum/availability.dart";
import "../enum/flavour.dart";

class Tobacco {
  Tobacco({
    required this.name,
    required this.brand,
    this.availability = Availability.high,
    required this.flavours,
  });

  final String name;
  final Availability availability;
  final String brand;
  final List<Flavour> flavours;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "availability": availability.name,
        "brand": brand,
        "flavours": jsonEncode(flavours),
      };

  List<FlavourIndicator> get flavourIndicators {
    return flavours
        .map((Flavour flavour) => FlavourIndicator(flavour: flavour))
        .toList();
  }
}
