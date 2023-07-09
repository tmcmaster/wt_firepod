import 'package:firebase_database/firebase_database.dart';
import 'package:wt_models/wt_models.dart';

class ToModelFromFirebase<T extends IdJsonSupport<T>> extends ToModelFrom<T> {
  final String idField;

  ToModelFromFirebase({
    required super.json,
    super.titles,
    this.idField = 'id',
    super.none,
  });

  List<T> snapshotList(DataSnapshot snapshot) {
    if (snapshot.exists && snapshot.value != null) {
      final map = snapshot.value! as Map<dynamic, dynamic>;
      final newMap = _transformMap(map);
      return newMap.values.map((e) => super.json(_transformMap(e as Map))).toList();
    } else {
      return [];
    }
  }

  Map<String, dynamic> _transformMap(Map<dynamic, dynamic> map) {
    return {
      for (var e in map.entries)
        e.key.toString(): _addKeyFieldIfRequired(e.value as Object, e.key as String, idField)
    };
  }

  T snapshot(DataSnapshot snapshot) {
    if (snapshot.exists && snapshot.value != null) {
      final map = snapshot.value! as Map;
      final newMap = {
        for (var e in map.entries)
          e.key.toString(): _addKeyFieldIfRequired(e.value as Object, e.key as String, idField)
      };

      newMap[idField] = snapshot.key ?? '';

      return super.json(newMap);
    } else {
      if (super.none != null) {
        return super.none!;
      } else {
        throw Exception('Could not find required firebase object of Type(${T.runtimeType})');
      }
    }
  }

  // TODO: need to test this properly, for the child
  Object _addKeyFieldIfRequired(Object value, String key, String? mapKeyField) {
    if (value is Map && mapKeyField != null) {
      value[mapKeyField] = key;
    }
    return value;
  }

  static Map<String, dynamic> firebaseMapToJsonMap(Map<Object?, Object?> map) {
    return Map.fromEntries(
      map.entries.map((e) {
        return MapEntry<String, dynamic>(e.key.toString(), e.value);
      }),
    );
  }
}
