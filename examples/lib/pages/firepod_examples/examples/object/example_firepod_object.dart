import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/models/product.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodObject extends ConsumerWidget {
  static const basePath = '/v1/testing/object';
  static const decoder = Product.fromJsonDynamic;
  static final encoder = Product.to.jsonFromModel;
  static final none = Product.none;

  static final firepodNoSiteWatch = FirepodObject<Product>(
    name: 'ExampleFirepodObjectNoSiteWatch',
    path: '$basePath/site1',
    decoder: decoder,
    encoder: encoder,
    none: none,
    watch: true,
  );
  static final firepodNoSiteNoWatch = FirepodObject<Product>(
    name: 'ExampleFirepodObjectNoSiteNoWatch',
    path: '$basePath/site1',
    decoder: decoder,
    encoder: encoder,
    none: none,
    watch: false,
  );
  static final firepodSiteWatch = FirepodObject<Product>(
    name: 'ExampleFirepodObjectSiteWatch',
    path: '$basePath/{site}',
    decoder: decoder,
    encoder: encoder,
    none: none,
    watch: true,
  );
  static final firepodSiteNoWatch = FirepodObject<Product>(
    name: 'ExampleFirepodObjectSiteNoWatch',
    path: '$basePath/{site}',
    decoder: decoder,
    encoder: encoder,
    none: none,
    watch: false,
  );

  const ExampleFirepodObject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noSiteWatch = ref.watch(firepodNoSiteWatch.value);
    final noSiteWatchNotifier = ref.watch(firepodNoSiteWatch.notifier);
    final noSiteNoWatch = ref.watch(firepodNoSiteNoWatch.value);
    final noSiteNoWatchNotifier = ref.watch(firepodNoSiteNoWatch.notifier);
    final siteWatch = ref.watch(firepodSiteWatch.value);
    final siteWatchNotifier = ref.watch(firepodSiteWatch.notifier);
    final siteNoWatch = ref.watch(firepodSiteNoWatch.value);
    final siteNoWatchNotifier = ref.watch(firepodSiteNoWatch.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'FirepodObject : no site / watch',
          value: noSiteWatch,
          actionMap: {
            'Increment Weight': () {
              noSiteWatchNotifier.update(
                noSiteWatch.copyWith(
                  weight: noSiteWatch.weight + 1.0,
                ),
              );
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodObject : no site / no watch',
          value: noSiteNoWatch,
          actionMap: {
            'Increment Weight': () {
              noSiteNoWatchNotifier.update(
                noSiteNoWatch.copyWith(
                  weight: noSiteNoWatch.weight + 1.0,
                ),
              );
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodObject : site / watch',
          value: siteWatch,
          actionMap: {
            'Increment Weight': () {
              siteWatchNotifier.update(
                siteWatch.copyWith(
                  weight: siteWatch.weight + 1.0,
                ),
              );
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodObject : site / no watch',
          value: siteNoWatch,
          actionMap: {
            'Increment Weight': () {
              siteNoWatchNotifier.update(
                siteNoWatch.copyWith(
                  weight: siteNoWatch.weight + 1.0,
                ),
              );
            }
          },
        )
      ],
    );
  }
}
