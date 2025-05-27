import 'package:flutter/material.dart';
import 'package:wt_firepod/src/auth_gateway/email_login_form.dart';
import 'package:wt_firepod/src/auth_gateway/forgot_password_button.dart';
import 'package:wt_firepod/src/auth_gateway/google_login_button.dart';
import 'package:wt_firepod/src/auth_gateway/sign_up_button.dart';

class FirepodLoginScreen extends StatefulWidget {
  const FirepodLoginScreen({super.key});

  @override
  State<FirepodLoginScreen> createState() => _FirepodLoginScreenState();
}

class _FirepodLoginScreenState extends State<FirepodLoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmailLoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ForgotPasswordButton(
                      emailController: emailController,
                    ),
                    SignUpButton(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const GoogleLoginButton(),
                const SizedBox(height: 16),
                if (error != null)
                  Text(
                    error!,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
