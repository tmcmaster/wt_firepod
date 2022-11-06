import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_action_button/wt_action_button.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/database_example_page.dart';

class NormaliseOrderValuesAction extends ActionButtonDefinition {
  static final log = logger(NormaliseOrderValuesAction, level: Level.debug);

  static final provider = Provider(
    name: 'Normalise Order Values',
    (ref) => NormaliseOrderValuesAction(ref),
  );

  NormaliseOrderValuesAction(super.ref)
      : super(
          label: 'Normalise Order Values Action',
          icon: FontAwesomeIcons.database,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.run(() {
      ref.read(orderedListProvider.notifier).normaliseOrderValue();
    });
  }
}
