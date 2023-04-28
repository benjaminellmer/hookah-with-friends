import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/session/create_session_cubit.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/date_picker_card.dart";
import "../components/pickers/element_picker.dart";
import "../components/pickers/multi_element_picker.dart";
import "../components/pickers/time_picker_card.dart";
import "../components/texts/primary_text.dart";
import "../model/tobacco.dart";
import "../model/user.dart";
import "../util/testdata/testdata.dart";

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  DateTime selectedDateTime = DateTime.now();
  Tobacco selectedTobacco = TestData.blackNana;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Create new Session"),
      body: BlocProvider<CreateSessionCubit>(
        create: (BuildContext context) => CreateSessionCubit(),
        child: BlocListener<CreateSessionCubit, CreateSessionState>(
          listener: (BuildContext context, CreateSessionState state) {
            if (state is CreateSessionSuccess) {
              const SnackBar snackBar = SnackBar(
                content: Center(
                  child: Text("Session was created"),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop();
            } else if (state is CreateSessionError) {
              final SnackBar snackBar = SnackBar(
                content: Center(
                  child: Text(state.errorMessage),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Builder(builder: (BuildContext context) {
            return Padding(
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
                        context.read<CreateSessionCubit>().createSession(
                          selectedDateTime: selectedDateTime,
                          tobacco: selectedTobacco,
                          friends: <User>[],
                        );
                      }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
