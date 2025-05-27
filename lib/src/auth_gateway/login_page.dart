import 'package:flutter/material.dart';
import 'package:wt_firepod/src/auth_gateway/email_login_form.dart';
import 'package:wt_firepod/src/auth_gateway/google_login_button.dart';
import 'package:wt_logging/wt_logging.dart';

class LoginPage extends StatelessWidget {
  static final log = logger(LoginPage);

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
                onSuccess: (message) => log.d('Logged in: $message'),
                onError: (error) => log.d('Email login failed: $error'),
              ),
              const SizedBox(height: 16),
              GoogleLoginButton(
                onSuccess: (message) => log.d('Google login success: $message'),
                onError: (error) => log.d('Google login failed: $error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
