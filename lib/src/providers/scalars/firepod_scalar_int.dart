import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarInt extends FirepodScalar<int> {
  FirepodScalarInt({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          none: 0,
          decoder: (object) => int.parse(object.toString()),
          encoder: (value) => value,
        );
}
