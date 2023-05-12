import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/user.dart";
import "../../services/friend_service.dart";
import "../../services/user_service.dart";
import "../../util/locator.dart";

part "friends_state.dart";

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsLoading());
  final FriendService friendsService = getIt.get<FriendService>();
  final UserService userService = getIt.get<UserService>();

  Future<void> loadFriends() async {
    await userService.refreshUser();

    try {
      final List<User> friends = await friendsService.loadFriends();

      emit(FriendsLoadSuccess(friends: friends));
    } on Error catch (err) {
      debugPrintStack(stackTrace: err.stackTrace);
      emit(FriendsLoadFailure(message: "Unknown error occurred!"));
    }
  }
}
