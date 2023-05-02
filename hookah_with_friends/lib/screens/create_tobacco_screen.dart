import "package:flutter/material.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/indicators/flavour_indicator.dart";
import "../components/pickers/multi_element_picker.dart";
import "../components/textinputs/primary_text_input.dart";
import "../components/texts/primary_text.dart";
import "../enum/flavour.dart";

class CreateTobaccoScreen extends StatelessWidget {
  const CreateTobaccoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Create new Tobacco"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const PrimaryTextInput(label: "Name: "),
            const SizedBox(height: 8),
            const PrimaryTextInput(label: "Brand: "),
            const SizedBox(height: 8),
            MultiElementPicker<Flavour>(
              label: "Flavour: ",
              elements: flavours,
              allowSelectAll: false,
              itemBuilder: (Flavour flavour) {
                return MultiElementPickerItem(
                  title: Row(
                    children: <Widget>[
                      FlavourIndicator(
                        flavour: flavour,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 18),
                      PrimaryText(flavour.text),
                    ],
                  ),
                );
              },
              previewStyle: const TitlesMultiElementPickerPreviewStyle(),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
                text: "Create",
                onPress: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
