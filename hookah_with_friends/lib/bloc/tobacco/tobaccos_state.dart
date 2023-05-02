part of "tobaccos_cubit.dart";

@immutable
abstract class TobaccosState {}

class TobaccosLoading extends TobaccosState {}

class TobaccosLoadSuccess extends TobaccosState {
  TobaccosLoadSuccess(this.tobaccos);

  final List<Tobacco> tobaccos;
}

class TobaccosLoadFailure extends TobaccosState {}
