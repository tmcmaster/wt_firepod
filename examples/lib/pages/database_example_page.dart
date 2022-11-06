import 'package:wt_action_button/action_process_indicator.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/actions/normalise_order_values.dart';
import 'package:wt_firepod_examples/forms/product_form.dart';
import 'package:wt_firepod_examples/models/definitions/data_definitions.dart';
import 'package:wt_firepod_examples/models/product.dart';
import 'package:wt_firepod_examples/widgets/product_list_tile.dart';
import 'package:wt_firepod_examples/widgets/selected_item_view.dart';

const debug = false;

final orderedListProvider = StateNotifierProvider<OrderedListNotifier<Product>, List<Product>>(
  name: 'orderedProductListProvider',
  (ref) => OrderedListNotifier<Product>(
    ref,
    snapshotList: Product.from.snapshotList,
    path: 'v1/product',
  ),
);

class DatabaseExamplePage extends ConsumerWidget {
  const DatabaseExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseAction = ref.read(NormaliseOrderValuesAction.provider);
    final database = ref.read(FirebaseProviders.database);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (debug) databaseAction.component(label: 'Read from Database'),
            if (debug)
              const SizedBox(
                height: 50,
              ),
            if (debug)
              SizedBox(
                width: 100,
                child: databaseAction.indicator(type: IndicatorType.linear),
              ),
            if (debug) const SizedBox(height: 50),
            const SizedBox(height: 50),
            FirepodModelView(
              query: database.ref('v1/product/003'),
              snapshotToModel: Product.from.snapshot,
              itemBuilder: (product) => SizedBox(
                width: 250,
                child: ProductListTile(product: product),
              ),
            ),
            if (debug) const SizedBox(height: 50),
            if (debug)
              FirepodDoubleView(
                query: database.ref('v1/product/002/price'),
                itemBuilder: (value) => Text('\$${value.toStringAsFixed(2)}'),
              ),
            const SizedBox(height: 50),
            SelectedItemsView<Product>(selection: DataDefinitions.allProducts.selection),
            if (debug) const SizedBox(height: 50),
            if (debug)
              SizedBox(
                height: 350,
                width: double.infinity,
                child: FirepodListView(
                  table: (database) => database.ref('v1/product'),
                  query: (table) => table.orderByChild('id'),
                  snapshotToModel: Product.from.snapshot,
                  mapToItem: Product.from.json,
                  itemToMap: Product.to.firebaseMap,
                  formItemDefinitions: productFormDefinition,
                  itemBuilder: (product, _) => ProductListTile(
                    product: product,
                  ),
                  selection: DataDefinitions.allProducts.selection,
                ),
              ),
            const SizedBox(height: 50),
            SizedBox(
              height: 350,
              width: double.infinity,
              child: DataDefinitions.allProducts.component(
                canEdit: false,
                canSelect: false,
                canReorder: true,
                onSelect: (model) {
                  print('Selected: $model');
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: databaseAction.component(
          floating: true, noLabel: true), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
