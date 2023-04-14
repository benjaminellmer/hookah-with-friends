import "package:flutter/material.dart";
import "../components/appbars/back_and_title_app_bar.dart";

class AddTobacco extends StatelessWidget {
  const AddTobacco({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Add Tobacco"),
      body: const Center(
        child: Text("This is the Add Tobacco screen"),
      ),
    );
  }
}
