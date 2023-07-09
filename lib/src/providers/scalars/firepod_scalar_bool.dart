import 'package:wt_firepod/src/providers/scalars/firepod_scalar.dart';

class FirepodScalarBool extends FirepodScalar<bool> {
  FirepodScalarBool({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          none: true,
          decoder: (object) => bool.parse(object.toString()),
          encoder: (value) => value,
        );
}
