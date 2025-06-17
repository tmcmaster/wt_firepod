import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/firebase_options.dart';
import 'package:wt_firepod_examples/pages/firepod_examples_page.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_prototyping/prototyping.dart';

void main() {
  runMyApp(
    withFirebase(
      andAuthGateway(
        andAppScaffold(
          appDefinition: ExampleApp.definition,
          appStyles: ExampleApp.styles,
        ),
      ),
      database: true,
      crashlytics: false,
      appName: 'wix-admin',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
    setApplicationLogLevel: Level.debug,
    onReady: (context, ref) {
      Future.delayed(const Duration(seconds: 1), () {
        ref.read(UserLog.provider).log('Test log message');
      });
    },
    enableProviderMonitoring: false,
    includeOverrides: [],
    providerManager: FirepodProviderManager.provider,
  );
}

mixin ExampleApp {
  static final definition = AppDefinition.from(
    appDetails: AppDetails(
      name: 'exampleApp',
      title: 'Example App',
      subTitle: 'Testing Login Screen',
      iconPath: 'assets/avocado.png',
    ),
    includeAppBar: true,
    menuAction: (context) => HiddenDrawerOpener.of(context)?.open(),
    profilePage: PageDefinition(
      info: PageInfo(
        name: 'profile',
        title: 'Profile',
        icon: Icons.person,
      ),
      pageBuilder: (_) => const PlaceholderPage(title: 'Profile Page'),
    ),
    pages: [
      PageDefinition(
        info: PageInfo(
          name: 'examples',
          title: 'Examples',
          icon: FontAwesomeIcons.bug,
          itemType: ItemType.primary,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (_) => const FirepodExamplesPage(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'userLog',
          title: 'User Log',
          icon: Icons.info,
          itemType: ItemType.primary,
          landing: true,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('User Log'),
          ),
          body: const UserLogView(),
        ),
      ),
    ],
  );

  static AppStyles styles(Ref ref) {
    final appStyles = SharedAppConfig.styles(ref);
    return appStyles.copyWith(
      theme: appStyles.theme.copyWith(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thickness: WidgetStateProperty.all(0),
        ),
      ),
    );
  }
}
