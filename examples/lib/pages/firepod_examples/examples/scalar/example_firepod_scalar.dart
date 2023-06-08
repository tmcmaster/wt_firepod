import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodScalar extends ConsumerWidget {
  static const basePath = '/v1/testing/scalar';

  static final firepodScalarString = FirepodScalarString(
    name: 'ExampleFirepodScalarString',
    path: '$basePath/string',
    watch: true,
  );
  static final firepodScalarInt = FirepodScalarInt(
    name: 'ExampleFirepodScalarInt',
    path: '$basePath/integer',
    watch: true,
  );
  static final firepodScalarDouble = FirepodScalarDouble(
    name: 'ExampleFirepodScalarDouble',
    path: '$basePath/double',
    watch: true,
  );
  static final firepodScalarBool = FirepodScalarBool(
    name: 'ExampleFirepodScalarBool',
    path: '$basePath/boolean',
    watch: true,
  );

  const ExampleFirepodScalar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scalarString = ref.watch(firepodScalarString.value);
    final scalarStringNotifier = ref.watch(firepodScalarString.notifier);
    final scalarInt = ref.watch(firepodScalarInt.value);
    final scalarIntNotifier = ref.watch(firepodScalarInt.notifier);
    final scalarDouble = ref.watch(firepodScalarDouble.value);
    final scalarDoubleNotifier = ref.watch(firepodScalarDouble.notifier);
    final scalarBool = ref.watch(firepodScalarBool.value);
    final scalarBoolNotifier = ref.watch(firepodScalarBool.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueAndAction(
          title: 'FirepodScalarString',
          value: scalarString,
          actionMap: {
            'Increment': () {
              scalarStringNotifier.update('${scalarString}a');
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodScalarInt',
          value: scalarInt,
          actionMap: {
            'Increment': () {
              scalarIntNotifier.update(scalarInt + 1);
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodScalarDouble',
          value: scalarDouble,
          actionMap: {
            'Increment': () {
              scalarDoubleNotifier.update(scalarDouble + 1.0);
            }
          },
        ),
        ValueAndAction(
          title: 'FirepodScalarBool',
          value: scalarBool,
          actionMap: {
            'Toggle': () {
              scalarBoolNotifier.update(!scalarBool);
            }
          },
        ),
      ],
    );
  }
}
