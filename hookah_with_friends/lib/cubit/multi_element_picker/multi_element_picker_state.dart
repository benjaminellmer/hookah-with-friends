part of "multi_element_picker_cubit.dart";

@immutable
abstract class MultiElementPickerState {}

class MultiElementPickerSelected extends MultiElementPickerState {
  MultiElementPickerSelected(this.selectedIndexes);

  final List<int> selectedIndexes;
}
