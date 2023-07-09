import 'package:wt_firepod/src/providers/generic/generic_lookup_map.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map.dart';

class FirepodMapDouble extends FirepodMap<double> {
  static const none = GenericLookupMap<double>(map: {});
  FirepodMapDouble({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          none: none,
          decoder: (value) => double.parse(value.toString()),
          encoder: (object) => object,
        );
}
