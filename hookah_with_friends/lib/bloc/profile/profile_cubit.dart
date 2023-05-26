import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/user.dart";
import "../../services/friend_service.dart";
import "../../services/user_service.dart";
import "../../util/locator.dart";

part "profile_state.dart";

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());
  final UserService userService = getIt.get<UserService>();
  final FriendService friendService = getIt.get<FriendService>();

  void loadUser() async {
    emit(ProfileLoading());

    await userService.refreshUser();
    final numberOfInvitations = await friendService.getNumberOfInvitations();

    emit(ProfileLoaded(userService.currentUser!, numberOfInvitations));
  }
}
