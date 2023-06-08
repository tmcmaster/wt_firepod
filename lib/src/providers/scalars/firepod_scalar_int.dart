import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarInt extends FirepodScalar<int> {
  FirepodScalarInt({
    required String name,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) : super(
          name: name,
          path: path,
          none: 0,
          decoder: (object) => int.parse(object.toString()),
          encoder: (value) => value,
          watch: watch,
          autoSave: autoSave,
        );
}
