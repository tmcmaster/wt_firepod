import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodMapInt extends ConsumerWidget {
  static const basePath = '/v1/testing/map-int';

  static final firepodNoSiteWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    path: '$basePath/site1',
    watch: true,
    autoSave: true,
  );
  static final firepodNoSiteNoWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    path: '$basePath/site1',
    watch: false,
    autoSave: true,
  );
  static final firepodSiteWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    path: '$basePath/{site}',
    watch: true,
    autoSave: true,
  );
  static final firepodSiteNoWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    path: '$basePath/{site}',
    watch: false,
    autoSave: true,
  );

  const ExampleFirepodMapInt({super.key});

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
          title: 'FirepodMapInt : no site / watch',
          value: noSiteWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...noSiteWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              noSiteWatchNotifier.update(GenericLookupMap<int>(map: newMap));
            },
          },
        ),
        ValueAndAction(
          title: 'FirepodMapInt : no site / no watch',
          value: noSiteNoWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...noSiteNoWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              noSiteNoWatchNotifier.update(GenericLookupMap<int>(map: newMap));
            },
          },
        ),
        ValueAndAction(
          title: 'FirepodMapInt : site / watch',
          value: siteWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...siteWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              siteWatchNotifier.update(GenericLookupMap<int>(map: newMap));
            },
          },
        ),
        ValueAndAction(
          title: 'FirepodMapInt : site / no watch',
          value: siteNoWatch,
          actionMap: {
            'Increment Test': () {
              final newMap = {...siteNoWatch.map};
              newMap['test'] = (newMap['test'] ?? 0) + 1;
              siteNoWatchNotifier.update(GenericLookupMap<int>(map: newMap));
            },
          },
        ),
      ],
    );
  }
}
