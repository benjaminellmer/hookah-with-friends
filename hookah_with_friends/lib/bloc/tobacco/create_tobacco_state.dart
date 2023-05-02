part of "create_tobacco_cubit.dart";

@immutable
abstract class CreateTobaccoState {}

class CreateTobaccoEditing extends CreateTobaccoState {
  CreateTobaccoEditing({this.errorMessage});

  final String? errorMessage;
}

class CreateTobaccoLoading extends CreateTobaccoState {}

class CreateTobaccoSuccess extends CreateTobaccoState {}
