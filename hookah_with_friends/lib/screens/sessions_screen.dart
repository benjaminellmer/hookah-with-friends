import "package:flutter/material.dart";

import "../components/active_session_card.dart";
import "../components/history_session_card.dart";
import "../components/session_invite_card.dart";
import "../components/subheading.dart";
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
            SessionInviteCard(TestData.inviteSession1),
            const SizedBox(height: 8),
            SessionInviteCard(TestData.inviteSession2),
            const SubHeading("History"),
            HistorySessionCard(TestData.historySession),
          ],
        ),
      ),
    );
  }
}
