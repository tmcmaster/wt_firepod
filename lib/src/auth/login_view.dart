import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/auth/auth.dart';
import 'package:wt_firepod/src/auth/email_sign_in_form.dart';
import 'package:wt_firepod/src/auth/google_sign_in_form.dart';
import 'package:wt_logging/wt_logging.dart';

class LoginView extends ConsumerWidget {
  static final log = logger(LoginView);

  static const routeName = '/login';

  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  LoginView({
    required this.firebaseLogin,
    this.landingRoute = '/',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),
      body: Center(
          child: kIsWeb || Platform.isMacOS
              ? EmailSignInForm(
                  firebaseLogin: firebaseLogin,
                  landingRoute: landingRoute,
                )
              : GoogleSignInForm(
                  firebaseLogin: firebaseLogin,
                  landingRoute: landingRoute,
                )),
    );
  }
}
