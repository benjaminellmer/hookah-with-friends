import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_gif/flutter_gif.dart";

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

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({super.key, required this.session});

  final SessionLoaded session;

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> with TickerProviderStateMixin{
  late FlutterGifController coalController;

  @override
  void initState() {
    coalController = FlutterGifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoalTimerBloc>(
          create: (BuildContext context) => CoalTimerBloc(widget.session),
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
                    context.read<ActiveSessionCubit>().endSession(widget.session);
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
                  Stack(
                    children: [
                      Container(
                        alignment: const Alignment(0, 0.8),
                        height: 100,
                        child: GifImage(
                          controller: coalController,
                          image: const AssetImage("lib/assets/coal.gif", ),
                          height: 90,
                        ),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<CoalTimerBloc, CoalTimerState>(
                        builder: (BuildContext context, CoalTimerState state) {
                          if (state is CoalTimerActive) {
                            return _ActiveCoalTimerSection(state, coalController);
                          } else {
                            return  _InactiveCoalTimerSection(coalController);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SubHeading("Current Tobacco"),
                  TobaccoCard(tobacco: widget.session.currentTobacco),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    text: "Renew",
                    onPress: () {},
                  ),
                  const SizedBox(height: 16),
                  const SubHeading("Participants"),
                  for (Participant participant
                      in widget.session.participants) ...<ParticipantCard>[
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
  const _InactiveCoalTimerSection(this.coalController);

  final FlutterGifController coalController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
          child: SessionProgressIndicator(
            value: 0,
            strokeWidth: 18,
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
              coalController.animateTo(55, duration: const Duration(milliseconds: 2000));
            })
      ],
    );
  }
}

class _ActiveCoalTimerSection extends StatelessWidget {
  const _ActiveCoalTimerSection(this.state, this.coalController);

  final CoalTimerActive state;
  final FlutterGifController coalController;

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
              coalController.animateTo(0, duration: const Duration(milliseconds: 1500));
            })
      ],
    );
  }
}
