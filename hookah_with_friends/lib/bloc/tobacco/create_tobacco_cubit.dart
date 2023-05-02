import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../enum/flavour.dart";
import "../../exceptions/datastore_exception.dart";
import "../../model/tobacco.dart";
import "../../services/tobacco_service.dart";
import "../../util/locator.dart";

part "create_tobacco_state.dart";

class CreateTobaccoCubit extends Cubit<CreateTobaccoState> {
  CreateTobaccoCubit() : super(CreateTobaccoEditing());
  final TobaccoService tobaccoService = getIt.get<TobaccoService>();

  Future<void> createTobacco({
    required String name,
    required String brand,
    required List<Flavour> flavours,
  }) async {
    if (name.isEmpty) {
      emit(CreateTobaccoEditing(errorMessage: "Name must not be empty!"));
    } else if (brand.isEmpty) {
      emit(CreateTobaccoEditing(errorMessage: "Brand must not be empty!"));
    } else if (flavours.isEmpty) {
      emit(CreateTobaccoEditing(
          errorMessage: "At least one flavour must be selected!"));
    } else {
      emit(CreateTobaccoLoading());

      final Tobacco tobacco =
          Tobacco(name: name, brand: brand, flavours: flavours);

      try {
        final DocumentReference<dynamic>? result =
            await tobaccoService.createTobacco(tobacco);
        if (result != null) {
          emit(CreateTobaccoSuccess());
        }
      } on DataStoreException catch (ex) {
        emit(CreateTobaccoEditing(errorMessage: ex.message));
      } on Error {
        emit(CreateTobaccoEditing(errorMessage: "Unknown error occurred!"));
      }
    }
  }
}

/*
                  } else if (brandController.text.isEmpty) {
                    errorMessage = "Brand must not be empty!";
                  } else if (flavoursController.currentSelection.isEmpty) {
                    errorMessage = "At least one flavour must be selected!";
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    Navigator.of(context).pop();
                  }
                  if (errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text(errorMessage)),
                      ),
                    );
                  }
 */
