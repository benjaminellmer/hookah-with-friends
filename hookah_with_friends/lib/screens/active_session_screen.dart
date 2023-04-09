import "package:flutter/material.dart";

import "../components/back_and_title_app_bar.dart";
import "../components/primary_button.dart";
import "../components/primary_text.dart";
import "../components/session_progress_indicator.dart";
import "../components/subheading.dart";
import "../model/session.dart";
import "../util/formatters/duration_formatters.dart";

class ActiveSessionScreen extends StatelessWidget {
  const ActiveSessionScreen({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Active Session"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SubHeading("Coal Timer"),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              child: SessionProgressIndicator(
                value: session.progress,
                strokeWidth: 14,
              ),
            ),
            const SizedBox(height: 16),
            PrimaryText(
              DurationFormatters.hms(session.timeLeft),
              fontSize: 18,
            ),
            PrimaryButton(text: "Start", onPress: () {})
          ],
        ),
      ),
    );
  }
}
