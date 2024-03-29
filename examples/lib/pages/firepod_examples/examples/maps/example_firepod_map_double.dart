import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodMapDouble extends ConsumerWidget {
  static const basePath = '/v1/testing/map-double';

  static final firepodNoSiteWatch = FirepodMapDouble(
    name: 'ExampleFirepodMapDoubleNoSiteWatch',
    path: '$basePath/site1',
    watch: true,
    autoSave: true,
  );
  static final firepodNoSiteNoWatch = FirepodMapDouble(
    name: 'ExampleMapDoubleFirepodMapDoubleNoSiteNoWatch',
    path: '$basePath/site1',
    watch: false,
    autoSave: true,
  );
  static final firepodSiteWatch = FirepodMapDouble(
    name: 'ExampleMapDoubleFirepodMapDoubleSiteWatch',
    path: '$basePath/{site}',
    watch: true,
    autoSave: true,
  );
  static final firepodSiteNoWatch = FirepodMapDouble(
    name: 'ExampleMapDoubleFirepodMapDoubleSiteNoWatch',
    path: '$basePath/{site}',
    watch: false,
    autoSave: true,
  );

  const ExampleFirepodMapDouble({super.key});

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
          title: 'FirepodMapDouble : no site / watch',
          value: noSiteWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...noSiteWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              noSiteWatchNotifier.update(GenericLookupMap<double>(map: newMap));
            },
          },
        ),
        ValueAndAction(
          title: 'FirepodMapDouble : no site / no watch',
          value: noSiteNoWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...noSiteNoWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              noSiteNoWatchNotifier.update(GenericLookupMap<double>(map: newMap));
            },
          },
        ),
        ValueAndAction(
          title: 'FirepodMapDouble : site / watch',
          value: siteWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...siteWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              siteWatchNotifier.update(GenericLookupMap<double>(map: newMap));
            },
          },
        ),
        ValueAndAction(
          title: 'FirepodMapDouble : site / no watch',
          value: siteNoWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...siteNoWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              siteNoWatchNotifier.update(GenericLookupMap<double>(map: newMap));
            },
          },
        ),
      ],
    );
  }
}
