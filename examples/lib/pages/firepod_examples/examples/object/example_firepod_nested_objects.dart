import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/models/customer.dart';
import 'package:wt_firepod_examples/models/delivery.dart';
import 'package:wt_firepod_examples/models/driver.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/models/product.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';
import 'package:wt_logging/wt_logging.dart';

class ExampleFirepodNestedObjects extends ConsumerWidget {
  static final log = logger(ExampleFirepodNestedObjects, level: Level.warning);

  static const basePath = '/v1/testing/nested_objects';
  static final decoder = Delivery.convert.from.dynamicMap.to.model;
  static final encoder = Delivery.convert.to.jsonMap.from.model;
  static const none = Delivery.none;

  static final deliveryProvider = FirepodObject<Delivery>(
    name: 'ExampleFirepodNestedObjects',
    path: '$basePath/delivery',
    decoder: decoder,
    encoder: encoder,
    none: none,
    watch: true,
    autoSave: true,
  );
  static final deliveryListProvider = FirepodListObject<Delivery>(
    name: 'ExampleFirepodNestedObjects',
    path: '$basePath/delivery_list',
    decoder: decoder,
    encoder: encoder,
    watch: true,
    autoSave: true,
  );

  const ExampleFirepodNestedObjects({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final delivery = ref.watch(deliveryProvider.value);
    final deliveryList = ref.watch(deliveryListProvider.value);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'List of nested objecrs',
          value: deliveryList,
          actionMap: {
            'Nothing': () {},
          },
        ),
        ValueAndAction(
          title: 'FirepodObject : no site / watch',
          value: delivery,
          actionMap: {
            'Create': () {
              final delivery = Delivery(
                id: '001',
                customer: const Customer(
                  id: '002',
                  name: 'Customer 2',
                  phone: '2222 222 222',
                  email: 'two@example.com',
                  address: '2 Main st.',
                  postcode: 2222,
                ),
                driver: const Driver(
                  id: '003',
                  name: 'Driver 3',
                  phone: '3333 333 333',
                ),
                products: [
                  Product(
                    order: 4,
                    price: 4.4,
                    title: 'Product 4',
                    weight: 4.4,
                  )
                ],
              );

              log.d(Delivery.convert.to.jsonMapString.from.model(delivery));
            }
          },
        ),
      ],
    );
  }
}
