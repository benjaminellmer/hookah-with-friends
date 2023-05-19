import "package:flutter/material.dart";

import "../components/cards/active_session_card.dart";
import "../components/cards/history_session_card.dart";
import "../components/texts/subheading.dart";
import "../util/testdata/testdata.dart";

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
            ActiveSessionCard(TestData.activeSession),
            const SubHeading("Invites"),
            // SessionInviteCard(TestData.sessionInvite1),
            const SizedBox(height: 8),
            // SessionInviteCard(TestData.sessionInvite2),
            const SubHeading("History"),
            HistorySessionCard(TestData.historySession1),
          ],
        ),
      ),
    );
  }
}
