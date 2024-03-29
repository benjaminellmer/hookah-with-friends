import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/tobacco/tobaccos_cubit.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/tobacco_card.dart";
import "../components/dialogs/delete_tobacco.dart";
import "../components/texts/primary_text.dart";
import "../components/texts/subheading.dart";
import "../model/tobacco.dart";
import "../services/tobacco_service.dart";
import "../util/locator.dart";
import "select_tobaccos_screen.dart";

class TobaccosScreen extends StatelessWidget {
  const TobaccosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TobaccosCubit>(
        create: (BuildContext context) => TobaccosCubit()..loadTobaccos(),
        child: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<TobaccosCubit, TobaccosState>(
              builder: (BuildContext context, TobaccosState state) {
                if (state is TobaccosLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TobaccosLoadSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SubHeading("Tobaccos"),
                      if (state.tobaccos.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PrimaryText(
                              "You currently have not tobaccos stored"),
                        ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                state.tobaccos.map((TobaccoLoaded tobacco) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Dismissible(
                                  key: Key(tobacco.name),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    child: const Icon(Icons.delete),
                                  ),
                                  confirmDismiss: (direction) async {
                                    // Show a dialog asking the user to confirm the action
                                    return await showDialog(
                                      context: context,
                                      builder:
                                          (BuildContext contextWithoutBloc) {
                                        return BlocProvider<
                                            TobaccosCubit>.value(
                                          value: context.read<TobaccosCubit>(),
                                          child: DeleteTobaccoDialog(
                                            tobacco: tobacco.name,
                                            onConfirm: () async {
                                              final cubit =
                                                  context.read<TobaccosCubit>();
                                              getIt
                                                  .get<TobaccoService>()
                                                  .deleteTobacco(
                                                      tobacco: tobacco);
                                              await cubit.loadTobaccos();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: TobaccoCard(tobacco: tobacco),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // add some space between the last TobaccoCard and the button
                      Builder(builder: (BuildContext contextWithBloc) {
                        return PrimaryButton(
                          text: "Add Tobacco",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                builder: (BuildContext contextWithoutBloc) =>
                                    BlocProvider<TobaccosCubit>.value(
                                  value: contextWithBloc.read<TobaccosCubit>(),
                                  child: SelectTobaccosScreen(),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Unknown Error occured"),
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
