part of "element_picker_cubit.dart";

@immutable
abstract class ElementPickerState {}

class ElementPickerSelected extends ElementPickerState {
  ElementPickerSelected(this.selectedIndex);

  final int selectedIndex;
}
