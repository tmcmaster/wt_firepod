import '../generic/generic_lookup_map.dart';
import 'firepod_map.dart';

class FirepodMapString extends FirepodMap<String> {
  static const none = GenericLookupMap<String>(map: {});
  FirepodMapString({
    required String name,
    required String path,
    bool watch = true,
    bool siteEnabled = true,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => value.toString(),
          encoder: (object) => object,
          path: path,
          watch: watch,
        );
}
