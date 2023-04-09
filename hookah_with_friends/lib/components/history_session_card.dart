import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../model/session.dart";
import "../util/colors.dart";
import "../util/formatters/duration_formatters.dart";
import "primary_card.dart";
import "primary_text.dart";

class HistorySessionCard extends StatelessWidget {
  const HistorySessionCard(this.session, {super.key});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      onTap: () {  },
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
                PrimaryText("Participants: ${session.participants.length}"),
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
                      child: CircularProgressIndicator(
                        value: session.progress,
                        strokeWidth: 8,
                        backgroundColor: const Color(0xff2f2f3d),
                        color: HWFColors.text,
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
