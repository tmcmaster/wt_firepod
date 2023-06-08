import 'package:wt_logging/wt_logging.dart';

import 'firepod_map.dart';
import 'generic_lookup_map.dart';

class FirepodMapObject<T> extends FirepodMap<T> {
  static final log = logger(FirepodMapObject);

  FirepodMapObject({
    required String name,
    required String path,
    required T Function(Map<String, dynamic> value) modelDecoder,
    required Map<String, dynamic> Function(T object) modelEncoder,
    bool watch = true,
    bool siteEnabled = true,
    String? keyField,
  }) : super(
          name: name,
          none: GenericLookupMap<T>(map: {}),
          decoder: (Object? value) {
            final map = value as Map<Object?, Object?>;
            final newMap = Map.fromEntries(map.entries.map((e) {
              return MapEntry<String, dynamic>(e.key.toString(), e.value);
            }));
            T model = modelDecoder(newMap);
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
          path: path,
          keyField: keyField,
          watch: watch,
          siteEnabled: siteEnabled,
        );
}
