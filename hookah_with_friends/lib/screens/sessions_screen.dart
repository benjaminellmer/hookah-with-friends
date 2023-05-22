import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/session/sessions_bloc.dart";
import "../components/cards/active_session_card.dart";
import "../components/cards/my_session_card.dart";
import "../components/cards/session_invite_card.dart";
import "../components/texts/primary_text.dart";
import "../components/texts/subheading.dart";
import "../model/session.dart";
import "../model/session_invite.dart";

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SessionsBloc>().add(SessionsLoadInitialized());
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SessionsBloc>().add(SessionsRefreshInitialized());
      },
      child: BlocBuilder<SessionsBloc, SessionsState>(
        builder: (BuildContext context, SessionsState state) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: BlocBuilder<SessionsBloc, SessionsState>(
                    builder: (BuildContext context, SessionsState state) {
                      if (state is SessionsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SessionsLoaded) {
                        return Column(
                          children: <Widget>[
                            const SubHeading("Active Sessions"),
                            _ActiveSessions(state.activeSessions),
                            const SizedBox(height: 8),
                            const SubHeading("Invites"),
                            _Invites(state.inviteSessions),
                            // SessionInviteCard(TestData.sessionInvite1),
                            const SizedBox(height: 8),
                            // SessionInviteCard(TestData.sessionInvite2),
                            const SubHeading("My Sessions"),
                            _MySessions(state.mySessions),
                            const SizedBox(height: 16)
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              if (state is SessionsRefreshing)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          );
        },
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

class _MySessions extends StatelessWidget {
  const _MySessions(this.mySessions);

  final List<Session> mySessions;

  @override
  Widget build(BuildContext context) {
    if (mySessions.isNotEmpty) {
      return Column(
        children: mySessions
            .map((Session session) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: MySessionCard(session),
                ))
            .toList(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: PrimaryText("You currently have no Sessions planned!"),
      );
    }
  }
}

class _ActiveSessions extends StatelessWidget {
  const _ActiveSessions(this.activeSessions);

  final List<SessionLoaded> activeSessions;

  @override
  Widget build(BuildContext context) {
    if (activeSessions.isNotEmpty) {
      return Column(
        children: activeSessions
            .map((SessionLoaded session) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ActiveSessionCard(session),
                ))
            .toList(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: PrimaryText("You currently have no active Sessions!"),
      );
    }
  }
}
