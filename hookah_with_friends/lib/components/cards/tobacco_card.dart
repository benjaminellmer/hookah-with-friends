import "package:flutter/material.dart";

import "../../model/datamodel.dart";
import "../indicators/availability_indicator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class TobaccoCard extends StatelessWidget {
  const TobaccoCard({super.key, required this.tobacco});

  final Tobacco tobacco;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PrimaryText(tobacco.name, fontSize: 17),
              PrimaryText(tobacco.brand, fontSize: 14),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  PrimaryText("Availability: ", fontSize: 14),
                  const SizedBox(width: 8),
                  AvailabilityIndicator(tobacco.availability),
                ],
              ),
            ],
          ),
          const Spacer(),
          // FlavourIndicatorRow(tobacco.flavourIndicators),
        ],
      ),
    );
  }
}
