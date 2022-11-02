import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/firebase_options.dart';
import 'package:wt_firepod_examples/pages/async_example_page.dart';
import 'package:wt_firepod_examples/pages/database_example_page.dart';

void main() {
  runMyApp(
    withFirebase(
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      andAppScaffold(
        appDefinition: appOne,
        loginSupport: const LoginSupport(
          emailEnabled: true,
          googleEnabled: true,
        ),
      ),
    ),
  );
}

final appOne = Provider<AppDefinition>(
  name: 'Firepod Example App',
  (ref) => AppDefinition.from(
    appTitle: 'Firepod Example App',
    appName: 'firepodExampleApp',
    appDetails: AppDetails(
      title: 'Firepod',
      subTitle: 'Example Application',
      iconPath: 'assets/avocado.png',
    ),
    swipeEnabled: true,
    debugMode: false,
    appDetailsProvider: null,
    profilePage: PageDefinition(
      icon: Icons.person,
      title: 'Profile',
      builder: (context) => const PlaceholderPage(
        title: 'Profile',
      ),
    ),
    pages: [
      PageDefinition(
        title: 'Database',
        icon: FontAwesomeIcons.bagShopping,
        primary: true,
        debug: false,
        builder: (_) => const DatabaseExamplePage(),
      ),
      PageDefinition(
        title: 'Async',
        icon: FontAwesomeIcons.bagShopping,
        primary: true,
        debug: false,
        builder: (_) => const AsyncExamplePage(),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        primary: true,
        builder: (context) => SettingsPage(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                },
                child: const Text('Login'))
          ],
        ),
      ),
    ],
  ),
);
