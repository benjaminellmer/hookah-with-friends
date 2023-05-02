// ignore_for_file: sort_constructors_first

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../model/tobacco.dart";
import "../../services/tobacco_service.dart";
import "../../util/locator.dart";

part "tobaccos_state.dart";

class TobaccosCubit extends Cubit<TobaccosState> {
  final TobaccoService tobaccoService = getIt.get<TobaccoService>();

  TobaccosCubit() : super(TobaccosLoading());

  Future<void> loadTobaccos() async {
    emit(TobaccosLoading());

    final List<Tobacco> tobaccos = await tobaccoService.getTobaccosForUser();

    emit(TobaccosLoadSuccess(tobaccos));
  }
}
