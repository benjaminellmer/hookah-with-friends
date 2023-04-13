import "../enum/availability.dart";

// NOT THE FINAL MODEL!!! We will add more fields later.
class Tobacco {
  Tobacco({required this.name, required this.availability, required this.brand});

  final String name;
  final Availability availability;
  final String brand;
}
