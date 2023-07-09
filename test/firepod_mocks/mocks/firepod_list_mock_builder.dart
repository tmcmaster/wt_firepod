import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

import '../database/testing_database_list.dart';
import '../models/product.dart';

class FirepodListMockBuilder {
  static List<Override> overrides() {
    final mockBuilder = FirepodListMockBuilder();
    return [
      TestingDatabaseList.firepodListBool.value
          .overrideWith((ref) => mockBuilder.firepodListBool()),
      TestingDatabaseList.firepodListDouble.value
          .overrideWith((ref) => mockBuilder.firepodListDouble()),
      TestingDatabaseList.firepodListInt.value.overrideWith((ref) => mockBuilder.firepodListInt()),
      TestingDatabaseList.firepodListString.value
          .overrideWith((ref) => mockBuilder.firepodListString()),
      TestingDatabaseList.firepodListObject.value
          .overrideWith((ref) => mockBuilder.firepodListObject()),
    ];
  }

  FirepodMock<List<bool>> firepodListBool() => FirepodMock([true, false, true]);
  FirepodMock<List<double>> firepodListDouble() => FirepodMock([1.1, 1.2, 1.3]);
  FirepodMock<List<int>> firepodListInt() => FirepodMock([1, 2, 3]);
  FirepodMock<List<String>> firepodListString() => FirepodMock(['Hello', 'There']);
  FirepodMock<List<Product>> firepodListObject() => FirepodMock([
        Product(
          order: 1,
          price: 1,
          title: 'Product 1',
          weight: 1.1,
        )
      ]);
}
