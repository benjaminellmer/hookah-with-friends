import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import '../../services/friend_service.dart';
import '../../services/user_service.dart';
import '../../util/locator.dart';

part 'add_friend_state.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(AddFriendInitial());
  final UserService userService = getIt.get<UserService>();
  final FriendService friendService = getIt.get<FriendService>();

  Future<void> addFriend({required String userName}) async {
    final String? friendUid =
        await userService.getUidForUserName(userName: userName);

    if (friendUid == null) {
      emit(AddFriendError(
          message: "Did not find a user with the name: $userName!"));
    } else {
      if (friendUid == userService.currentUser?.uid) {
        emit(AddFriendError(
            message: "You can not send an Invitation to yourself!"));
      } else {
        try {
          final bool alreadyInvited =
              await friendService.invitationExists(toUid: friendUid);

          if (alreadyInvited) {
            emit(AddFriendError(
                message:
                    "You already sent an invitation to this user! Be patient..."));
          } else {
            await friendService.createInvitation(toUid: friendUid);
            emit(AddFriendSuccess());
          }
        } on Error {
          emit(AddFriendError(message: "Unknown Error occurred!"));
        }
      }
    }
  }
}
