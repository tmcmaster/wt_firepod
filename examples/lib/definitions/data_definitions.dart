import 'package:wt_firepod_examples/definitions/product_definition.dart';

class DataDefinitions {
  static final allProducts = ProductDefinition(
    orderBy: 'title',
  );
  static final sfProducts = ProductDefinition(
    orderBy: 'supplier',
    equalTo: 'SF',
  );
}
