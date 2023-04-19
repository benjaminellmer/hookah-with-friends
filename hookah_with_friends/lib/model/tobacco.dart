import "../components/indicators/flavour_indicator.dart";
import "../enum/availability.dart";

// NOT THE FINAL MODEL!!! We will add more fields later.
class Tobacco {
  Tobacco({
    required this.name,
    required this.brand,
    this.availability = Availability.high,
    required this.flavourIndicators,
  });

  final String name;
  final Availability availability;
  final String brand;
  final List<FlavourIndicator> flavourIndicators;
}
