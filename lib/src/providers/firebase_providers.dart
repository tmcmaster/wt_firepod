import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/auth/auth.dart';

mixin FirebaseProviders {
  static final appName = Provider<String>(
    name: 'FirebaseSetup.appName',
    (ref) => defaultFirebaseAppName,
  );
  static final firebaseOptions = Provider<FirebaseOptions>(
    name: 'FirebaseSetup.firebaseOptions',
    (ref) => throw Exception('Need to override the FirebaseOptions provider.'),
  );

  static final app = Provider<FirebaseApp>(
    name: 'FirebaseApp',
    (ref) => throw Exception('Need to override the FirebaseApp provider.'),
  );

  static final auth = Provider<FirebaseAuth>(
    name: 'FirebaseAuth',
    (ref) => throw Exception('Need to override the FirebaseAuth provider.'),
  );

  static final authNotifier = Provider<FlutterfireAuthNotifier>(
    name: 'FlutterfireAuthNotifier',
    (ref) => FlutterfireAuthNotifier(ref),
  );

  static final database = Provider<FirebaseDatabase>(
    name: 'FirebaseDatabase',
    (ref) => throw Exception('Need to override the FirebaseDatabase provider.'),
  );
}
