import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_override_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/auth_providers.dart';
import 'package:wt_firepod/src/login_screen_support/logout_action.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class FirebaseFeatureDefinition extends AppScaffoldFeatureDefinition {
  static final log = logger(FirebaseFeatureDefinition, level: Level.debug);
  FirebaseFeatureDefinition(
    AppScaffoldFeatureDefinition? childFeature, {
    required String appName,
    required FirebaseOptions firebaseOptions,
    required bool auth,
    required bool database,
    required bool storage,
    required bool crashlytics,
    void Function()? onReady,
  }) : super(
          contextBuilder: (contextMap) async {
            log.d('Firebase Initialising');
            WidgetsFlutterBinding.ensureInitialized();

            log.d('Firebase.initializeApp: name($appName)');
            final app = appName == '[DEFAULT]'
                ? await Firebase.initializeApp(
                    options: firebaseOptions,
                  )
                : await Firebase.initializeApp(
                    name: appName,
                    options: firebaseOptions,
                  );
            if (crashlytics) {
              log.i('Setting up Crashlytics');

              FlutterError.onError = (errorDetails) {
                FirebaseCrashlytics.instance
                    .recordFlutterFatalError(errorDetails);
              };
              // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
              PlatformDispatcher.instance.onError = (error, stack) {
                FirebaseCrashlytics.instance
                    .recordError(error, stack, fatal: true);
                return true;
              };
            }

            onReady?.call();

            final newContextMap = {
              ...contextMap,
              FirebaseProviders.appName: AppScaffoldOverrideDefinition(
                value: appName,
                override: FirebaseProviders.appName.overrideWithValue(appName),
              ),
              FirebaseProviders.firebaseOptions: AppScaffoldOverrideDefinition(
                value: firebaseOptions,
                override: FirebaseProviders.firebaseOptions
                    .overrideWithValue(firebaseOptions),
              ),
              FirebaseProviders.app: AppScaffoldOverrideDefinition(
                value: app,
                override: FirebaseProviders.app.overrideWithValue(app),
              ),

              if (auth) FirebaseProviders.auth: _initialiseAuth(app),
              if (auth) AuthProviders.logoutAction: _initialiseLogoutAction(),
              if (auth)
                AuthProviders.loginEnabled: _overrideLoginEnabled(
                  loginEnabled: auth,
                ),
              if (auth)
                GoRouterStore.initialRoute: _overrideInitialRoute(
                  loginEnabled: auth,
                ),
              if (database)
                FirebaseProviders.database: _initialiseDatabase(app),
              // if (firestore) FirebaseProviders.firestore: _initialiseFirestore(app),
              if (storage) FirebaseProviders.storage: _initialiseStorage(app),
              // if (functions) FirebaseProviders.functions: _initialiseFunctions(app),
            };

            if (childFeature == null) {
              return newContextMap;
            } else {
              return childFeature.contextBuilder(newContextMap);
            }
          },
          widgetBuilder: (context, ref) {
            return childFeature == null
                ? Container()
                : childFeature.widgetBuilder(context, ref);
          },
        );

  static AppScaffoldOverrideDefinition _initialiseStorage(
    FirebaseApp app,
  ) {
    final storageInstance = FirebaseStorage.instanceFor(app: app);
    return AppScaffoldOverrideDefinition(
      value: storageInstance,
      override: FirebaseProviders.storage.overrideWithValue(storageInstance),
    );
  }

  static AppScaffoldOverrideDefinition _initialiseAuth(
    FirebaseApp app,
  ) {
    final authInstance = FirebaseAuth.instanceFor(app: app);
    return AppScaffoldOverrideDefinition(
      value: authInstance,
      override: FirebaseProviders.auth.overrideWithValue(authInstance),
    );
  }

  static AppScaffoldOverrideDefinition _initialiseLogoutAction() {
    return AppScaffoldOverrideDefinition(
      value: null,
      override: AuthProviders.logoutAction.overrideWith(
        (ref) => LogoutAction(ref),
      ),
    );
  }

  static AppScaffoldOverrideDefinition _overrideLoginEnabled({
    required bool loginEnabled,
  }) {
    return AppScaffoldOverrideDefinition(
      value: loginEnabled,
      override: AuthProviders.loginEnabled.overrideWith(
        (ref) => loginEnabled,
      ),
    );
  }

  static AppScaffoldOverrideDefinition _overrideInitialRoute({
    required bool loginEnabled,
  }) {
    return AppScaffoldOverrideDefinition(
      value: loginEnabled,
      override: GoRouterStore.initialRoute.overrideWith(
        (ref) => loginEnabled
            ? ref.watch(FirebaseProviders.auth).currentUser == null
                ? '/sign-in'
                : '/'
            : '/',
      ),
    );
  }

  static AppScaffoldOverrideDefinition _initialiseDatabase(
    FirebaseApp app,
  ) {
    final databaseInstance = FirebaseDatabase.instanceFor(app: app);
    return AppScaffoldOverrideDefinition(
      value: databaseInstance,
      override: FirebaseProviders.database.overrideWithValue(databaseInstance),
    );
  }
}
