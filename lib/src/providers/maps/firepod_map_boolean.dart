import '../generic/generic_lookup_map.dart';
import 'firepod_map.dart';

class FirepodMapBoolean extends FirepodMap<bool> {
  static const none = GenericLookupMap<bool>(map: {});
  FirepodMapBoolean({
    required String name,
    required String path,
    bool watch = true,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => bool.parse(value.toString()),
          encoder: (object) => object,
          path: path,
          watch: watch,
        );
}
