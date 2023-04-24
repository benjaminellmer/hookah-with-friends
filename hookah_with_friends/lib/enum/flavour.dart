import "../components/indicators/flavour_indicator.dart";

enum Flavour { mint, grape }

extension FlavourExtensions on Flavour {
  FlavourIndicator getIndicator() {
    switch (this) {
      case Flavour.mint:
        return const FlavourIndicator.mint();
      case Flavour.grape:
        return const FlavourIndicator.grape();
    }
  }
}
