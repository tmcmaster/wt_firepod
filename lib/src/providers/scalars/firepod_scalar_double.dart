import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarDouble extends FirepodScalar<double> {
  FirepodScalarDouble({
    required String name,
    required String path,
    bool watch = false,
  }) : super(
          name: name,
          path: path,
          none: 0.0,
          decoder: (object) => double.parse(object.toString()),
          encoder: (value) => value,
          watch: watch,
        );
}
