// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/auth/auth.dart';

mixin FirebaseProviders {
  static final appName = Provider<String>(
    name: 'FirebaseProviders.appName',
    (ref) => defaultFirebaseAppName,
  );
  static final firebaseOptions = Provider<FirebaseOptions>(
    name: 'FirebaseProviders.firebaseOptions',
    (ref) => throw Exception(
      'FirebaseProviders.firebaseOptions provider needs to be overridden..',
    ),
  );

  static final app = Provider<FirebaseApp>(
    name: 'FirebaseProviders.app',
    (ref) => throw Exception(
      'FirebaseProviders.app provider needs to be overridden.',
    ),
  );

  static final auth = Provider<FirebaseAuth>(
    name: 'FirebaseProviders.auth',
    (ref) => throw Exception(
      'FirebaseProviders.auth provider needs to be overridden.',
    ),
  );

  static final authNotifier = Provider<FlutterfireAuthNotifier>(
    name: 'FirebaseProviders.authNotifier',
    (ref) => FlutterfireAuthNotifier(ref),
  );

  static final database = Provider<FirebaseDatabase>(
    name: 'FirebaseProviders.database',
    (ref) => throw Exception(
      'FirebaseProviders.database provider needs to be overridden.',
    ),
  );

  // static final firestore = Provider<FirebaseFirestore>(
  //   name: 'FirebaseFirestore',
  //   (ref) =>
  //       throw Exception('Need to override the FirebaseFirestore provider.'),
  // );

  static final storage = Provider<FirebaseStorage>(
    name: 'FirebaseProviders.storage',
    (ref) => throw Exception(
      'FirebaseProviders.storage provider needs to be overridden.',
    ),
  );

  // static final functions = Provider<FirebaseFunctions>(
  //   name: 'FirebaseFunctions',
  //   (ref) =>
  //       throw Exception('Need to override the FirebaseFunctions provider.'),
  // );
}
