import "package:flutter/material.dart";
import "package:hookah_with_friends/components/cards/primary_card.dart";

import "../../enum/flavour.dart";
import "../../model/tobacco.dart";
import "../indicators/availability_indicator.dart";
import "../indicators/flavour_indicator.dart";
import "../texts/primary_text.dart";

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
          Row(
            children: const <Widget>[
              FlavourIndicator.grape(
                insets: EdgeInsets.only(bottom: 30),
              ),
              FlavourIndicator.mint(
                insets: EdgeInsets.only(top: 30),
              ),
            ],
          )
        ],
      ),
    );
  }
}
