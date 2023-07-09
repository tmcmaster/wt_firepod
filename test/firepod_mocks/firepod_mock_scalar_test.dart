import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wt_logging/wt_logging.dart';

import 'database/testing_database_scalar.dart';
import 'mocks/firepod_scalar_mock_builder.dart';

void main() {
  final log = logger('Firepod Mock Scalar Tests', level: Level.warning);

  group('Firepod Mock Scalar', () {
    final container = ProviderContainer(overrides: [
      ...FirepodScalarMockBuilder.overrides(),
    ],);
    test('Firepod Scalar Boolean', () {
      final firepodScalarBool = container.read(TestingDatabaseScalar.firepodScalarBool.value);
      log.d('firepodScalarBool: $firepodScalarBool');
      expect(firepodScalarBool, true);
    });
    test('Firepod Scalar Double', () {
      final firepodScalarDouble = container.read(TestingDatabaseScalar.firepodScalarDouble.value);
      log.d('firepodScalarDouble: $firepodScalarDouble');
      expect(firepodScalarDouble, 0.1);
    });
    test('Firepod Scalar Integer', () {
      final firepodScalarInt = container.read(TestingDatabaseScalar.firepodScalarInt.value);
      log.d('firepodScalarInt: $firepodScalarInt');
      expect(firepodScalarInt, 1);
    });
    test('Firepod Scalar String', () {
      final firepodScalarString = container.read(TestingDatabaseScalar.firepodScalarString.value);
      log.d('firepodScalarString: $firepodScalarString');
      expect(firepodScalarString, '1');
    });
  });
}
