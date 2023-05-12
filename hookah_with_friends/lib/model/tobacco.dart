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

  factory Tobacco.fromJson(Map<String, dynamic> json) {
    return Tobacco(
      name: json["name"] as String,
      availability: Availability.fromJson(json["availability"] as String),
      brand: json["brand"] as String,
      flavours: Flavour.decodeList(json["flavours"] as String),
    );
  }

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

class TobaccoLoaded extends Tobacco {
  TobaccoLoaded({required Tobacco tobacco, required this.documentId})
      : super(
          name: tobacco.name,
          flavours: tobacco.flavours,
          availability: tobacco.availability,
          brand: tobacco.brand,
        );

  final String documentId;
}
