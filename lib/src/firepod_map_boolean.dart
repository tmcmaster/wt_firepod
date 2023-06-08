import 'firepod_map.dart';
import 'generic_lookup_map.dart';

class FirepodMapBoolean extends FirepodMap<bool> {
  static const none = GenericLookupMap<bool>(map: {});
  FirepodMapBoolean({
    required String name,
    required String prefixPath,
    bool watch = true,
    bool siteEnabled = true,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => bool.parse(value.toString()),
          encoder: (object) => object,
          prefixPath: prefixPath,
          watch: watch,
          siteEnabled: siteEnabled,
        );
}
