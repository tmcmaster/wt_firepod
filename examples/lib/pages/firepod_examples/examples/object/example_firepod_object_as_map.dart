import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';
import 'package:wt_models/wt_models.dart';

class ExampleFirepodObjectAsMap extends ConsumerWidget {
  static const basePath = '/v1/testing/nested_objects';

  static final deliveryJsonMapProvider = FirepodObject<JsonMap>(
    name: 'ExampleFirepodObjectAsMap',
    path: '$basePath/delivery',
    decoder: (map) => {for (final e in map.entries) e.key.toString(): e.value},
    encoder: (map) => map,
    none: {},
    watch: true,
    autoSave: true,
  );

  const ExampleFirepodObjectAsMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryAsMap = ref.watch(deliveryJsonMapProvider.value);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'nested object as a map',
          value: deliveryAsMap,
          actionMap: {'Nothing': () {}},
        ),
      ],
    );
  }
}
