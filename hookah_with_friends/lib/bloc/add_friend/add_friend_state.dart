part of 'add_friend_cubit.dart';

@immutable
abstract class AddFriendState {}

class AddFriendInitial extends AddFriendState {}

class AddFriendError extends AddFriendState {
  AddFriendError({required this.message});

  final String message;
}

class AddFriendSuccess extends AddFriendState {}
