import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wt_logging/wt_logging.dart';

import 'database/testing_database_list.dart';
import 'mocks/firepod_list_mock_builder.dart';

void main() {
  final log = logger('Firepod Mock List Tests', level: Level.warning);

  group("Firepod Mock List", () {
    final container = ProviderContainer(overrides: [
      ...FirepodListMockBuilder.overrides(),
    ]);
    test("Firepod List Boolean", () {
      final firepodListBool = container.read(TestingDatabaseList.firepodListBool.value);
      log.d('firepodListBool: $firepodListBool');
      expect(firepodListBool.first, true);
    });
    test("Firepod List Double", () {
      final firepodListDouble = container.read(TestingDatabaseList.firepodListDouble.value);
      log.d('firepodListDouble: $firepodListDouble');
      expect(firepodListDouble.first, 1.1);
    });
    test("Firepod List Integer", () {
      final firepodListInt = container.read(TestingDatabaseList.firepodListInt.value);
      log.d('firepodListInt: $firepodListInt');
      expect(firepodListInt.first, 1);
    });
    test("Firepod List String", () {
      final firepodListString = container.read(TestingDatabaseList.firepodListString.value);
      log.d('firepodListString: $firepodListString');
      expect(firepodListString.first, "Hello");
    });
    test("Firepod List Object", () {
      final firepodListObject = container.read(TestingDatabaseList.firepodListObject.value);
      log.d('firepodListString: $firepodListObject');
      expect(firepodListObject.first.title, 'Product 1');
    });
  });
}
