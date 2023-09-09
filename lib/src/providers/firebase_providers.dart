import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  static final firestore = Provider<FirebaseFirestore>(
    name: 'FirebaseFirestore',
    (ref) =>
        throw Exception('Need to override the FirebaseFirestore provider.'),
  );

  static final storage = Provider<FirebaseStorage>(
    name: 'FirebaseStorage',
    (ref) => throw Exception('Need to override the FirebaseStorage provider.'),
  );
  static final functions = Provider<FirebaseFunctions>(
    name: 'FirebaseFunctions',
    (ref) =>
        throw Exception('Need to override the FirebaseFunctions provider.'),
  );
}
