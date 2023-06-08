import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/models/product.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodMapObject extends ConsumerWidget {
  static const basePath = '/v1/testing/map-object';

  static const decoder = Product.fromJsonDynamic;
  static final encoder = Product.to.jsonFromModel;

  static final firepodNoSiteWatch = FirepodMapObject<Product>(
    name: 'ExampleFirepodMapObjectNoSiteWatch',
    path: '$basePath/site1',
    watch: true,
    siteEnabled: false,
    modelDecoder: decoder,
    modelEncoder: encoder,
    keyField: 'id',
  );
  static final firepodNoSiteNoWatch = FirepodMapObject<Product>(
    name: 'ExampleFirepodMapObjectNoSiteNoWatch',
    path: '$basePath/site1',
    watch: false,
    siteEnabled: false,
    modelDecoder: decoder,
    modelEncoder: encoder,
    keyField: 'id',
  );
  static final firepodSiteWatch = FirepodMapObject<Product>(
    name: 'ExampleFirepodMapObjectSiteWatch',
    path: '$basePath/{site}',
    watch: true,
    siteEnabled: true,
    modelDecoder: decoder,
    modelEncoder: encoder,
    keyField: 'id',
  );
  static final firepodSiteNoWatch = FirepodMapObject<Product>(
    name: 'ExampleFirepodMapObjectSiteNoWatch',
    path: '$basePath/{site}',
    watch: false,
    siteEnabled: true,
    modelDecoder: decoder,
    modelEncoder: encoder,
    keyField: 'id',
  );

  const ExampleFirepodMapObject({super.key});

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
          title: 'FirepodMapObject : no site / watch',
          value: noSiteWatch,
          actionMap: {
            'Increment Test': () => _updateValue(noSiteWatch, noSiteWatchNotifier),
          },
        ),
        ValueAndAction(
          title: 'FirepodMapObject : no site / no watch',
          value: noSiteNoWatch,
          actionMap: {
            'Increment Test': () => _updateValue(noSiteNoWatch, noSiteNoWatchNotifier),
          },
        ),
        ValueAndAction(
          title: 'FirepodMapObject : site / watch',
          value: siteWatch,
          actionMap: {
            'Increment Test': () => _updateValue(siteWatch, siteWatchNotifier),
          },
        ),
        ValueAndAction(
          title: 'FirepodMapObject : site / no watch',
          value: siteNoWatch,
          actionMap: {
            'Increment Test': () => _updateValue(siteNoWatch, siteNoWatchNotifier),
          },
        ),
      ],
    );
  }

  void _updateValue(
    GenericLookupMap<Product> noSiteNoWatch,
    GenericSiteDataNotifier<GenericLookupMap> noSiteNoWatchNotifier,
  ) {
    final newMap = {...noSiteNoWatch.map};
    if (newMap.containsKey('test')) {
      newMap['test'] = newMap['test']!.copyWith(
        weight: newMap['test']!.weight + 1,
      );
      noSiteNoWatchNotifier.update(GenericLookupMap<Product>(map: newMap));
    }
  }
}
