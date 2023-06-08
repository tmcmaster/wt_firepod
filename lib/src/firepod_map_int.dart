import 'firepod_map.dart';
import 'generic_lookup_map.dart';

class FirepodMapInt extends FirepodMap<int> {
  static const none = GenericLookupMap<int>(map: {});
  FirepodMapInt({
    required String name,
    required String prefixPath,
    bool watch = true,
    bool siteEnabled = true,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => int.parse(value.toString()),
          encoder: (object) => object,
          prefixPath: prefixPath,
          watch: watch,
          siteEnabled: siteEnabled,
        );
}
