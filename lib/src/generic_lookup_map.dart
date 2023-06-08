import 'dart:convert';

class GenericLookupMap<T> {
  static const none = GenericLookupMap(map: {});

  final Map<String, T> map;

  const GenericLookupMap({
    required this.map,
  });

  T? value(String key) {
    return map[key];
  }

  T valueOrDefault(String key, T defaultValue) {
    return map[key] ?? defaultValue;
  }

  @override
  String toString() {
    return json.encode(map);
  }

  static GenericLookupMap<T> Function(Object? value) createDecoder<T>(
      T Function(Object? value) decoder, String? keyField) {
    return (Object? value) => GenericLookupMap<T>(
          map: Map.fromEntries((value as Map).entries.map((e) {
            return MapEntry<String, T>(
                e.key.toString(), decoder(_addKey(e.value, e.key, keyField)));
          })),
        );
  }

  static dynamic Function(GenericLookupMap<T>? value) createEncoder<T>(
      Object? Function(T? value) encoder, String? keyField) {
    return (GenericLookupMap<T>? value) => value == null
        ? null
        : Map.fromEntries(value.map.entries.map((e) {
            return MapEntry<String, Object?>(e.key.toString(), encoder(e.value));
          }));
  }

  static Object? _addKey(Object? value, String key, String? keyField) {
    if (keyField != null) {
      (value as Map)[keyField] = key;
    }

    return value;
  }
}
