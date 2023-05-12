part of "friends_cubit.dart";

abstract class FriendsState {}

class FriendsLoading extends FriendsState {}

@immutable
class FriendsLoadSuccess extends FriendsState {
  FriendsLoadSuccess({required this.friends});

  final List<User> friends;
}

class FriendsLoadFailure extends FriendsState {
  FriendsLoadFailure({required this.message});

  final String message;
}
