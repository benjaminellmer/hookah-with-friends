import "package:flutter/material.dart";

import "../../model/participant.dart";
import "../../util/colors.dart";
import "../indicators/invitation_state_indicator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class ParticipantCard extends StatelessWidget {
  const ParticipantCard({
    super.key,
    required this.participant,
  });

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Row(
        children: <Widget>[
          PrimaryText(participant.userName),
          const Spacer(),
          if (participant.isHost)
            Icon(
              Icons.home,
              color: HWFColors.heading,
              size: 25,
            )
          else
            InvitationStateIndicator(
              invitationState: participant.invitationState,
              width: 25,
              height: 25,
            )
        ],
      ),
    );
  }
}
