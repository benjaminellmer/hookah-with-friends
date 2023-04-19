import "package:flutter/material.dart";

import "../../enum/flavour.dart";
import "../../util/colors.dart";
import "../indicators/flavour_indicator.dart";

class FlavourIndicatorRow extends StatelessWidget {

  const FlavourIndicatorRow(this.flavourIndicators, {super.key});
  final List<FlavourIndicator> flavourIndicators;

  @override
  Widget build(BuildContext context) {
    final List<FlavourIndicator> displayedIndicators = flavourIndicators.take(4).toList();
    switch (displayedIndicators.length) {
      case 1:
        return displayedIndicators.first;
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: displayedIndicators,
        );
      case 3:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            displayedIndicators[0],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: displayedIndicators.sublist(1),
            ),
          ],
        );
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: displayedIndicators.sublist(0, 2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: displayedIndicators.sublist(2),
            ),
          ],
        );
        return Row(
          children: displayedIndicators,
        );
    }
  }
}

