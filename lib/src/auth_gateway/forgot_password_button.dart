import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';

class ForgotPasswordButton extends ConsumerStatefulWidget {
  final TextEditingController emailController;

  const ForgotPasswordButton({
    super.key,
    required this.emailController,
  });

  @override
  ConsumerState<ForgotPasswordButton> createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends ConsumerState<ForgotPasswordButton> {
  bool _loading = false;

  Future<void> _sendResetEmail(BuildContext context) async {
    final email = widget.emailController.text.trim();
    final messenger = ScaffoldMessenger.of(context);

    if (email.isEmpty) {
      messenger.showSnackBar(const SnackBar(content: Text('Please enter your email first.')));
      return;
    }

    setState(() => _loading = true);

    try {
      final auth = ref.read(FirebaseProviders.auth);
      await auth.sendPasswordResetEmail(email: email);
      messenger.showSnackBar(const SnackBar(content: Text('Password reset email sent.')));
    } on FirebaseAuthException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message ?? 'Error sending reset email.')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _loading ? null : () => _sendResetEmail(context),
      child: _loading
          ? const SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Forgot password?'),
    );
  }
}
