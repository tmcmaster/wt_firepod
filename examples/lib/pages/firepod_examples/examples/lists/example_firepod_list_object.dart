import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/models/product.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodListObject extends ConsumerWidget {
  static const basePath = '/v1/testing/list-object';

  static const decoder = Product.fromJsonDynamic;
  static final encoder = Product.to.jsonFromModel;

  static final firepodProductList = FirepodListObject<Product>(
    name: 'ExampleFirepodMapObjectNoSiteWatch',
    path: '$basePath/products',
    watch: true,
    autoSave: true,
    decoder: decoder,
    encoder: encoder,
    keyField: 'id',
  );

  const ExampleFirepodListObject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(firepodProductList.value);
    final productListNotifier = ref.watch(firepodProductList.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'FirepodListObject : Products',
          value: productList,
          actionMap: {
            'Add': () => productListNotifier.update([
                  ...productList,
                  Product(
                    order: 1,
                    price: 2,
                    title: 'New Product',
                    weight: 3,
                  )
                ]),
            'Remove': () {
              if (productList.length > 1) {
                productListNotifier.update(productList.sublist(0, productList.length - 1));
              }
            },
          },
        ),
      ],
    );
  }
}
