import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodMapString extends ConsumerWidget {
  static const basePath = '/v1/testing/map-string';

  static final firepodNoSiteWatch = FirepodMapString(
    name: 'ExampleFirepodMapStringNoSiteWatch',
    path: '$basePath/site1',
    watch: true,
    autoSave: true,
  );
  static final firepodNoSiteNoWatch = FirepodMapString(
    name: 'ExampleMapStringFirepodMapStringNoSiteNoWatch',
    path: '$basePath/site1',
    watch: false,
    autoSave: true,
  );
  static final firepodSiteWatch = FirepodMapString(
    name: 'ExampleMapStringFirepodMapStringSiteWatch',
    path: '$basePath/{site}',
    watch: true,
    autoSave: true,
  );
  static final firepodSiteNoWatch = FirepodMapString(
    name: 'ExampleMapStringFirepodMapStringSiteNoWatch',
    path: '$basePath/{site}',
    watch: false,
    autoSave: true,
  );

  const ExampleFirepodMapString({super.key});

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
          title: 'FirepodMapString : no site / watch',
          value: noSiteWatch,
          actionMap: {
            'Add to Test': () {
              final newMap = {...noSiteWatch.map};
              newMap['test'] = '${newMap['test'] ?? ''}a';
              noSiteWatchNotifier.update(GenericLookupMap<String>(map: newMap));
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodMapString : no site / no watch',
          value: noSiteNoWatch,
          actionMap: {
            'Add to Test': () {
              final newMap = {...noSiteNoWatch.map};
              newMap['test'] = '${newMap['test'] ?? ''}a';
              noSiteNoWatchNotifier.update(GenericLookupMap<String>(map: newMap));
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodMapString : site / watch',
          value: siteWatch,
          actionMap: {
            'Add to Test': () {
              final newMap = {...siteWatch.map};
              newMap['test'] = '${newMap['test'] ?? ''}a';
              siteWatchNotifier.update(GenericLookupMap<String>(map: newMap));
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodMapString : site / no watch',
          value: siteNoWatch,
          actionMap: {
            'Add to Test': () {
              final newMap = {...siteNoWatch.map};
              newMap['test'] = '${newMap['test'] ?? ''}a';
              siteNoWatchNotifier.update(GenericLookupMap<String>(map: newMap));
            }
          },
        ),
      ],
    );
  }
}
