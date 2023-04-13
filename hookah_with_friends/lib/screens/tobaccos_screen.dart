import "package:flutter/material.dart";

import "../components/cards/tobacco_card.dart";
import "../components/texts/subheading.dart";
import "../util/testdata/testdata.dart";

class TobaccosScreen extends StatelessWidget {
  const TobaccosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SubHeading("Tobaccos"),
            TobaccoCard(tobacco: TestData.tobacco1,),
            TobaccoCard(tobacco: TestData.tobacco2,),
          ],
        ),
      ),
    );
  }
}
