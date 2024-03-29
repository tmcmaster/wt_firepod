import 'package:wt_firepod/src/providers/generic/generic_lookup_map.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map.dart';
import 'package:wt_logging/wt_logging.dart';

class FirepodMapObject<T> extends FirepodMap<T> {
  static final log = logger(FirepodMapObject);

  FirepodMapObject({
    required super.name,
    required super.path,
    required T Function(Map<String, dynamic> value) modelDecoder,
    required Map<String, dynamic> Function(T object) modelEncoder,
    super.watch,
    super.autoSave,
    super.keyField,
  }) : super(
          none: GenericLookupMap<T>(map: {}),
          decoder: (Object? value) {
            if (value == null) {
              throw Exception('Unable to build model with no data');
            }
            final map = value as Map<Object?, Object?>;
            final newMap = Map.fromEntries(
              map.entries.map((e) {
                return MapEntry<String, dynamic>(e.key.toString(), e.value);
              }),
            );
            final T model = modelDecoder(newMap);
            return model;
          },
          encoder: (T? object) {
            if (object == null) {
              return null;
            }
            final newModelMap = modelEncoder(object);
            if (keyField != null) {
              newModelMap.remove(keyField);
            }
            return newModelMap;
          },
        );
}
