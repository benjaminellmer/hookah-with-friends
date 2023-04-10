import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/coaltimer/coal_timer_bloc.dart";
import "../components/back_and_title_app_bar.dart";
import "../components/primary_button.dart";
import "../components/primary_text.dart";
import "../components/session_progress_indicator.dart";
import "../components/subheading.dart";
import "../model/session.dart";

class ActiveSessionScreen extends StatelessWidget {
  const ActiveSessionScreen({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoalTimerBloc>(
      create: (BuildContext context) => CoalTimerBloc(),
      child: Scaffold(
        appBar: BackAndTitleAppBar(title: "Active Session"),
        body: Padding(
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
            ],
          ),
        ),
      ),
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
