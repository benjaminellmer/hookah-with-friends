// ignore: avoid_classes_with_only_static_members
class DurationFormatters {
  static String hms(final Duration d) => d.toString().split(".").first.padLeft(8, "0");
}
