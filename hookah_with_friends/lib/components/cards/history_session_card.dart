import "package:flutter/material.dart";
import "package:intl/intl.dart";

import '../../model/session.dart';
import '../../util/colors.dart';
import '../../util/formatters/duration_formatters.dart';
import 'primary_card.dart';
import '../texts/primary_text.dart';
import '../indicators/session_progress_indicator.dart';

class HistorySessionCard extends StatelessWidget {
  const HistorySessionCard(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                PrimaryText(
                    "Date: ${DateFormat("dd.MM.yyyy").format(session.startTime)}"),
                PrimaryText(
                    "Tobaccos: ${session.tobaccoCount}"),
                PrimaryText("Participants: ${session.numberOfParticipants}"),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: SizedBox(
                width: 70,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: SessionProgressIndicator(
                        value: session.progress,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PrimaryText(DurationFormatters.hms(session.totalDuration)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
