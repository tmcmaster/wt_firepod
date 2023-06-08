import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodListDouble extends ConsumerWidget {
  static const basePath = '/v1/testing/list-object';

  static final firepodDoubleList = FirepodListDouble(
    name: 'ExampleFirepodListDouble',
    path: '$basePath/double',
    watch: true,
    autoSave: true,
  );

  const ExampleFirepodListDouble({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doubleList = ref.watch(firepodDoubleList.value);
    final doubleListNotifier = ref.watch(firepodDoubleList.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'FirepodListDouble',
          value: doubleList,
          actionMap: {
            'Add': () => doubleListNotifier.update([...doubleList, 1]),
            'Remove': () {
              if (doubleList.length > 1) {
                doubleListNotifier.update(doubleList.sublist(0, doubleList.length - 1));
              }
            },
          },
        ),
      ],
    );
  }
}
