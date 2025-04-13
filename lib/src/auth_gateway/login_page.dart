import 'package:flutter/material.dart';
import 'package:wt_firepod/src/auth_gateway/email_login_form.dart';
import 'package:wt_firepod/src/auth_gateway/google_login_button.dart';
import 'package:wt_logging/wt_logging.dart';

class LoginPage extends StatelessWidget {
  static final log = logger(LoginPage, level: Level.debug);

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              EmailLoginForm(
                onSuccess: (user) => log.d('Logged in: ${user.email}'),
                onError: (err) => log.d('Email login failed: $err'),
              ),
              const SizedBox(height: 16),
              GoogleLoginButton(
                onSuccess: (user) => log.d('Google login success: ${user.displayName}'),
                onError: (err) => log.d('Google login failed: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
