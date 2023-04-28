import "../components/indicators/flavour_indicator.dart";

enum Flavour {
  mint,
  grape;

  String toJson() => name;

  FlavourIndicator getIndicator() {
    switch (this) {
      case Flavour.mint:
        return const FlavourIndicator.mint();
      case Flavour.grape:
        return const FlavourIndicator.grape();
    }
  }
}
