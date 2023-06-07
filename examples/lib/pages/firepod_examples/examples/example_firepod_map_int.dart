import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodMapInt extends ConsumerWidget {
  static const prefixPath = '/v1/testing/map-int';

  static final firepodNoSiteWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    prefixPath: '$prefixPath/site1',
    watch: true,
    siteEnabled: false,
  );
  static final firepodNoSiteNoWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    prefixPath: '$prefixPath/site1',
    watch: false,
    siteEnabled: false,
  );
  static final firepodSiteWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    prefixPath: prefixPath,
    watch: true,
    siteEnabled: true,
  );
  static final firepodSiteNoWatch = FirepodMapInt(
    name: 'ExampleFirepodMapInt',
    prefixPath: prefixPath,
    watch: false,
    siteEnabled: true,
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
          buttonText: 'Increment Test',
          value: noSiteWatch,
          action: () {
            final newMap = {...noSiteWatch.map};
            newMap['test'] = (newMap['test'] ?? 0) + 1;
            noSiteWatchNotifier.update(GenericLookupMap<int>(map: newMap));
          },
        ),
        ValueAndAction(
          title: 'FirepodMapInt : no site / no watch',
          buttonText: 'Increment Test',
          value: noSiteNoWatch,
          action: () {
            final newMap = {...noSiteNoWatch.map};
            newMap['test'] = (newMap['test'] ?? 0) + 1;
            noSiteNoWatchNotifier.update(GenericLookupMap<int>(map: newMap));
          },
        ),
        ValueAndAction(
          title: 'FirepodMapInt : site / watch',
          buttonText: 'Increment Test',
          value: siteWatch,
          action: () {
            final newMap = {...siteWatch.map};
            newMap['test'] = (newMap['test'] ?? 0) + 1;
            siteWatchNotifier.update(GenericLookupMap<int>(map: newMap));
          },
        ),
        ValueAndAction(
          title: 'FirepodMapInt : site / no watch',
          buttonText: 'Increment Test',
          value: siteNoWatch,
          action: () {
            final newMap = {...siteNoWatch.map};
            newMap['test'] = (newMap['test'] ?? 0) + 1;
            siteNoWatchNotifier.update(GenericLookupMap<int>(map: newMap));
          },
        ),
      ],
    );
  }
}
