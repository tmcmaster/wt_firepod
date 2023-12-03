import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_firepod/src/login_screen_support/builders/action_builders.dart';
import 'package:wt_firepod/src/login_screen_support/builders/component_builders.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class SignInPage extends ConsumerWidget {
  static final log = logger(SignInPage);

  const SignInPage({
    super.key,
    required this.emailVerificationRequired,
  });

  final bool emailVerificationRequired;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(FirebaseProviders.auth);

    final appDetails = ref.read(AppScaffoldProviders.appDetails);
    final iconPath = appDetails.iconPath;
    final welcomeString = _createWelcomeString(appDetails);

    return SignInScreen(
      auth: auth,
      actions: [
        ForgotPasswordAction((context, email) {
          Navigator.pushNamed(
            context,
            '/forgot-password',
            arguments: {'email': email},
          );
        }),
        VerifyPhoneAction((context, _) {
          Navigator.pushNamed(context, '/phone');
        }),
        AuthStateChangeAction<SignedIn>(
          (context, state) async {
            if (state.user == null) {
              ref.read(AppScaffoldAuthenticationStore.user.notifier).signOut();
            } else {
              if (!state.user!.emailVerified) {
                log.d('Sending verification email.');
                auth.currentUser!.sendEmailVerification();
                Navigator.pushNamed(context, '/verify-email');
              } else {
                ref.read(AppScaffoldRouter.provider).go('/');
              }
            }
          },
        ),
        ActionBuilders.createAuthStateChangeAction(),
        EmailLinkSignInAction((context) {
          Navigator.pushReplacementNamed(context, '/email-link-sign-in');
        }),
      ],
      styles: const {
        EmailFormStyle(
          signInButtonVariant: ButtonVariant.filled,
        ),
      },
      headerBuilder: ComponentBuilders.headerImage(iconPath),
      sideBuilder: ComponentBuilders.sideImage(iconPath),
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            action == AuthAction.signIn
                ? '$welcomeString Please sign in to continue.'
                : '$welcomeString Please create an account to continue',
          ),
        );
      },
      footerBuilder: (context, action) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }

  String _createWelcomeString(AppDetails appDetails) {
    final name =
        appDetails.title.isNotEmpty ? appDetails.title : appDetails.subTitle;
    return name.isEmpty ? 'Welcome!' : 'Welcome to $name!';
  }
}
