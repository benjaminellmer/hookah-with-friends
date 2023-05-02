import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../components/pickers/multi_element_picker.dart";

part "multi_element_picker_state.dart";

class MultiElementPickerCubit<T> extends Cubit<MultiElementPickerSelected> {
  MultiElementPickerCubit({required this.elements, this.controller})
      : super(MultiElementPickerSelected(const <int>[]));

  final List<int> selectedIndexes = <int>[];
  final List<T> elements;
  final MultiElementPickerController<T>? controller;

  void toggleValue(final int index, final bool value) {
    if (value) {
      selectedIndexes.add(index);
    } else {
      selectedIndexes.remove(index);
    }

    _updateController();

    emit(MultiElementPickerSelected(selectedIndexes));
  }

  void selectAll(final int size) {
    selectedIndexes.clear();
    selectedIndexes.addAll(Iterable<int>.generate(size));

    _updateController();

    emit(MultiElementPickerSelected(selectedIndexes));
  }

  void unSelectAll() {
    selectedIndexes.clear();

    _updateController();

    emit(MultiElementPickerSelected(selectedIndexes));
  }

  void _updateController() {
    if (controller != null) {
      controller!.currentSelection =
          selectedIndexes.map((int index) => elements[index]).toList();
    }
  }
}
