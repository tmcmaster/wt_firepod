import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_providers.dart';

class FirebaseSetup {
  static final instance = FirebaseSetup._();

  late AlwaysAliveProviderBase<FirebaseApp> app;
  late AlwaysAliveProviderBase<FirebaseDatabase> database;
  late AlwaysAliveProviderBase<FirebaseAuth> auth;

  FirebaseSetup._() {
    app = Provider(
      name: 'FirebaseSetup : App',
      (ref) {
        final appName = ref.read(FirebaseProviders.appName);
        return Firebase.app(appName);
      },
    );
    auth = Provider(
      name: 'FirebaseSetup : Auth',
      (ref) {
        final firebaseApp = ref.read(app);
        return FirebaseAuth.instanceFor(app: firebaseApp);
      },
    );
    database = Provider(name: 'FirebaseSetup : Database', (ref) {
      final firebaseApp = ref.read(app);
      return FirebaseDatabase.instanceFor(app: firebaseApp);
    });
  }
}
