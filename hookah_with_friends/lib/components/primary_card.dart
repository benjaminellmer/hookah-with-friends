import "package:flutter/material.dart";

import "../util/colors.dart";

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({super.key, required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

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
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            child: child,
          ),
        ),
      ),
    );
  }
}
