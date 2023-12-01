import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

export 'package:wt_action_button/wt_action_button.dart';

class LogoutAction extends ActionButtonDefinition {
  static final log = logger(LogoutAction);

  static final provider = Provider(
    name: 'Logout Action',
    (ref) => LogoutAction(ref),
  );

  LogoutAction(super.ref)
      : super(
          label: 'Logout',
          icon: Icons.menu,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start(total: 1);
    log.d('Logging Out......');
    await ref.read(FirebaseProviders.auth).signOut();
    log.d('Logged Out.');
    notifier.finished();
  }
}
