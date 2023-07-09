import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wt_logging/wt_logging.dart';

import 'database/testing_database_map.dart';
import 'mocks/firepod_map_mock_builder.dart';

void main() {
  final log = logger('Firepod Mock Map Tests', level: Level.warning);

  group('Firepod Mock Map', () {
    final container = ProviderContainer(overrides: [
      ...FirepodMapMockBuilder.overrides(),
    ],);
    test('Firepod Map Boolean', () {
      final firepodMapBool = container.read(TestingDatabaseMap.firepodMapBool.value);
      log.d('firepodMapBool: $firepodMapBool');
      expect(firepodMapBool.map.entries.first.value, true);
    });
    test('Firepod Map Double', () {
      final firepodMapDouble = container.read(TestingDatabaseMap.firepodMapDouble.value);
      log.d('firepodMapDouble: $firepodMapDouble');
      expect(firepodMapDouble.map.entries.first.value, 1.1);
    });
    test('Firepod Map Integer', () {
      final firepodMapInt = container.read(TestingDatabaseMap.firepodMapInt.value);
      log.d('firepodMapInt: $firepodMapInt');
      expect(firepodMapInt.map.entries.first.value, 1);
    });
    test('Firepod Map String', () {
      final firepodMapString = container.read(TestingDatabaseMap.firepodMapString.value);
      log.d('firepodMapString: $firepodMapString');
      expect(firepodMapString.map.entries.first.value, '1');
    });
    test('Firepod Map Object', () {
      final firepodMapObject = container.read(TestingDatabaseMap.firepodMapObject.value);
      log.d('firepodMapString: $firepodMapObject');
      expect(firepodMapObject.map.entries.first.value.title, 'Product 1');
    });
  });
}
