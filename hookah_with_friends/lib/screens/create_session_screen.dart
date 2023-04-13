import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/pickers/time_picker_card.dart";

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  DateTime selectedDateTime = DateTime.now().add(const Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Create new Session"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TimePickerCard(
              initialDateTime: selectedDateTime,
              dateTimeChanged: (DateTime dateTime) {
                setState(() {
                  selectedDateTime = dateTime;
                });
              },
            ),
            const SizedBox(height: 24),
            PrimaryButton(text: "Create", onPress: () {}),
          ],
        ),
      ),
    );
  }
}
