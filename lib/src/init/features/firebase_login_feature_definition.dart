import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication.dart';
import 'package:wt_app_scaffold/app_platform/auth/scaffold_app_user.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_override_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_firepod/src/login_screen_support/auth/firebase_authentication_notifier.dart';
import 'package:wt_firepod/src/login_screen_support/config.dart';
import 'package:wt_firepod/src/login_screen_support/pages/email_link_sign_in_page.dart';
import 'package:wt_firepod/src/login_screen_support/pages/email_verification_page.dart';
import 'package:wt_firepod/src/login_screen_support/pages/forgot_password_page.dart';
import 'package:wt_firepod/src/login_screen_support/pages/phone_input_page.dart';
import 'package:wt_firepod/src/login_screen_support/pages/profile_page.dart';
import 'package:wt_firepod/src/login_screen_support/pages/sign_in_page.dart';
import 'package:wt_firepod/src/login_screen_support/pages/sms_code_input_page.dart';
import 'package:wt_firepod/wt_firepod.dart' hide EmailAuthProvider;
import 'package:wt_logging/wt_logging.dart';

class FirebaseLoginFeatureDefinition extends AppScaffoldFeatureDefinition {
  static final log = logger(FirebaseLoginFeatureDefinition, level: Level.debug);
  FirebaseLoginFeatureDefinition(
    AppScaffoldFeatureDefinition? childFeature, {
    required bool googleEnabled,
    required bool emailEnabled,
    required bool appleEnabled,
    required bool emailLinkEnabled,
  }) : super(
          contextBuilder: (contextMap) async {
            if (contextMap.containsKey(FirebaseProviders.firebaseOptions) &&
                contextMap.containsKey(FirebaseProviders.app)) {
              final firebaseOptions =
                  contextMap[FirebaseProviders.firebaseOptions]!.value
                      as FirebaseOptions;
              final firebaseApp =
                  contextMap[FirebaseProviders.app]!.value as FirebaseApp;

              final googleClientId = kIsWeb
                  ? firebaseOptions.appId
                  : Platform.isAndroid
                      ? firebaseOptions.appId
                      : firebaseOptions.iosClientId;

              if (googleClientId == null) {
                throw Exception('GOOGLE_CLIENT_ID has not been set.');
              }
              FirebaseUIAuth.configureProviders(
                [
                  if (emailEnabled) EmailAuthProvider(),
                  if (emailLinkEnabled)
                    EmailLinkAuthProvider(
                      actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
                    ),
                  if (googleEnabled && !kIsWeb && Platform.isAndroid)
                    GoogleProvider(clientId: googleClientId),
                  if (appleEnabled) AppleProvider(),
                ],
                app: firebaseApp,
              );
              final newContextMap = {
                ...contextMap,
                GoRouterStore.initialRoute: _overrideLoginInitialRoute(),
                GoRouterStore.routes: _overrideLoginScreenRoutes(),
                AppScaffoldAuthenticationStore.user:
                    _overrideAuthenticationNotifier(),
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
            return childFeature == null
                ? Container()
                : childFeature.widgetBuilder(context, ref);
          },
        );

  static AppScaffoldOverrideDefinition _overrideAuthenticationNotifier() {
    return AppScaffoldOverrideDefinition(
      value: ScaffoldAppUser.empty(),
      override: AppScaffoldAuthenticationStore.user.overrideWith(
        (ref) => FirebaseAuthenticationNotifier(ref),
      ),
    );
  }

  static AppScaffoldOverrideDefinition _overrideLoginInitialRoute() {
    return AppScaffoldOverrideDefinition(
      value: '/sign-in',
      override: GoRouterStore.initialRoute.overrideWith(
        (ref) => '/sign-in',
      ),
    );
  }

  static AppScaffoldOverrideDefinition _overrideLoginScreenRoutes() {
    log.d('Requesting to override the GoRouter routes,');
    return AppScaffoldOverrideDefinition(
      value: null,
      override: GoRouterStore.routes.overrideWith(
        (ref) {
          log.d('Overriding the GoRouter routes,');
          return [
            GoRoute(
              path: '/sign-in',
              builder: (_, __) => const SignInPage(
                emailVerificationRequired: false,
              ),
            ),
            GoRoute(
              path: '/verify-email',
              builder: (_, __) => const EmailVerificationPage(),
            ),
            GoRoute(
              path: '/phone',
              builder: (_, __) => const PhoneInputPage(),
            ),
            GoRoute(
              path: '/sms',
              builder: (_, __) => const SMSCodeInputPage(),
            ),
            GoRoute(
              path: '/forgot-password',
              builder: (_, __) => const ForgotPasswordPage(),
            ),
            GoRoute(
              path: '/email-link-sign-in',
              builder: (_, __) => const EmailLinkSignInPage(),
            ),
            GoRoute(
              path: '/profile',
              builder: (_, __) => const ProfilePage(),
            ),
            GoRoute(
              path: '/',
              builder: (_, __) => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Colors.cyan),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
