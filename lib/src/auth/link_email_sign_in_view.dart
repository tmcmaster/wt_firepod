import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/auth/auth.dart';
import 'package:wt_firepod/src/auth/link_email_sign_in_form.dart';
import 'package:wt_logging/wt_logging.dart';

class LinkEmailSignInView extends ConsumerWidget {
  static final log = logger(LinkEmailSignInView);

  static const routeName = '/link_email';

  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  const LinkEmailSignInView({
    required this.firebaseLogin,
    this.landingRoute = '/',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Email Sign In'),
        centerTitle: true,
      ),
      body: Center(
        child: LinkEmailSignInForm(
          landingRoute: landingRoute,
          firebaseLogin: firebaseLogin,
        ),
      ),
    );
  }
}
