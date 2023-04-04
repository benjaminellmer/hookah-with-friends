import "package:flutter/material.dart";

import "../components/active_session_card.dart";
import "../components/subheading.dart";
import "../enum/availability.dart";
import "../model/session.dart";
import "../model/tobacco.dart";

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
            ActiveSessionCard(
              Session(
                host: "Benjamin",
                tobacco: Tobacco(
                  name: "Black Nana",
                  availability: Availability.high,
                ),
                participants: <String>[
                  "Simon",
                  "Jakob",
                  "David",
                ],
                startTime: DateTime.now().add(const Duration(minutes: 45)),
                endTime: DateTime.now().add(const Duration(hours: 1)),
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
