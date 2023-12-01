import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

import '../database/testing_database_map.dart';
import '../models/product.dart';

class FirepodMapMockBuilder {
  static List<Override> overrides() {
    final mockBuilder = FirepodMapMockBuilder();
    return [
      TestingDatabaseMap.firepodMapBool.value.overrideWith((ref) => mockBuilder.firepodMapBool()),
      TestingDatabaseMap.firepodMapDouble.value
          .overrideWith((ref) => mockBuilder.firepodMapDouble()),
      TestingDatabaseMap.firepodMapInt.value.overrideWith((ref) => mockBuilder.firepodMapInt()),
      TestingDatabaseMap.firepodMapString.value
          .overrideWith((ref) => mockBuilder.firepodMapString()),
      TestingDatabaseMap.firepodMapObject.value
          .overrideWith((ref) => mockBuilder.firepodMapObject()),
    ];
  }

  FirepodMock<GenericLookupMap<bool>> firepodMapBool() => FirepodMock(
        const GenericLookupMap(map: {
          '1': true,
        },),
      );
  FirepodMock<GenericLookupMap<double>> firepodMapDouble() => FirepodMock(
        const GenericLookupMap(map: {'01': 1.1}),
      );
  FirepodMock<GenericLookupMap<int>> firepodMapInt() => FirepodMock(
        const GenericLookupMap(map: {'01': 1}),
      );
  FirepodMock<GenericLookupMap<String>> firepodMapString() => FirepodMock(
        const GenericLookupMap(map: {'01': '1'}),
      );
  FirepodMock<GenericLookupMap<Product>> firepodMapObject() => FirepodMock(
        GenericLookupMap(map: {
          '001': Product(
            order: 1,
            price: 1,
            title: 'Product 1',
            weight: 1.1,
          ),
        },),
      );
}
