import "package:flutter/material.dart";
import "package:intl/intl.dart";

import '../../enum/invitation_state.dart';
import '../../model/session.dart';
import '../../util/colors.dart';
import 'primary_card.dart';
import '../texts/primary_text.dart';

class SessionInviteCard extends StatelessWidget {
  const SessionInviteCard(this.session, {super.key});

  final Session session;

  Widget get stateIndicatorImage {
    switch (session.invitationState) {
      case InvitationState.unknown:
        return Image.asset("lib/assets/question_orange.png", width: 45, height: 45);
      case InvitationState.accepted:
        return Image.asset("lib/assets/checkmark.png", color: HWFColors.green, width: 45, height: 45);
      case InvitationState.declined:
        return Image.asset("lib/assets/cross.png", color: HWFColors.red, width: 45, height: 45);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onTap: () {  },
      child: Container(
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
              child: stateIndicatorImage,
            ),
          ],
        ),
      ),
    );
  }
}
