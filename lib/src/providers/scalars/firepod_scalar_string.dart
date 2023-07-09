import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarString extends FirepodScalar<String> {
  FirepodScalarString({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          none: '',
          decoder: (object) => object.toString(),
          encoder: (value) => value,
        );
}
