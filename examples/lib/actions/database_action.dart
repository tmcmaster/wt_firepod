import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_action_button/wt_action_button.dart';
import 'package:wt_firepod/wt_firepod.dart';

class DatabaseAction extends ActionButtonDefinition {
  static final log = logger(DatabaseAction, level: Level.debug);

  static final provider = Provider(
    name: 'Database Action',
    (ref) => DatabaseAction(ref),
  );

  DatabaseAction(super.ref)
      : super(
          label: 'Database Action',
          icon: FontAwesomeIcons.database,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.run(() async {
      log.d('Doing Database Action......');
      final hello = await ref.read(FirebaseProviders.database).ref('v1').child('hello').get();
      log.d('Database Action Completed: ${hello.value}');
      final person = await ref.read(FirebaseProviders.database).ref('v1').child('product').get();
      print('Person(${person.value})');
    });
  }
}
