import "package:flutter/material.dart";

import "../components/back_and_title_app_bar.dart";
import "../components/subheading.dart";
import "../model/session.dart";

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
          children: const <Widget>[
            SubHeading("Coal Timer"),
          ],
        ),
      ),
    );
  }
}
