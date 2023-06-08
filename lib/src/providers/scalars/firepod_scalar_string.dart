import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarString extends FirepodScalar<String> {
  FirepodScalarString({
    required String name,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) : super(
          name: name,
          path: path,
          none: '',
          decoder: (object) => object.toString(),
          encoder: (value) => value,
          watch: watch,
          autoSave: autoSave,
        );
}
