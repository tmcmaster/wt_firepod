import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wt_logging/wt_logging.dart';

import 'database/testing_database_object.dart';
import 'mocks/firepod_object_mock_builder.dart';

void main() {
  final log = logger('Firepod Mock Object Tests', level: Level.warning);

  group('Firepod Mock Object', () {
    final container = ProviderContainer(overrides: [
      ...FirepodObjectMockBuilder.overrides(),
    ],);
    test('Firepod Object Product', () {
      final firepodObjectProduct = container.read(TestingDatabaseObject.firepodObjectProduct.value);
      log.d('firepodObjectProduct: $firepodObjectProduct');
      expect(firepodObjectProduct.weight, 1.1);
    });
  });
}
