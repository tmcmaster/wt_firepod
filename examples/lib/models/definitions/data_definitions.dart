import 'package:wt_firepod_examples/models/definitions/customer_definition.dart';
import 'package:wt_firepod_examples/models/definitions/driver_definition.dart';
import 'package:wt_firepod_examples/models/definitions/product_definition.dart';
import 'package:wt_firepod_examples/models/definitions/supplier_definition.dart';

class DataDefinitions {
  static final customers = CustomerDefinition(
    orderBy: 'name',
  );
  static final suppliers = SupplierDefinition(
    orderBy: 'name',
  );
  static final drivers = DriverDefinition(
    orderBy: 'name',
  );
  static final allProducts = ProductDefinition(
    orderBy: 'title',
    sortWith: (a, b) => a.weight.compareTo(b.weight),
  );
  static final sfProducts = ProductDefinition(
    orderBy: 'supplier',
    equalTo: 'SF',
  );
}
