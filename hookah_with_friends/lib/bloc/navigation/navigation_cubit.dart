import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "navigation_state.dart";

class NavigationCubit extends Cubit<NavigationSelected> {
  NavigationCubit() : super(const NavigationSelected(0));

  void select(int index) {
    emit(NavigationSelected(index));
  }
}
