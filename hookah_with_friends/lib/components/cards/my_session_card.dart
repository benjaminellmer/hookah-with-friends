import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../../model/session.dart";
import "../indicators/availability_indicator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class MySessionCard extends StatelessWidget {
  const MySessionCard(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: SizedBox(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                PrimaryText(
                    "Date: ${DateFormat("dd.MM.yyyy").format(session.startTime)}"),
                const Spacer(),
                PrimaryText(
                    "Start ${DateFormat("HH:mm").format(session.startTime)}"),
              ],
            ),
            Row(
              children: <Widget>[
                PrimaryText(session.currentTobacco.name),
                const SizedBox(width: 8),
                AvailabilityIndicator(session.currentTobacco.availability),
              ],
            ),
            PrimaryText("Participants: ${session.numberOfParticipants}"),
          ],
        ),
      ),
    );
  }
}
