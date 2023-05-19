// ignore_for_file: sort_constructors_first

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/session.dart";
import "../../model/tobacco.dart";
import "../../model/user.dart";
import "../../services/friend_service.dart";
import "../../services/session_service.dart";
import "../../services/tobacco_service.dart";
import "../../services/user_service.dart";
import "../../util/locator.dart";

part "create_session_state.dart";

class CreateSessionCubit extends Cubit<CreateSessionState> {
  final SessionService sessionService = getIt.get<SessionService>();
  final TobaccoService tobaccoService = getIt.get<TobaccoService>();
  final FriendService friendService = getIt.get<FriendService>();
  final UserService userService = getIt.get<UserService>();

  CreateSessionCubit() : super(CreateSessionLoading());

  Future<void> loadData() async {
    final List<TobaccoLoaded> tobaccos =
        await tobaccoService.getTobaccosForUser();
    if (tobaccos.isEmpty) {
      emit(
        CreateSessionError(
            errorMessage: "You need at least one tobacco to create a session!",
            isCritical: true),
      );
    } else {
      final List<User> friends = await friendService.loadFriends();
      if (friends.isEmpty) {
        emit(
          CreateSessionError(
              errorMessage: "You need at least one friend to create a session!",
              isCritical: true),
        );
      } else {
        emit(CreateSessionLoaded(tobaccos, friends));
      }
    }
  }

  Future<void> createSession({
    required DateTime selectedDateTime,
    required Tobacco tobacco,
    required List<User> friends,
  }) async {
    final Session session = Session(
      host: userService.currentUser!,
      currentTobacco: tobacco,
      startTime: selectedDateTime,
    );

    try {
      await sessionService.createSession(session, friends);

      emit(CreateSessionSuccess());
    } on FirebaseException catch (ex) {
      emit(CreateSessionError(errorMessage: ex.message ?? ex.code));
    } on Error catch (err) {
      if (kDebugMode) {
        print(err.stackTrace);
      }
      emit(CreateSessionError(errorMessage: "Unknown error occurred"));
    }
  }
}
