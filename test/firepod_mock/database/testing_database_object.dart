import 'package:wt_firepod/src/providers/objects/firepod_object.dart';

import '../models/product.dart';

abstract class TestingDatabaseObject {
  static const basePath = '/v1/testing/object';

  static final firepodObjectProduct = FirepodObject<Product>(
    name: 'Firepod Object Product',
    path: '$basePath/product',
    decoder: Product.fromJsonDynamic,
    encoder: Product.to.jsonFromModel,
    none: Product.none,
  );
}
