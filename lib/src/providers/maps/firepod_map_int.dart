import '../generic/generic_lookup_map.dart';
import 'firepod_map.dart';

class FirepodMapInt extends FirepodMap<int> {
  static const none = GenericLookupMap<int>(map: {});
  FirepodMapInt({
    required String name,
    required String path,
    bool watch = true,
    bool autoSave = false,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => int.parse(value.toString()),
          encoder: (object) => object,
          path: path,
          watch: watch,
          autoSave: autoSave,
        );
}
