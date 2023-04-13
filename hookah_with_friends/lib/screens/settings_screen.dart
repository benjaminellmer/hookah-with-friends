import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Settings"),
      body: const Center (
        child: Text("Settings"),
      ),
    );
  }

}