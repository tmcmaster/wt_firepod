import 'package:wt_firepod/src/providers/lists/firepod_list_bool.dart';
import 'package:wt_firepod/src/providers/lists/firepod_list_double.dart';
import 'package:wt_firepod/src/providers/lists/firepod_list_int.dart';
import 'package:wt_firepod/src/providers/lists/firepod_list_object.dart';
import 'package:wt_firepod/src/providers/lists/firepod_list_string.dart';

import '../models/product.dart';

abstract class TestingDatabaseList {
  static const basePath = '/v1/testing/list';

  static final firepodListBool = FirepodListBool(
    name: 'Firepod List Boolean Test',
    path: '$basePath/boolean',
  );
  static final firepodListDouble = FirepodListDouble(
    name: 'Firepod List Double Test',
    path: '$basePath/double',
  );
  static final firepodListInt = FirepodListInt(
    name: 'Firepod List Integer Test',
    path: '$basePath/integer',
  );
  static final firepodListString = FirepodListString(
    name: 'Firepod List String Test',
    path: '$basePath/strings',
  );

  static final firepodListObject = FirepodListObject<Product>(
    name: 'Firepod List Object Test',
    path: '$basePath/products',
    watch: true,
    autoSave: true,
    decoder: Product.fromJsonDynamic,
    encoder: Product.to.jsonFromModel,
    keyField: 'id',
  );
}
