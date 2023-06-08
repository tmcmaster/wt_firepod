import 'package:wt_logging/wt_logging.dart';

import 'firepod_map.dart';
import 'generic_lookup_map.dart';

class FirepodMapObject<T> extends FirepodMap<T> {
  static final log = logger(FirepodMapObject);

  FirepodMapObject({
    required String name,
    required String prefixPath,
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
          // TODO: This encoder needs to be written properly like above.
          encoder: (T? object) {
            return object == null ? null : modelEncoder(object);
          },
          prefixPath: prefixPath,
          keyField: keyField,
          watch: watch,
          siteEnabled: siteEnabled,
        );
}
