import "package:flutter/material.dart";

import "../components/buttons/primary_button.dart";
import "../components/cards/tobacco_card.dart";
import "../components/texts/subheading.dart";
import "../util/testdata/testdata.dart";
import "create_tobacco_screen.dart";
import "add_tobacco.dart";

class TobaccosScreen extends StatelessWidget {
  const TobaccosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SubHeading("Tobaccos"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TobaccoCard(tobacco: TestData.tobacco1),
                    const SizedBox(height: 8),
                    TobaccoCard(tobacco: TestData.tobacco2),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // add some space between the last TobaccoCard and the button
            PrimaryButton(
              text: "Add Tobacco",
              onPress: () {
                Navigator.push(
                  context,MaterialPageRoute<Widget>(
                    builder: (BuildContext context) =>
                    const AddTobacco())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
