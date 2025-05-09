import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/auth/flutterfire_auth.dart';
import 'package:wt_firepod/src/auth/user_auth.dart';
import 'package:wt_firepod/src/auth/user_auth_result.dart';
import 'package:wt_logging/wt_logging.dart';

class GoogleSignInForm extends ConsumerWidget {
  static final log = logger(GoogleSignInForm);

  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  const GoogleSignInForm({
    super.key,
    required this.firebaseLogin,
    required this.landingRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLog = ref.read(UserLog.provider);

    return ElevatedButton(
      child: const Text('Google Sign In'),
      onPressed: () {
        log.d('Logging in with google');
        firebaseLogin.googleSignIn().then(
          (UserAuthResult auth) {
            log.d('Login completed : ${auth.success} : ${auth.user.name}');
            userLog.info('Login completed : ${auth.success} : ${auth.user.name}');

            if (!auth.success) {
              log.w('There was an authentication error: ${auth.error}');
              userLog.warn('There was an authentication error: ${auth.error}');
            }

            if (auth.user != UserAuth.none) {
              log.i('Authentication was successful.');
              userLog.info('Authentication was successful.');
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pushReplacementNamed(landingRoute);
              });
            } else {
              log.d('Authentication was not successful.');
              userLog.warn('Authentication was not successful.');
            }
          },
          onError: (error) {
            log.e('Could not login user: $error');
            userLog.error('Could not login user: $error');
          },
        );
      },
    );
  }
}
