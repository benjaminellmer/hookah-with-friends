import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/coaltimer/coal_timer_bloc.dart";
import "../bloc/session/active_session_cubit.dart";
import "../bloc/session/sessions_bloc.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/participant_card.dart";
import "../components/cards/tobacco_card.dart";
import "../components/dialogs/end_session_dialog.dart";
import "../components/indicators/session_progress_indicator.dart";
import "../components/texts/primary_text.dart";
import "../components/texts/subheading.dart";
import "../model/participant.dart";
import "../model/session.dart";
import "../util/colors.dart";

class ActiveSessionScreen extends StatelessWidget {
  const ActiveSessionScreen({super.key, required this.session});

  final SessionLoaded session;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoalTimerBloc>(
          create: (BuildContext context) => CoalTimerBloc(session),
        ),
        BlocProvider<ActiveSessionCubit>(
          create: (BuildContext context) =>
              ActiveSessionCubit(context.read<SessionsBloc>()),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: BackAndTitleAppBar(
            title: "Active Session",
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  showEndSessionDialog(context, () async {
                    context.read<ActiveSessionCubit>().endSession(session);
                    // context.read();
                  });
                },
                icon: Icon(Icons.power_settings_new, color: HWFColors.heading),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const SubHeading("Coal Timer"),
                  const SizedBox(height: 16),
                  BlocBuilder<CoalTimerBloc, CoalTimerState>(
                    builder: (BuildContext context, CoalTimerState state) {
                      if (state is CoalTimerActive) {
                        return _ActiveCoalTimerSection(state);
                      } else {
                        return const _InactiveCoalTimerSection();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const SubHeading("Current Tobacco"),
                  TobaccoCard(tobacco: session.currentTobacco),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    text: "Renew",
                    onPress: () {},
                  ),
                  const SizedBox(height: 16),
                  const SubHeading("Participants"),
                  for (Participant participant
                      in session.participants) ...<ParticipantCard>[
                    ParticipantCard(
                      participant: participant,
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _InactiveCoalTimerSection extends StatelessWidget {
  const _InactiveCoalTimerSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
          child: SessionProgressIndicator(
            value: 0,
            strokeWidth: 14,
          ),
        ),
        const SizedBox(height: 16),
        PrimaryText(
          "00:00:00",
          fontSize: 18,
        ),
        PrimaryButton(
            text: "Start",
            onPress: () {
              context
                  .read<CoalTimerBloc>()
                  .add(CoalTimerStarted(const Duration(minutes: 15)));
            })
      ],
    );
  }
}

class _ActiveCoalTimerSection extends StatelessWidget {
  const _ActiveCoalTimerSection(this.state);

  final CoalTimerActive state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
          child: SessionProgressIndicator(
            value: state.progress,
            strokeWidth: 14,
          ),
        ),
        const SizedBox(height: 16),
        PrimaryText(
          state.timeLeftString,
          fontSize: 18,
        ),
        PrimaryButton(
            text: "Stop",
            onPress: () {
              context.read<CoalTimerBloc>().add(CoalTimerStopped());
            })
      ],
    );
  }
}
