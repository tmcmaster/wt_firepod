import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodListString extends ConsumerWidget {
  static const basePath = '/v1/testing/list-object';

  static final firepodStringList = FirepodListString(
    name: 'ExampleFirepodListString',
    path: '$basePath/strings',
    watch: true,
    autoSave: true,
  );

  const ExampleFirepodListString({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stringList = ref.watch(firepodStringList.value);
    final stringListNotifier = ref.watch(firepodStringList.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'FirepodListString',
          value: stringList,
          actionMap: {
            'Add': () => stringListNotifier.update([...stringList, 'a']),
            'Remove': () {
              if (stringList.length > 1) {
                stringListNotifier.update(stringList.sublist(0, stringList.length - 1));
              }
            },
          },
        ),
      ],
    );
  }
}
