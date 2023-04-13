import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "element_picker_state.dart";

class ElementPickerCubit extends Cubit<ElementPickerSelected> {
  ElementPickerCubit() : super(ElementPickerSelected(0));

  void selectIndex(final int index) {
    emit(ElementPickerSelected(index));
  }
}
