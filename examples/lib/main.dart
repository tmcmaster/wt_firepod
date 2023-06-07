import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/config/app_secrets.dart';
import 'package:wt_firepod_examples/firebase_options.dart';
import 'package:wt_firepod_examples/pages/firepod_examples_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    name: 'firepodExampleApp',
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((app) {
    FirebaseAuth.instanceFor(app: app)
        .signInWithEmailAndPassword(
      email: AppSecrets.userName,
      password: AppSecrets.password,
    )
        .then((user) {
      print('User logged in: $user');
      runApp(
        ProviderScope(
          overrides: [
            FirebaseProviders.database.overrideWithValue(FirebaseDatabase.instanceFor(app: app)),
            FirebaseProviders.auth.overrideWithValue(FirebaseAuth.instanceFor(app: app)),
          ],
          child: const MaterialApp(home: FirepodExamplesPage()),
        ),
      );
    }, onError: (error) {
      print('LOGIN ERROR: $error');
    });
    ;
  }, onError: (error) {
    debugPrint('ERROR: $error');
  });
}
