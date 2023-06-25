import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

import '../database/testing_database_scalar.dart';

class FirepodScalarMockBuilder {
  static List<Override> overrides() {
    final mockBuilder = FirepodScalarMockBuilder();
    return [
      TestingDatabaseScalar.firepodScalarBool.value
          .overrideWith((ref) => mockBuilder.firepodScalarBool()),
      TestingDatabaseScalar.firepodScalarDouble.value
          .overrideWith((ref) => mockBuilder.firepodScalarDouble()),
      TestingDatabaseScalar.firepodScalarInt.value
          .overrideWith((ref) => mockBuilder.firepodScalarInt()),
      TestingDatabaseScalar.firepodScalarString.value
          .overrideWith((ref) => mockBuilder.firepodScalarString()),
    ];
  }

  FirepodMock<bool> firepodScalarBool() => FirepodMock(true);
  FirepodMock<double> firepodScalarDouble() => FirepodMock(0.1);
  FirepodMock<int> firepodScalarInt() => FirepodMock(1);
  FirepodMock<String> firepodScalarString() => FirepodMock('1');
}
