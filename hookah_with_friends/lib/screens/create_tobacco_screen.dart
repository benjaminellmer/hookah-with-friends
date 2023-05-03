import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/tobacco/create_tobacco_cubit.dart";
import "../bloc/tobacco/tobaccos_cubit.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/indicators/flavour_indicator.dart";
import "../components/pickers/multi_element_picker.dart";
import "../components/textinputs/primary_text_input.dart";
import "../components/texts/primary_text.dart";
import "../enum/flavour.dart";

class CreateTobaccoScreen extends StatelessWidget {
  CreateTobaccoScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final MultiElementPickerController<Flavour> flavoursController =
      MultiElementPickerController<Flavour>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Create new Tobacco"),
      body: BlocProvider<CreateTobaccoCubit>(
        create: (BuildContext context) => CreateTobaccoCubit(),
        child: Builder(builder: (BuildContext context) {
          return BlocListener<CreateTobaccoCubit, CreateTobaccoState>(
            listener: (BuildContext context, CreateTobaccoState state) {
              if (state is CreateTobaccoEditing && state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: Text(state.errorMessage!)),
                  ),
                );
              }
              if (state is CreateTobaccoSuccess) {
                context.read<TobaccosCubit>().loadTobaccos();
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  PrimaryTextInput(label: "Name: ", controller: nameController),
                  const SizedBox(height: 8),
                  PrimaryTextInput(
                      label: "Brand: ", controller: brandController),
                  const SizedBox(height: 8),
                  MultiElementPicker<Flavour>(
                    label: "Flavour: ",
                    elements: flavours,
                    allowSelectAll: false,
                    controller: flavoursController,
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
                        context.read<CreateTobaccoCubit>().createTobacco(
                              name: nameController.text,
                              brand: brandController.text,
                              flavours: flavoursController.currentSelection,
                            );
                      })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
