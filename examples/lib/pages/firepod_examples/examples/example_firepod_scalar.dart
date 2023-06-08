import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/widgets/value_and_action.dart';

class ExampleFirepodScalar extends ConsumerWidget {
  static const basePath = '/v1/testing/scalar';

  static final firepodScalarString = FirepodScalar<String>(
    name: 'ExampleFirepodScalarString',
    path: '$basePath/string',
    none: '',
    watch: true,
    siteEnabled: false,
  );
  static final firepodScalarInt = FirepodScalar<int>(
    name: 'ExampleFirepodScalarInt',
    path: '$basePath/integer',
    none: 0,
    watch: true,
    siteEnabled: false,
  );
  static final firepodScalarDouble = FirepodScalar<double>(
    name: 'ExampleFirepodScalarString',
    path: '$basePath/string',
    none: 0.0,
    watch: true,
    siteEnabled: false,
  );
  static final firepodScalarBool = FirepodScalar<bool>(
    name: 'ExampleFirepodScalarBool',
    path: '$basePath/boolean',
    none: true,
    watch: true,
    siteEnabled: false,
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
          buttonText: 'Increment',
          value: scalarString,
          action: () {
            scalarStringNotifier.update('${scalarString}a');
          },
        ),
        ValueAndAction(
          title: 'FirepodScalarInt',
          buttonText: 'Increment',
          value: scalarInt,
          action: () {
            scalarIntNotifier.update(scalarInt + 1);
          },
        ),
        ValueAndAction(
          title: 'FirepodScalarDouble',
          buttonText: 'Increment',
          value: scalarDouble,
          action: () {
            scalarDoubleNotifier.update(scalarDouble + 1.0);
          },
        ),
        ValueAndAction(
          title: 'FirepodScalarBool',
          buttonText: 'Toggle',
          value: scalarBool,
          action: () {
            scalarBoolNotifier.update(!scalarBool);
          },
        ),
      ],
    );
  }
}
