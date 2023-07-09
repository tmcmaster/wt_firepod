import 'package:wt_firepod/wt_firepod.dart';

mixin TestingDatabaseScalar {
  static const basePath = '/v1/testing/scalar';

  static final firepodScalarString = FirepodScalarString(
    name: 'Firepod Scalar String',
    path: '$basePath/string',
  );
  static final firepodScalarInt = FirepodScalarInt(
    name: 'Firepod Scalar Integer',
    path: '$basePath/integer',
  );
  static final firepodScalarDouble = FirepodScalarDouble(
    name: 'Firepod Scalar Double',
    path: '$basePath/double',
  );
  static final firepodScalarBool = FirepodScalarBool(
    name: 'Firepod Scalar boolean',
    path: '$basePath/boolean',
  );
}
