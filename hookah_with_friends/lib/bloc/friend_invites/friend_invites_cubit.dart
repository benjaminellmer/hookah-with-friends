import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/friend_invitation.dart";
import "../../services/friend_service.dart";
import "../../util/locator.dart";

part "friend_invites_state.dart";

class FriendInvitesCubit extends Cubit<FriendInvitesState> {
  FriendInvitesCubit() : super(FriendInvitesLoading());

  final FriendService friendService = getIt.get<FriendService>();

  Future<void> loadInvites() async {
    try {
      final List<FriendInvitationLoaded> invitations =
          await friendService.getMyInvitations();

      emit(FriendInvitesLoadSuccess(invitations));
    } on Error {
      emit(FriendInvitesLoadError(message: "Unknown error occurred!"));
    }
  }
}
