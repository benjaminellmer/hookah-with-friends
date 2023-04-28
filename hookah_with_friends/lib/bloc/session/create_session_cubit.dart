// ignore_for_file: sort_constructors_first

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/session.dart";
import "../../model/tobacco.dart";
import "../../model/user.dart";
import "../../services/session_service.dart";
import "../../util/locator.dart";
import "../../util/testdata/testdata.dart";

part "create_session_state.dart";

class CreateSessionCubit extends Cubit<CreateSessionState> {
  final SessionService sessionService = getIt.get<SessionService>();

  CreateSessionCubit() : super(CreateSessionInitial());

  Future<void> createSession({
    required DateTime selectedDateTime,
    required Tobacco tobacco,
    required List<User> friends,
  }) async {
    final Session session = Session(
      host: TestData.activeUser,
      currentTobacco: tobacco,
      startTime: selectedDateTime,
    );

    try {
      await sessionService.createSession(session);

      emit(CreateSessionSuccess());
    } on FirebaseException catch (ex) {
      emit(CreateSessionError(errorMessage: ex.message ?? ex.code));
    } on Error {
      emit(CreateSessionError(errorMessage: "Unknown error occurred"));
    }
  }
}
