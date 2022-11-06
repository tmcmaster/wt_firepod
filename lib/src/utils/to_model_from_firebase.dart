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
    if (snapshot.exists) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      var newMap = _transformMap(map);
      return newMap.values.map((e) => super.json(_transformMap(e))).toList();
    } else {
      return [];
    }
  }

  Map<String, dynamic> _transformMap(Map<dynamic, dynamic> map) {
    return {for (var e in map.entries) e.key.toString(): _addKeyFieldIfRequired(e.value, e.key, idField)};
  }

  T snapshot(DataSnapshot snapshot) {
    if (snapshot.exists) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      var newMap = {for (var e in map.entries) e.key.toString(): _addKeyFieldIfRequired(e.value, e.key, idField)};

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
}
