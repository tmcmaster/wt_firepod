import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/models/product.dart';
import 'package:wt_firepod_examples/widgets/product_list_tile.dart';

class ProductDefinition extends FirepodListDefinition<Product> {
  ProductDefinition({
    String path = 'v1/product',
    String orderBy = 'id',
    String? equalTo,
    int Function(Product a, Product b)? sortWith,
  }) : super(
          path: path,
          orderBy: orderBy,
          equalTo: equalTo,
          snapshotToModel: Product.from.snapshot,
          mapToItem: Product.from.json,
          itemToMap: Product.to.firebaseMap,
          snapshotToList: Product.from.snapshotList,
          sortWith: sortWith,
          formItemDefinitions: {
            'id': ModelFormDefinition<String>(
              label: 'ID',
              isUUID: true,
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
              readOnly: true,
            ),
            'title': ModelFormDefinition<String>(
              label: 'Title',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            'order': ModelFormDefinition<double>(
              label: 'Order',
              initialValue: 0.0,
              validators: [
                FormBuilderValidators.required(),
              ],
              readOnly: true,
            ),
            'price': ModelFormDefinition<double>(
              label: 'Price',
              initialValue: 0.0,
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            'weight': ModelFormDefinition<double>(
              label: 'Weight',
              initialValue: 0.0,
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
          },
          itemBuilder: (product, _) => ProductListTile(
            product: product,
          ),
        );
}
