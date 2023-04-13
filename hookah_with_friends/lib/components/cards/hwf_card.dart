import "package:flutter/material.dart";

import '../../util/colors.dart';

class HWFCard extends StatelessWidget {
  const HWFCard({
    super.key,
    required this.child,
    this.onTap,
    required this.insets,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry insets;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: HWFColors.cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: insets,
            child: child,
          ),
        ),
      ),
    );
  }
}
