import 'package:wt_firepod_examples/models/definitions/product_definition.dart';

class DataDefinitions {
  static final allProducts = ProductDefinition(
    orderBy: 'order',
  );
  static final sfProducts = ProductDefinition(
    orderBy: 'supplier',
    equalTo: 'SF',
  );
}
