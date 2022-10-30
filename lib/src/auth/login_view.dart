import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/logging.dart';
import 'auth.dart';
import 'email_sign_in_form.dart';
import 'google_sign_in_form.dart';

class LoginPage extends ConsumerWidget {
  static final log = logger(LoginPage);

  static const routeName = '/login';

  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  LoginPage({
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
