import 'package:wt_firepod/src/providers/objects/firepod_object.dart';
import 'package:wt_firepod/src/utils/transformer.dart';
import 'package:wt_models/wt_models.dart';

class FirepodMap extends FirepodObject<JsonMap> {
  FirepodMap({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          encoder: (map) => map,
          decoder: (map) => Transformer.convertSnapshotMap(map),
          none: const {},
        );
}
