import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodListBool extends ConsumerWidget {
  static const basePath = '/v1/testing/list-object';

  static final firepodBoolList = FirepodListBool(
    name: 'ExampleFirepodListBool',
    path: '$basePath/boolean',
    watch: true,
    autoSave: true,
  );

  const ExampleFirepodListBool({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boolList = ref.watch(firepodBoolList.value);
    final boolListNotifier = ref.watch(firepodBoolList.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'FirepodListBool',
          value: boolList,
          actionMap: {
            'Add': () => boolListNotifier.update([...boolList, true]),
            'Remove': () {
              if (boolList.length > 1) {
                boolListNotifier.update(boolList.sublist(0, boolList.length - 1));
              }
            },
          },
        ),
      ],
    );
  }
}
