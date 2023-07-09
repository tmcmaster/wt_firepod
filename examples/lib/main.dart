import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/config/app_secrets.dart';
import 'package:wt_firepod_examples/firebase_options.dart';
import 'package:wt_firepod_examples/pages/firepod_examples_page.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  final log = logger('Examples Main', level: Level.warning);

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    name: 'firepodExampleApp',
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (app) {
      FirebaseAuth.instanceFor(app: app)
          .signInWithEmailAndPassword(
        email: AppSecrets.userName,
        password: AppSecrets.password,
      )
          .then(
        (user) {
          log.d('User logged in: $user');
          runApp(
            ProviderScope(
              overrides: [
                FirebaseProviders.database
                    .overrideWithValue(FirebaseDatabase.instanceFor(app: app)),
                FirebaseProviders.auth.overrideWithValue(FirebaseAuth.instanceFor(app: app)),
              ],
              child: const MaterialApp(home: FirepodExamplesPage()),
            ),
          );
        },
        onError: (error) {
          log.e('LOGIN ERROR: $error');
        },
      );
    },
    onError: (error) {
      log.e('ERROR: $error');
    },
  );
}
