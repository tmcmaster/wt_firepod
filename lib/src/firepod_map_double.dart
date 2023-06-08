import 'firepod_map.dart';
import 'generic_lookup_map.dart';

class FirepodMapDouble extends FirepodMap<double> {
  static const none = GenericLookupMap<double>(map: {});
  FirepodMapDouble({
    required String name,
    required String path,
    bool watch = true,
    bool siteEnabled = true,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => double.parse(value.toString()),
          encoder: (object) => object,
          path: path,
          watch: watch,
          siteEnabled: siteEnabled,
        );
}
