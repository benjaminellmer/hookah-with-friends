import "package:flutter/material.dart";

import '../../enum/availability.dart';
import '../../util/colors.dart';

class AvailabilityIndicator extends StatelessWidget {
  const AvailabilityIndicator(this.availability, {super.key});

  final Availability availability;

  Color get color {
    switch (availability) {
      case Availability.high:
        return HWFColors.green;
      case Availability.medium:
        return HWFColors.orange;
      case Availability.low:
        return HWFColors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
