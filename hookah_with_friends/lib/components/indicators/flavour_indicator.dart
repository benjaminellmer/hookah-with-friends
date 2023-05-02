import "package:flutter/material.dart";

import "../../enum/flavour.dart";
import "../../util/colors.dart";

class FlavourIndicator extends StatelessWidget {
  const FlavourIndicator({
    super.key,
    required this.flavour,
    this.width = 35,
    this.height = 35,
    this.insets = EdgeInsets.zero,
  });

  final Flavour flavour;
  final double width;
  final double height;
  final EdgeInsetsGeometry insets;

  String get assetPath {
    switch (flavour) {
      case Flavour.mint:
        return "lib/assets/mint_white.png";
      case Flavour.grape:
        return "lib/assets/grape_white.png";
      case Flavour.apple:
        return "lib/assets/apple_white.png";
      case Flavour.blueberry:
        return "lib/assets/blueberries_white.png";
      case Flavour.bonbon:
        return "lib/assets/bonbon_white.png";
      case Flavour.dragonBlood:
        return "lib/assets/dragonblood.png";
      case Flavour.dragonFruit:
        return "lib/assets/dragonfruit_white.png";
      case Flavour.fruitMix:
        return "lib/assets/fruitmix.png";
      case Flavour.melon:
        return "lib/assets/melon_white.png";
      case Flavour.passionFruit:
        return "lib/assets/passionfruit_white.png";
      case Flavour.pineapple:
        return "lib/assets/pineapple_white.png";
      case Flavour.raspberry:
        return "lib/assets/raspberry_white.png";
      case Flavour.menthol:
        return "lib/assets/snowflake_white.png";
      case Flavour.strawberry:
        return "lib/assets/strawberry_white.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: insets,
      child: Image.asset(
        assetPath,
        height: height,
        width: width,
        color: HWFColors.flavour,
      ),
    );
  }
}
