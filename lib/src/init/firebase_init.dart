import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

Future<ProviderScope> Function() Function(
  Future<dynamic> Function(
    FirebaseApp app,
    FirebaseOptions firebaseOptions,
  ) childBuilder, {
  required String appName,
  required FirebaseOptions firebaseOptions,
}) withFirebase = andFirebase;

Future<ProviderScope> Function() andFirebase(
  Future<dynamic> Function(
    FirebaseApp app,
    FirebaseOptions firebaseOptions,
  ) childBuilder, {
  required String appName,
  required FirebaseOptions firebaseOptions,
}) {
  final log = logger('Firebase Setup', level: Level.debug);
  return () async {
    log.d('Firebase Initialising');
    WidgetsFlutterBinding.ensureInitialized();

    log.d('Firebase.initializeApp: name($appName)');
    final app = await Firebase.initializeApp(
      name: appName,
      options: firebaseOptions,
    );

    log.d('FirebaseAuth.instanceFor: name($appName)');
    final auth = FirebaseAuth.instanceFor(app: app);
    log.d('FirebaseDatabase.instanceFor: name($appName)');
    final database = FirebaseDatabase.instanceFor(app: app);

    log.d('Firebase Building Child');
    final widget = await child2widget(childBuilder(app, firebaseOptions));
    log.d('Firebase Returning Scope');
    return ProviderScope(
      overrides: [
        FirebaseProviders.appName.overrideWithValue(appName),
        FirebaseProviders.firebaseOptions.overrideWithValue(firebaseOptions),
        FirebaseProviders.auth.overrideWithValue(auth),
        FirebaseProviders.database.overrideWithValue(database),
        if (widget is ProviderScope) ...widget.overrides,
      ],
      observers: [
        if (widget is ProviderScope) ...widget.observers ?? [],
      ],
      child: widget is ProviderScope ? widget.child : widget,
    );
  };
}

Future<Widget> child2widget(dynamic child) async {
  return child is Future<Widget> ? await child : child as Widget;
}
