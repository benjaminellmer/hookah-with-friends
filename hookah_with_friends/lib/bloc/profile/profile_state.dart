part of "profile_cubit.dart";

@immutable
abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(this.currentUser, this.numberOfInvitations);

  final User currentUser;
  final int numberOfInvitations;
}
