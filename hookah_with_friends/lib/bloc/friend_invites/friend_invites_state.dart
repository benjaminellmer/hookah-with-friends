part of "friend_invites_cubit.dart";

@immutable
abstract class FriendInvitesState {}

class FriendInvitesLoading extends FriendInvitesState {}

class FriendInvitesLoadSuccess extends FriendInvitesState {
  FriendInvitesLoadSuccess(this.invitations);

  final List<FriendInvitationLoaded> invitations;
}

class FriendInvitesLoadError extends FriendInvitesState {
  FriendInvitesLoadError({required this.message});

  final String message;
}
