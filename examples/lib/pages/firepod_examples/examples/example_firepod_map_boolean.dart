import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodMapBoolean extends ConsumerWidget {
  static const prefixPath = '/v1/testing/map-boolean';

  static final firepodNoSiteWatch = FirepodMapBoolean(
    name: 'ExampleFirepodMapBooleanNoSiteWatch',
    path: '$prefixPath/site1',
    watch: true,
    siteEnabled: false,
  );
  static final firepodNoSiteNoWatch = FirepodMapBoolean(
    name: 'ExampleMapBooleanFirepodMapBooleanNoSiteNoWatch',
    path: '$prefixPath/site1',
    watch: false,
    siteEnabled: false,
  );
  static final firepodSiteWatch = FirepodMapBoolean(
    name: 'ExampleMapBooleanFirepodMapBooleanSiteWatch',
    path: '$prefixPath/{site}',
    watch: true,
    siteEnabled: true,
  );
  static final firepodSiteNoWatch = FirepodMapBoolean(
    name: 'ExampleMapBooleanFirepodMapBooleanSiteNoWatch',
    path: '$prefixPath/{site}',
    watch: false,
    siteEnabled: true,
  );

  const ExampleFirepodMapBoolean({super.key});

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
          title: 'FirepodMapBoolean : no site / watch',
          buttonText: 'Increment Test',
          value: noSiteWatch,
          action: () {
            final newMap = {...noSiteWatch.map};
            newMap['test'] = !(newMap['test'] ?? true);
            noSiteWatchNotifier.update(GenericLookupMap<bool>(map: newMap));
          },
        ),
        ValueAndAction(
          title: 'FirepodMapBoolean : no site / no watch',
          buttonText: 'Increment Test',
          value: noSiteNoWatch,
          action: () {
            final newMap = {...noSiteNoWatch.map};
            newMap['test'] = !(newMap['test'] ?? true);
            noSiteNoWatchNotifier.update(GenericLookupMap<bool>(map: newMap));
          },
        ),
        ValueAndAction(
          title: 'FirepodMapBoolean : site / watch',
          buttonText: 'Increment Test',
          value: siteWatch,
          action: () {
            final newMap = {...siteWatch.map};
            newMap['test'] = !(newMap['test'] ?? true);
            siteWatchNotifier.update(GenericLookupMap<bool>(map: newMap));
          },
        ),
        ValueAndAction(
          title: 'FirepodMapBoolean : site / no watch',
          buttonText: 'Increment Test',
          value: siteNoWatch,
          action: () {
            final newMap = {...siteNoWatch.map};
            newMap['test'] = !(newMap['test'] ?? true);
            siteNoWatchNotifier.update(GenericLookupMap<bool>(map: newMap));
          },
        ),
      ],
    );
  }
}
