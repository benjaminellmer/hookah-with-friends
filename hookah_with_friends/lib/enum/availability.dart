enum Availability {
  high,
  medium,
  low;

  factory Availability.fromJson(String json) {
    return values.byName(json);
  }
}
