import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/session/session_invite_cubit.dart";
import "../bloc/session/sessions_bloc.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/cards/participant_card.dart";
import "../components/cards/primary_card.dart";
import "../components/cards/tobacco_card.dart";
import "../components/indicators/invitation_state_indicator.dart";
import "../components/texts/subheading.dart";
import "../enum/invitation_state.dart";
import "../model/participant.dart";
import "../model/session.dart";

class SessionInviteScreen extends StatelessWidget {
  const SessionInviteScreen({super.key, required this.session});

  final SessionLoaded session;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionInviteCubit>(
      create: (BuildContext context) =>
          SessionInviteCubit(context.read<SessionsBloc>()),
      child: Builder(builder: (BuildContext context) {
        return BlocListener<SessionInviteCubit, SessionInviteState>(
          listener: (BuildContext context, SessionInviteState state) {
            if (state is SessionInviteFinished) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: BackAndTitleAppBar(title: "Session Invite"),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const SubHeading("Tobacco"),
                  TobaccoCard(tobacco: session.currentTobacco),
                  const SizedBox(height: 16),
                  const SubHeading("Participants"),
                  for (Participant participant
                      in session.participants) ...<ParticipantCard>[
                    ParticipantCard(
                      participant: participant,
                    ),
                  ],
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: PrimaryCard(
                          onTap: () {
                            context.read<SessionInviteCubit>().decline(session);
                          },
                          child: const InvitationStateIndicator(
                            invitationState: InvitationState.declined,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PrimaryCard(
                          onTap: () {
                            context.read<SessionInviteCubit>().accept(session);
                          },
                          child: const InvitationStateIndicator(
                            invitationState: InvitationState.accepted,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
