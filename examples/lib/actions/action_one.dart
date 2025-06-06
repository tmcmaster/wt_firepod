import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:wt_action_button/model/action_info.dart';
import 'package:wt_action_button/wt_action_button.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionOne extends ActionButtonDefinition {
  static final log = logger(ActionOne, level: Level.debug);

  static final provider = Provider(
    name: 'Action One',
    (ref) => ActionOne(ref),
  );

  ActionOne(super.ref)
      : super(
          actionInfo: ActionInfo(
            label: 'Action One',
            tooltip: 'Action One',
            icon: Icons.menu,
          ),
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start(total: 1);
    log.d('Doing Action......');
    await Future.delayed(const Duration(seconds: 5));
    log.d('Action Completed.');
    notifier.finished();
  }
}
