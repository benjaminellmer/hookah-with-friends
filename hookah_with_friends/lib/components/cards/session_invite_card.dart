import "package:flutter/material.dart";

import "../../model/session_invite.dart";
import "../../screens/session_invite_screen.dart";
import "../indicators/invitation_state_indicator.dart";
import "primary_card.dart";

class SessionInviteCard extends StatelessWidget {
  const SessionInviteCard(this.invite, {super.key});

  final SessionInvite invite;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) =>
                SessionInviteScreen(session: invite.session),
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
                // PrimaryText("Host: ${invite.session.host.userName}"),
                // PrimaryText(
                //     "Time: ${DateFormat.Hm().format(invite.session.startTime)}"),
                // PrimaryText(
                //     "Participants: ${invite.session.numberOfParticipants}"),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InvitationStateIndicator(
                invitationState: invite.invitationState,
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
