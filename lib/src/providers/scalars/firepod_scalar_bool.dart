import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarBool extends FirepodScalar<bool> {
  FirepodScalarBool({
    required String name,
    required String path,
    bool watch = false,
  }) : super(
          name: name,
          path: path,
          none: true,
          decoder: (object) => bool.parse(object.toString()),
          encoder: (value) => value,
          watch: watch,
        );
}
