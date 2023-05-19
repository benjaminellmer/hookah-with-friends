import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../components/pickers/element_picker.dart";

part "element_picker_state.dart";

class ElementPickerCubit extends Cubit<ElementPickerSelected> {
  ElementPickerCubit() : super(ElementPickerSelected(0));

  void selectIndex(final int index) {
    emit(ElementPickerSelected(index));
  }

  void updateSelection<T>(
    final int index,
    ElementPickerController<T> controller,
    List<T> items,
  ) {
    controller.currentSelection = items[index];
  }
}
