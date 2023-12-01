// import 'dart:async';
// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
// import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:wt_app_scaffold/app_platform/models/feature_definition.dart';
// import 'package:wt_app_scaffold/app_platform/models/provider_override_definition.dart';
// import 'package:wt_app_scaffold/app_platform/providers/app_platform_providers.dart';
// import 'package:wt_app_scaffold/providers/auth_providers.dart';
// import 'package:wt_firepod/src/login_screen_support/config.dart';
// import 'package:wt_firepod/src/login_screen_support/pages/email_link_sign_in_page.dart';
// import 'package:wt_firepod/src/login_screen_support/pages/email_verification_page.dart';
// import 'package:wt_firepod/src/login_screen_support/pages/forgot_password_page.dart';
// import 'package:wt_firepod/src/login_screen_support/pages/phone_input_page.dart';
// import 'package:wt_firepod/src/login_screen_support/pages/profile_page.dart';
// import 'package:wt_firepod/src/login_screen_support/pages/sign_in_page.dart';
// import 'package:wt_firepod/src/login_screen_support/pages/sms_code_input_page.dart';
// import 'package:wt_firepod/wt_firepod.dart'
//     hide EmailAuthProvider, PhoneAuthProvider;
// import 'package:wt_logging/wt_logging.dart';
//
// class LoginScreenSupport extends ConsumerStatefulWidget {
//   static final log = logger(LoginScreenSupport);
//
//   final Widget child;
//   final LoginSupport? loginSupport;
//   final bool emailVerificationRequired;
//
//   const LoginScreenSupport({
//     super.key,
//     required this.child,
//     this.loginSupport,
//     this.emailVerificationRequired = false,
//   });
//
//   static Future<Map<ProviderListenable, ProviderOverrideDefinition>> init({
//     required FirebaseOptions firebaseOptions,
//     required FirebaseApp firebaseApp,
//     required LoginSupport? loginSupport,
//     required Map<ProviderListenable, ProviderOverrideDefinition> contextMap,
//     FeatureDefinition? child,
//   }) async {
//     if (loginSupport != null) {
//       final googleClientId = kIsWeb
//           ? firebaseOptions.appId
//           : Platform.isAndroid
//               ? firebaseOptions.appId
//               : firebaseOptions.iosClientId;
//
//       if (googleClientId == null) {
//         throw Exception('GOOGLE_CLIENT_ID has not been set.');
//       }
//       FirebaseUIAuth.configureProviders(
//         [
//           if (loginSupport.emailEnabled) EmailAuthProvider(),
//           if (loginSupport.emailLinkEnabled)
//             EmailLinkAuthProvider(
//               actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
//             ),
//           if (loginSupport.phoneEnabled) PhoneAuthProvider(),
//           if (loginSupport.googleEnabled && !kIsWeb && Platform.isAndroid)
//             GoogleProvider(clientId: googleClientId),
//           if (loginSupport.appleEnabled) AppleProvider(),
//         ],
//         app: firebaseApp,
//       );
//     }
//     final newContextMap = {
//       ...contextMap,
//       AuthProviders.loginRoutes: _overrideLoginScreenRoutes(),
//     };
//     if (child != null) {
//       return child.initialiser(newContextMap);
//     } else {
//       return newContextMap;
//     }
//   }
//
//   static ProviderOverrideDefinition _overrideLoginScreenRoutes() {
//     return ProviderOverrideDefinition(
//       value: null,
//       override: AuthProviders.loginRoutes.overrideWith(
//         (ref) => {
//           '/sign-in': (context) => const SignInPage(
//                 emailVerificationRequired: false,
//               ),
//           '/verify-email': (context) => const EmailVerificationPage(),
//           '/phone': (context) => const PhoneInputPage(),
//           '/sms': (context) => const SMSCodeInputPage(),
//           '/forgot-password': (context) => const ForgotPasswordPage(),
//           '/email-link-sign-in': (context) => const EmailLinkSignInPage(),
//           '/profile': (context) => const ProfilePage(),
//         },
//       ),
//     );
//   }
//
//   @override
//   ConsumerState<LoginScreenSupport> createState() => _LoginScreenSupportState();
// }
//
// class _LoginScreenSupportState extends ConsumerState<LoginScreenSupport> {
//   static final log = logger(LoginScreenSupport, level: Level.debug);
//
//   late StreamSubscription<User?> subscription;
//   String initialRoute = '/';
//
//   @override
//   void initState() {
//     subscription =
//         ref.read(FirebaseProviders.auth).authStateChanges().listen((user) {
//       _routeToInitialPage(user);
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: widget.child);
//
//     // final themeMode = ref.watch(ApplicationSettings.theme.value);
//     // final debugMode = ref.watch(ApplicationSettings.debugMode.value);
//     // final auth = ref.watch(FirebaseProviders.auth);
//     //
//     // log.d(
//     //   'Rebuilding app: '
//     //   'user(${auth.currentUser?.email}) : '
//     //   'InitialRoute($initialRoute)',
//     // );
//     //
//     // final buttonStyle = ButtonStyle(
//     //   padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
//     //   shape: MaterialStateProperty.all(
//     //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     //   ),
//     // );
//     //
//     // return MaterialApp(
//     //   theme: SharedAppConfig.styles.theme.copyWith(
//     //     brightness: Brightness.light,
//     //     visualDensity: VisualDensity.standard,
//     //     inputDecorationTheme: const InputDecorationTheme(
//     //       border: OutlineInputBorder(),
//     //     ),
//     //     elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
//     //     textButtonTheme: TextButtonThemeData(style: buttonStyle),
//     //     outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
//     //   ),
//     //   darkTheme: ThemeData.dark(),
//     //   themeMode: themeMode,
//     //   // navigatorKey: LoginScreenSupport.navigatorKey,
//     //   // scaffoldMessengerKey: ref.read(UserLog.snackBarKey),
//     //   // navigatorKey: ref.read(AppPlatformProviders.navigatorKey),
//     //   initialRoute: '/',
//     //   routes: {
//     //     '/': (_) => const PlaceholderPage(title: 'Splash Screen'),
//     //     '/sign-in': (context) => SignInPage(
//     //           emailVerificationRequired: widget.emailVerificationRequired,
//     //         ),
//     //     '/verify-email': (context) => const EmailVerificationPage(),
//     //     '/phone': (context) => const PhoneInputPage(),
//     //     '/sms': (context) => const SMSCodeInputPage(),
//     //     '/forgot-password': (context) => const ForgotPasswordPage(),
//     //     '/email-link-sign-in': (context) => const EmailLinkSignInPage(),
//     //     '/profile': (context) => const ProfilePage(),
//     //     '/app': (context) => Scaffold(body: widget.child),
//     //   },
//     //   title: 'Firebase UI demo',
//     //   debugShowCheckedModeBanner: debugMode,
//     //   locale: const Locale('en', ''),
//     //   localizationsDelegates: [
//     //     FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
//     //     ...FlutterLocalization.instance.localizationsDelegates,
//     //     FirebaseUILocalizations.delegate,
//     //     FormBuilderLocalizations.delegate,
//     //   ],
//     // );
//   }
//
//   void _routeToInitialPage(User? user) {
//     log.d('User Authentication changed: ${user?.email}');
//     setState(() {
//       initialRoute = user == null ? '/sign-in' : '/app';
//
//       log.d('Routing new user to: $initialRoute');
//       final navigationKey = ref.read(UserLog.navigatorKey);
//       navigationKey.currentState?.popUntil(
//         (route) => route.settings.name == '/',
//       );
//       navigationKey.currentState?.pushNamed(initialRoute);
//     });
//   }
// }
