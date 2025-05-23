import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wt_firepod_examples/config/app_secrets.dart';
import 'package:wt_firepod_examples/secrets/firebase_options.dart';
import 'package:wt_logging/wt_logging.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    name: 'firepodExampleApp',
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((app) {
    // loginWithGoogle(app);
    loginWithGoogle(app);
  });
}

// ignore: unreachable_from_main
void loginWithGoogle(FirebaseApp app) {
  final log = logger('Testing Email Login', level: Level.debug);

  GoogleSignIn(
    clientId: DefaultFirebaseOptions.macos.iosClientId,
  ).signIn().then((GoogleSignInAccount? account) {
    if (account != null) {
      account.authentication.then((authentication) {
        final credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken,
        );
        FirebaseAuth.instanceFor(app: app).signInWithCredential(credential).then((user) {
          log.d('Login Value: $user');
          runApp(MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('Logged In: $user'),
                ),
              )));
        }).catchError((error) {
          log.d('Login Error: $error');
        });
      }).catchError((error) {
        log.d('Login Error: $error');
      });
    }
  }).catchError((error) {
    log.d('Login Error: $error');
  });
}

// ignore: unreachable_from_main
void loginWithEmail(FirebaseApp app) {
  final log = logger('Testing Email Login', level: Level.debug);
  FirebaseAuth.instanceFor(app: app)
      .signInWithEmailAndPassword(
    email: AppSecrets.userName,
    password: AppSecrets.password,
  )
      .then((value) {
    log.d('Login Value: $value');
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text('Logged In: $value'),
          ),
        )));
  }).catchError((error) {
    log.d('Login Error: $error');
  });
}
