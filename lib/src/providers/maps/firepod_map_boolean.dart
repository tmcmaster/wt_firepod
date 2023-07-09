import 'package:wt_firepod/src/providers/generic/generic_lookup_map.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map.dart';

class FirepodMapBoolean extends FirepodMap<bool> {
  static const none = GenericLookupMap<bool>(map: {});
  FirepodMapBoolean({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          none: none,
          decoder: (value) => bool.parse(value.toString()),
          encoder: (object) => object,
        );
}
