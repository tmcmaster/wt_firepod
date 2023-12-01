import 'package:wt_firepod/src/providers/generic/generic_lookup_map.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map.dart';

class FirepodMapInt extends FirepodMap<int> {
  static const none = GenericLookupMap<int>(map: {});
  FirepodMapInt({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          none: none,
          decoder: (value) => int.tryParse(value.toString()) ?? 0,
          encoder: (object) => object,
        );
}
