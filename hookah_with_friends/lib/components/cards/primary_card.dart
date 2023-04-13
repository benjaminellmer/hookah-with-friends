import "package:flutter/material.dart";

import "hwf_card.dart";

class PrimaryCard extends HWFCard {
  const PrimaryCard({super.key, required super.child, super.onTap})
      : super(
          insets: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        );
}
