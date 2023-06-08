import '../generic/generic_lookup_map.dart';
import 'firepod_map.dart';

class FirepodMapDouble extends FirepodMap<double> {
  static const none = GenericLookupMap<double>(map: {});
  FirepodMapDouble({
    required String name,
    required String path,
    bool watch = true,
    bool autoSave = false,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => double.parse(value.toString()),
          encoder: (object) => object,
          path: path,
          watch: watch,
          autoSave: autoSave,
        );
}
