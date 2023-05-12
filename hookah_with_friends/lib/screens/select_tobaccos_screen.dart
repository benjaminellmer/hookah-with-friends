import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/tobacco/create_tobacco_cubit.dart";
import "../bloc/tobacco/tobaccos_cubit.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/tobacco_card.dart";
import "../components/dialogs/end_session_dialog.dart";
import "../components/texts/primary_text.dart";
import "../components/texts/subheading.dart";
import "../model/tobacco.dart";
import "../util/colors.dart";
import "create_tobacco_screen.dart";

class SelectTobaccosScreen extends StatelessWidget {
  const SelectTobaccosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(
          title: "Select new Tobacco",
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext contextWithoutBloc) =>
                    BlocProvider<TobaccosCubit>.value(
                      value: context.read<TobaccosCubit>(),
                      child: CreateTobaccoScreen(),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add, color: HWFColors.heading),
            )
          ],
      ),
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
            child: BlocProvider<TobaccosCubit>(
              create: (BuildContext context) => TobaccosCubit()..loadNewTobaccos(),
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
                            const SubHeading("Select existing Tobaccos"),
                            if (state.tobaccos.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PrimaryText(
                                    "There are currently no Tobaccos available"),
                              ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: state.tobaccos.map((Tobacco tobacco) {
                                    return InkWell(
                                      child: Padding(
                                          padding: const EdgeInsets.only(top: 8),
                                          child: TobaccoCard(tobacco: tobacco)
                                      ),
                                      onTap: () {
                                        context.read<CreateTobaccoCubit>().createTobacco(
                                          name: tobacco.name,
                                          brand: tobacco.brand,
                                          flavours: tobacco.flavours,
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            // add some space between the last TobaccoCard and the button
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
        }),
      ),
    );
  }
}
