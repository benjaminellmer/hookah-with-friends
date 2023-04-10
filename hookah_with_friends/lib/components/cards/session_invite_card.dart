import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../model/session.dart";
import "../../screens/session_invite_screen.dart";
import "../indicators/invitation_state_indicator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class SessionInviteCard extends StatelessWidget {
  const SessionInviteCard(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) =>
                SessionInviteScreen(session: session),
          ),
        );
      },
      child: SizedBox(
        height: 80,
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                PrimaryText("Host: ${session.host}"),
                PrimaryText(
                    "Time: ${DateFormat.Hm().format(session.startTime)}"),
                PrimaryText("Participants: ${session.participants.length}"),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InvitationStateIndicator(
                invitationState: session.invitationState,
                width: 45,
                height: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
