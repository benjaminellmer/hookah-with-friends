import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/cards/history_session_card.dart";
import "../model/datamodel.dart";
import "../util/testdata/testdata.dart";

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "History"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              for (Session session
                  in TestData.historySessionList) ...<HistorySessionCard>[
                HistorySessionCard(session),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
