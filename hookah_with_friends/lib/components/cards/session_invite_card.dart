import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

import "../../bloc/session/sessions_bloc.dart";
import "../../model/session_invite.dart";
import "../../screens/session_invite_screen.dart";
import "../indicators/invitation_state_indicator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class SessionInviteCard extends StatelessWidget {
  const SessionInviteCard(this.invite, {super.key});

  final SessionInviteLoaded invite;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext contextWithoutBloc) =>
                BlocProvider<SessionsBloc>.value(
              value: context.read<SessionsBloc>(),
              child: SessionInviteScreen(session: invite.session),
            ),
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
                PrimaryText("Host: ${invite.session.host.userName}"),
                PrimaryText(
                    "Time: ${DateFormat.Hm().format(invite.session.startTime)}"),
                PrimaryText(
                    "Participants: ${invite.session.numberOfParticipants}"),
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
