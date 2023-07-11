import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class ExampleFirepodSite extends ConsumerWidget {
  static final log = logger(ExampleFirepodSite, level: Level.warning);
  const ExampleFirepodSite({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siteList = ref.watch(ExampleUserSiteList.userSiteList.value);
    final testing = ref.watch(ExampleUserSiteList.testing.value);
    final site = ref.read(FirepodSettings.site.value);
    log.d('SITE : $site');
    log.d('SITE LIST : $siteList');
    log.d('SITE LIST 2: $testing');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FirepodSettings.site.component,
      ],
    );
  }
}
