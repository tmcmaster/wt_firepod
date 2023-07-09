import 'package:wt_firepod/src/providers/generic/generic_lookup_map.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map.dart';

class FirepodMapString extends FirepodMap<String> {
  static const none = GenericLookupMap<String>(map: {});
  FirepodMapString({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          none: none,
          decoder: (value) => value.toString(),
          encoder: (object) => object,
        );
}
