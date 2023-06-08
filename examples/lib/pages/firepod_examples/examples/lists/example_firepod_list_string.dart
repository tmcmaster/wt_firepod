import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodListString extends ConsumerWidget {
  static const basePath = '/v1/testing/list-object';

  static String? decoder(Object? value) {
    return value.toString();
  }

  static dynamic encoder(String value) {
    return value.toString();
  }

  static final firepodStringList = FirepodListString(
    name: 'ExampleFirepodListObject',
    path: '$basePath/strings',
    watch: true,
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
          buttonText: 'Add',
          value: stringList,
          action: () => stringListNotifier.update([...stringList, 'a']),
        ),
      ],
    );
  }
}
