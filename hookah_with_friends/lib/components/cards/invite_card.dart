import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../bloc/friend_invites/friend_invites_cubit.dart";
import "../../model/user.dart";
import "../../services/friend_service.dart";
import "../../util/locator.dart";
import "../texts/primary_text.dart";
import "primary_card.dart";

class InviteCard extends StatelessWidget {
  const InviteCard({super.key, required this.friend});

  final User friend;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      child: Row(
        children: <Widget>[
          PrimaryText(
            friend.userName,
            fontSize: 16,
          ),
          const Spacer(),
          IconButton(
            constraints: const BoxConstraints(maxWidth: 20.0, maxHeight: 20.0),
            padding: EdgeInsets.zero,
            onPressed: () async {
              final FriendInvitesCubit cubit =
                  context.read<FriendInvitesCubit>();
              await getIt
                  .get<FriendService>()
                  .deleteInvitation(uid: friend.uid);
              await cubit.loadInvites();
            },
            icon: Image.asset(
              "lib/assets/cross.png",
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            constraints: const BoxConstraints(maxWidth: 20.0, maxHeight: 20.0),
            padding: EdgeInsets.zero,
            onPressed: () async {
              final FriendInvitesCubit cubit =
                  context.read<FriendInvitesCubit>();
              await getIt
                  .get<FriendService>()
                  .acceptFriendInvitation(uid: friend.uid);
              await cubit.loadInvites();
            },
            icon: Image.asset(
              "lib/assets/checkmark.png",
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
