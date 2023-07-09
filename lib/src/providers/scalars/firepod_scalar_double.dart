import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarDouble extends FirepodScalar<double> {
  FirepodScalarDouble({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave = false,
  }) : super(
          none: 0.0,
          decoder: (object) => double.parse(object.toString()),
          encoder: (value) => value,
        );
}
