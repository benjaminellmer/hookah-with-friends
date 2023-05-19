enum InvitationState {
  unknown,
  accepted,
  declined;

  factory InvitationState.fromJson(String json) {
    return values.byName(json);
  }

  String toJson() => name;
}
