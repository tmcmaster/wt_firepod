import 'package:wt_firepod/src/providers/maps/firepod_map_boolean.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map_double.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map_int.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map_object.dart';
import 'package:wt_firepod/src/providers/maps/firepod_map_string.dart';

import '../models/product.dart';

abstract class TestingDatabaseMap {
  static const basePath = '/v1/testing/map';

  static final firepodMapBool = FirepodMapBoolean(
    name: 'Firepod Map Boolean Test',
    path: '$basePath/boolean',
  );

  static final firepodMapDouble = FirepodMapDouble(
    name: 'Firepod Map Double Test',
    path: '$basePath/double',
  );

  static final firepodMapInt = FirepodMapInt(
    name: 'Firepod Map Integer Test',
    path: '$basePath/integer',
  );

  static final firepodMapString = FirepodMapString(
    name: 'Firepod Map String Test',
    path: '$basePath/string',
  );

  static const decoder = Product.fromJsonDynamic;
  static final encoder = Product.to.jsonFromModel;

  static final firepodMapObject = FirepodMapObject<Product>(
    name: 'Firepod Map Object Test',
    path: '$basePath/object',
    modelDecoder: Product.fromJsonDynamic,
    modelEncoder: Product.to.jsonFromModel,
    keyField: 'id',
  );
}
