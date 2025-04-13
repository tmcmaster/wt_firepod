import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_firepod/wt_firepod.dart' hide EmailAuthProvider;
import 'package:wt_logging/wt_logging.dart';

class AuthGatewayFeatureDefinition extends AppScaffoldFeatureDefinition {
  static final log = logger(AuthGatewayFeatureDefinition, level: Level.debug);
  AuthGatewayFeatureDefinition(
    AppScaffoldFeatureDefinition? childFeature, {
    required bool googleEnabled,
    required bool emailEnabled,
  }) : super(
          contextBuilder: (contextMap) async {
            if (contextMap.containsKey(FirebaseProviders.firebaseOptions) &&
                contextMap.containsKey(FirebaseProviders.app)) {
              final firebaseOptions = contextMap[FirebaseProviders.firebaseOptions]!.value as FirebaseOptions;
              final firebaseApp = contextMap[FirebaseProviders.app]!.value as FirebaseApp;

              final googleClientId = kIsWeb
                  ? firebaseOptions.appId
                  : Platform.isAndroid
                      ? firebaseOptions.appId
                      : firebaseOptions.iosClientId;

              if (googleClientId == null) {
                throw Exception('GOOGLE_CLIENT_ID has not been set.');
              }

              final newContextMap = {
                ...contextMap,
              };
              if (childFeature != null) {
                return childFeature.contextBuilder(newContextMap);
              } else {
                return newContextMap;
              }
            }
            throw Exception('Login does not have the providers it requires: '
                'FirebaseOptions(${contextMap.containsKey(FirebaseProviders.firebaseOptions)}), '
                'FirebaseApp(${contextMap.containsKey(FirebaseProviders.app)})');
          },
          widgetBuilder: (context, ref) {
            return AuthGate(
              child: childFeature == null
                  ? const Scaffold(
                      body: Center(
                        child: Text('App should go here'),
                      ),
                    )
                  : childFeature.widgetBuilder(context, ref),
            );
          },
        );
}
