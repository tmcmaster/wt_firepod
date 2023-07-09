import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

import '../database/testing_database_object.dart';
import '../models/product.dart';

class FirepodObjectMockBuilder {
  static List<Override> overrides() {
    final mockBuilder = FirepodObjectMockBuilder();
    return [
      TestingDatabaseObject.firepodObjectProduct.value
          .overrideWith((ref) => mockBuilder.firepodObjectProduct()),
    ];
  }

  FirepodMock<Product> firepodObjectProduct() => FirepodMock(
        Product(
          order: 1,
          price: 1,
          title: 'Product 1',
          weight: 1.1,
        ),
      );
}
