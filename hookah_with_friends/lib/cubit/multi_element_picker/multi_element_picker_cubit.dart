import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "multi_element_picker_state.dart";

class MultiElementPickerCubit extends Cubit<MultiElementPickerSelected> {
  MultiElementPickerCubit() : super(MultiElementPickerSelected(const <int>[]));
  final List<int> selectedIndexes = <int>[];

  void toggleValue(final int index, final bool value) {
    if (value) {
      selectedIndexes.add(index);
    } else {
      selectedIndexes.remove(index);
    }
    emit(MultiElementPickerSelected(selectedIndexes));
  }

  void selectAll(final int size) {
    selectedIndexes.clear();
    selectedIndexes.addAll(Iterable<int>.generate(size));
    emit(MultiElementPickerSelected(selectedIndexes));
  }

  void unSelectAll() {
    selectedIndexes.clear();
    emit(MultiElementPickerSelected(selectedIndexes));
  }
}
