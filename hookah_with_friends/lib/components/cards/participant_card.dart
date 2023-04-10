import "package:flutter/material.dart";

import "../../enum/invitation_state.dart";
import "../indicators/invitation_state_indicator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class ParticipantCard extends StatelessWidget {
  const ParticipantCard({
    super.key,
    required this.name,
    required this.invitationState,
  });

  final String name;
  final InvitationState invitationState;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Row(
        children: <Widget>[
          PrimaryText(name),
          const Spacer(),
          InvitationStateIndicator(
            invitationState: invitationState,
            width: 25,
            height: 25,
          )
        ],
      ),
    );
  }
}
