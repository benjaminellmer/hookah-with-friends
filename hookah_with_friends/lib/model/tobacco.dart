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

  List<FlavourIndicator> get flavourIndicators {
    return flavours.map((Flavour flavour) => flavour.getIndicator()).toList();
  }
}
