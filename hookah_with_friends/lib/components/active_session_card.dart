import "package:flutter/material.dart";

import "../model/session.dart";
import "../util/colors.dart";
import "primary_card.dart";
import "primary_text.dart";

class ActiveSessionCard extends StatelessWidget {
  const ActiveSessionCard(this.session, {super.key});

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
                PrimaryText("Host: ${session.host}"),
                PrimaryText(session.tobacco.name),
                PrimaryText("Participants: ${session.participants.length}"),
              ],
            ),
            const Spacer(),
            IntrinsicWidth(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: 0.8,
                      strokeWidth: 8,
                      backgroundColor: const Color(0xff2f2f3d),
                      color: HWFColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryText("01:12:45"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
