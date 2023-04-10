import "package:flutter/material.dart";
import "package:hookah_with_friends/components/cards/primary_card.dart";

import "../../model/tobacco.dart";
import "../../util/colors.dart";
import "../indicators/availability_indicator.dart";
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Image.asset(
                  "lib/assets/grape_white.png",
                  height: 35,
                  width: 35,
                  color: HWFColors.flavour,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Image.asset(
                  "lib/assets/mint_white.png",
                  height: 40,
                  width: 40,
                  color: HWFColors.flavour,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
