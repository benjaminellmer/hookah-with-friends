// ignore_for_file: avoid_classes_with_only_static_members

typedef ToJsonFunction<T> = Map<String, dynamic> Function(T);
typedef FromJsonFunction<T> = T Function(Map<String, dynamic>);

class JsonUtils {
  static List<T> decodeStringList<T>(dynamic json) {
    final List<dynamic> list = json as List<dynamic>;
    return list.map((dynamic element) => element as T).toList();
  }

  static List<T> decodeList<T>(List<dynamic> jsonList,
      {required FromJsonFunction<T> fromJson}) {
    return jsonList
        .map((dynamic element) => fromJson(element as Map<String, dynamic>))
        .toList();
  }

  static dynamic encodeList<T>(List<T> data,
      {required ToJsonFunction<T> toJson}) {
    return data.map((T element) => toJson(element)).toList();
  }
}
