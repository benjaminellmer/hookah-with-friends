import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/session/create_session_cubit.dart";
import "../bloc/session/sessions_bloc.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/date_picker_card.dart";
import "../components/dialogs/error_create_session_dialog.dart";
import "../components/pickers/element_picker.dart";
import "../components/pickers/multi_element_picker.dart";
import "../components/pickers/time_picker_card.dart";
import "../components/texts/primary_text.dart";
import "../model/tobacco.dart";
import "../model/user.dart";
import "invites_screen.dart";

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key});

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  DateTime selectedDateTime = DateTime.now();
  MultiElementPickerController<User> friendsController =
      MultiElementPickerController<User>();
  ElementPickerController<Tobacco> tobaccoController =
      ElementPickerController<Tobacco>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Create new Session"),
      body: BlocProvider<CreateSessionCubit>(
        create: (BuildContext context) => CreateSessionCubit()..loadData(),
        child: BlocListener<CreateSessionCubit, CreateSessionState>(
          listener: (BuildContext context, CreateSessionState state) {
            if (state is CreateSessionSuccess) {
              const SnackBar snackBar = SnackBar(
                content: Center(
                  child: Text("Session was created"),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              context.read<SessionsBloc>().add(SessionsLoadInitialized());
              Navigator.of(context).pop();
            } else if (state is CreateSessionError) {
              if (state.isCritical) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      ErrorCreateSessionDialog(message: state.errorMessage),
                );
              } else {
                final SnackBar snackBar = SnackBar(
                  content: Center(
                    child: Text(state.errorMessage),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else if (state is CreateSessionLoaded) {
              if (state.errorMessage != null) {
                final SnackBar snackBar = SnackBar(
                  content: Center(
                    child: Text(state.errorMessage!),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
          child: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<CreateSessionCubit, CreateSessionState>(
                builder: (BuildContext context, CreateSessionState state) {
                  if (state is CreateSessionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CreateSessionLoaded) {
                    return Column(
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
                          elements: state.tobaccos,
                          controller: tobaccoController,
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
                        MultiElementPicker<User>(
                          label: "Friends: ",
                          controller: friendsController,
                          elements: state.friends,
                          itemBuilder: (User user) {
                            return MultiElementPickerItem(
                              title: PrimaryText(user.userName),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                            text: "Create",
                            onPress: () {
                              context.read<CreateSessionCubit>().createSession(
                                    selectedDateTime: selectedDateTime,
                                    tobacco: tobaccoController.currentSelection,
                                    friends: friendsController.currentSelection,
                                  );
                            }),
                      ],
                    );
                  } else if (state is CreateSessionError && state.isCritical) {
                    return Container();
                  } else {
                    return ErrorRetryButton(
                        message: "Error Loading Tobaccos and Friends ",
                        onPress: () {
                          context.read<CreateSessionCubit>().loadData();
                        });
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
