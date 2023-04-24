import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/cards/participant_card.dart";
import "../components/cards/primary_card.dart";
import "../components/cards/tobacco_card.dart";
import "../components/indicators/invitation_state_indicator.dart";
import "../components/texts/subheading.dart";
import "../enum/invitation_state.dart";
import "../model/datamodel.dart";
import "../model/participant.dart";

class SessionInviteScreen extends StatelessWidget {
  const SessionInviteScreen({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Session Invite"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SubHeading("Tobacco"),
            TobaccoCard(tobacco: session.currentTobacco),
            const SizedBox(height: 16),
            const SubHeading("Participants"),
            for (Participant participant
                in session.participants) ...<ParticipantCard>[
              ParticipantCard(
                participant: participant,
              ),
            ],
            const Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: PrimaryCard(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const InvitationStateIndicator(
                      invitationState: InvitationState.declined,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryCard(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const InvitationStateIndicator(
                      invitationState: InvitationState.accepted,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
