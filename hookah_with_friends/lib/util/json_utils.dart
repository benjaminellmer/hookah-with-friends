// ignore_for_file: avoid_classes_with_only_static_members

class JsonUtils {
  static List<T> decodeList<T>(dynamic json) {
    final List<dynamic> list = json as List<dynamic>;
    return list.map((dynamic element) => element as T).toList();
  }
}
