import "package:flutter/material.dart";

import "../components/buttons/primary_button.dart";
import "create_tobacco_screen.dart";

class TobaccosScreen extends StatelessWidget {
  const TobaccosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PrimaryButton(
      text: "Create Tobacco",
      onPress: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const CreateTobaccoScreen()),
        );
      },
    ));
  }
}
