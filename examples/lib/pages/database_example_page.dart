import 'package:wt_action_button/action_process_indicator.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/actions/database_action.dart';
import 'package:wt_firepod_examples/models/product.dart';
import 'package:wt_firepod_examples/widgets/product_list_tile.dart';

final selectedItemsProvider =
    StateNotifierProvider<SelectedItems<Product>, Set<Product>>((ref) => SelectedItems<Product>());

class DatabaseExamplePage extends ConsumerWidget {
  const DatabaseExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseAction = ref.read(DatabaseAction.provider);
    final database = ref.read(FirebaseProviders.database);

    final selectionNotifier = ref.read(selectedItemsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            databaseAction.component(label: 'Read from Database'),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 100,
              child: databaseAction.indicator(type: IndicatorType.linear),
            ),
            const SizedBox(height: 50),
            FirepodModelView(
              query: database.ref('v1/product/003'),
              snapshotToModel: Product.from.snapshot,
              itemBuilder: (product) => SizedBox(
                width: 250,
                child: ProductListTile(product: product),
              ),
            ),
            const SizedBox(height: 50),
            FirepodDoubleView(
              query: database.ref('v1/product/002/price'),
              itemBuilder: (value) => Text('\$${value.toStringAsFixed(2)}'),
            ),
            const SizedBox(height: 50),
            const SelectedItemsView(),
            const SizedBox(height: 50),
            SizedBox(
              height: 350,
              width: double.infinity,
              child: FirepodEditableListView(
                table: database.ref('v1/product'),
                query: (table) => table.orderByChild('id'),
                snapshotToModel: Product.from.snapshot,
                itemBuilder: (product, _) => ProductListTile(product: product),
                selection: selectionNotifier,
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

class SelectedItemsView extends ConsumerWidget {
  const SelectedItemsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItemsProvider);

    return Consumer(
      builder: (_, ref, __) => Row(
        children: selected.map((i) => Text(i.title)).toList(),
      ),
    );
  }
}
