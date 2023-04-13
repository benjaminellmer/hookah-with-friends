import "package:flutter/material.dart";

import "../../enum/flavour.dart";
import "../../util/colors.dart";

class FlavourIndicator extends StatelessWidget {
  const FlavourIndicator({
    super.key,
    required this.flavour,
    required this.width,
    required this.height,
    this.insets = EdgeInsets.zero,
  });

  const FlavourIndicator.mint({
    Key? key,
    EdgeInsetsGeometry? insets,
  }) : this(
            flavour: Flavour.mint,
            width: 40,
            height: 40,
            insets: insets ?? EdgeInsets.zero,
            key: key);

  const FlavourIndicator.grape({
    Key? key,
    EdgeInsetsGeometry? insets,
  }) : this(
      flavour: Flavour.grape,
      width: 35,
      height: 35,
      insets: insets ?? EdgeInsets.zero,
      key: key);

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
