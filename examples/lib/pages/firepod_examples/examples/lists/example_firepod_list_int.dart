import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodListInt extends ConsumerWidget {
  static const basePath = '/v1/testing/list-object';

  static final firepodIntList = FirepodListInt(
    name: 'ExampleFirepodListInt',
    path: '$basePath/integer',
    watch: true,
    autoSave: true,
  );

  const ExampleFirepodListInt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intList = ref.watch(firepodIntList.value);
    final intListNotifier = ref.watch(firepodIntList.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'FirepodListInt',
          value: intList,
          actionMap: {
            'Add': () => intListNotifier.update([...intList, 1]),
            'Remove': () {
              if (intList.length > 1) {
                intListNotifier.update(intList.sublist(0, intList.length - 1));
              }
            },
          },
        ),
      ],
    );
  }
}
