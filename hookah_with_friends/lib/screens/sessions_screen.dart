import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/session/sessions_bloc.dart";
import "../components/cards/active_session_card.dart";
import "../components/cards/session_invite_card.dart";
import "../components/texts/primary_text.dart";
import "../components/texts/subheading.dart";
import "../model/session_invite.dart";
import "../util/testdata/testdata.dart";

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionsBloc>(
      create: (BuildContext context) =>
          SessionsBloc()..add(SessionsLoadInitialized()),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: BlocBuilder<SessionsBloc, SessionsState>(
            builder: (BuildContext context, SessionsState state) {
              if (state is SessionsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SessionsLoaded) {
                return Column(
                  children: <Widget>[
                    const SubHeading("Active Sessions"),
                    ActiveSessionCard(TestData.activeSession),
                    const SubHeading("Invites"),
                    _Invites(state.inviteSessions),
                    // SessionInviteCard(TestData.sessionInvite1),
                    // const SizedBox(height: 8),
                    // SessionInviteCard(TestData.sessionInvite2),
                    // const SubHeading("History"),
                    // HistorySessionCard(TestData.historySession1),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _Invites extends StatelessWidget {
  const _Invites(this.inviteSessions);

  final List<SessionInviteLoaded> inviteSessions;

  @override
  Widget build(BuildContext context) {
    if (inviteSessions.isNotEmpty) {
      return Column(
        children: inviteSessions
            .map((SessionInviteLoaded invite) => SessionInviteCard(invite))
            .toList(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: PrimaryText("There are no pending Invitations for you!"),
      );
    }
  }
}
