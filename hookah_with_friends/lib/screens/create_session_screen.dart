import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/date_picker_card.dart";
import "../components/pickers/element_picker.dart";
import "../components/pickers/multi_element_picker.dart";
import "../components/pickers/time_picker_card.dart";
import "../components/texts/primary_text.dart";
import "../model/tobacco.dart";
import "../util/testdata/testdata.dart";

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
            DatePickerCard(
              initialDateTime: selectedDateTime,
              dateTimeChanged: (DateTime dateTime) {
                setState(() {
                  selectedDateTime = dateTime;
                });
              },
            ),
            const SizedBox(height: 8.0),
            TimePickerCard(
              initialDateTime: selectedDateTime,
              dateTimeChanged: (DateTime dateTime) {
                setState(() {
                  selectedDateTime = dateTime;
                });
              },
            ),
            const SizedBox(height: 8),
            ElementPicker<Tobacco>(
              label: "Tobacco: ",
              elements: TestData.tobaccos,
              itemBuilder: (Tobacco tobacco) {
                return ElementPickerItem(
                  title: PrimaryText(tobacco.name),
                  subtitle: PrimaryText(
                    tobacco.brand,
                    fontSize: 12,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            MultiElementPicker<String>(
              label: "Friends: ",
              elements: TestData.friends,
              itemBuilder: (String friend) {
                return MultiElementPickerItem(
                  title: PrimaryText(friend),
                );
              },
            ),
            const SizedBox(height: 24),
            PrimaryButton(
                text: "Create",
                onPress: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
