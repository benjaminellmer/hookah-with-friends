import "package:flutter/material.dart";

import "../components/primary_card.dart";
import "../components/subheading.dart";

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SubHeading("Active Sessions"),
            PrimaryCard(
              child: Column(
                children: const <Widget>[
                  Text("Host"),
                  Text("Tobacco"),
                  Text("Participants"),
                ],
              ),
            ),
            const SubHeading("Invites"),
            const SubHeading("History"),
          ],
        ),
      ),
    );
  }
}
