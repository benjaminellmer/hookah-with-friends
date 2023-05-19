import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/friend_invites/friend_invites_cubit.dart";
import "../components/appbars/back_and_title_app_bar.dart";
import "../components/buttons/primary_button.dart";
import "../components/cards/invite_card.dart";
import "../components/texts/primary_text.dart";
import "../model/friend_invitation.dart";

class InvitesScreen extends StatelessWidget {
  const InvitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendInvitesCubit>(
      create: (BuildContext context) => FriendInvitesCubit()..loadInvites(),
      child: Scaffold(
        appBar: BackAndTitleAppBar(title: "Friend Invites"),
        body: Builder(builder: (BuildContext context) {
          return BlocBuilder<FriendInvitesCubit, FriendInvitesState>(
            builder: (BuildContext context, FriendInvitesState state) {
              if (state is FriendInvitesLoadSuccess &&
                  state.invitations.isEmpty) {
                return Center(
                  child: PrimaryText("You have no new invitations!"),
                );
              } else if (state is FriendInvitesLoadSuccess) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        for (FriendInvitationLoaded invitation
                            in state.invitations) ...<InviteCard>[
                          InviteCard(friend: invitation.toUser)
                        ]
                      ],
                    ),
                  ),
                );
              } else if (state is FriendInvitesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ErrorRetryButton(
                  message: "Error loading Invitations",
                  onPress: () {
                    context.read<FriendInvitesCubit>().loadInvites();
                  },
                );
              }
            },
          );
        }),
      ),
    );
  }
}

class ErrorRetryButton extends StatelessWidget {
  const ErrorRetryButton({
    super.key,
    required this.message,
    required this.onPress,
  });

  final String message;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(message),
        const SizedBox(height: 32),
        PrimaryButton(
            text: "Retry",
            onPress: () {
              context.read<FriendInvitesCubit>().loadInvites();
            })
      ],
    );
  }
}
