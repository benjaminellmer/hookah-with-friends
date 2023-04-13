import "package:flutter/material.dart";

import "hwf_card.dart";

class SmallCard extends HWFCard {
  const SmallCard({super.key, required super.child, super.onTap})
      : super(
          insets: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        );
}
