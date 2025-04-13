import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class SignUpButton extends ConsumerStatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(User user)? onSuccess;
  final void Function(String error)? onError;

  const SignUpButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.onSuccess,
    this.onError,
  });

  @override
  ConsumerState<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends ConsumerState<SignUpButton> {
  static final log = logger(SignUpButton, level: Level.debug);

  bool loading = false;

  Future<void> _signUp() async {
    setState(() {
      loading = true;
    });

    final messenger = ScaffoldMessenger.of(context);

    try {
      final auth = ref.read(FirebaseProviders.auth);
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: widget.emailController.text.trim(),
        password: widget.passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        final user = userCredential.user!;
        _handleSuccess(
          messenger,
          user: userCredential.user!,
          successMessage: 'Successfully signed up: ${user.displayName ?? user.email ?? user.uid}',
        );
      } else {
        _handleError(messenger, errorMessage: 'Signup did not return a user');
      }
    } on FirebaseAuthException catch (e) {
      _handleError(
        messenger,
        errorMessage: 'There was an error while trying to signup: ${e.message ?? 'Unknown error'}',
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (loading)
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(),
          )
        else
          TextButton(
            onPressed: _signUp,
            child: const Text('Create Account'),
          ),
      ],
    );
  }

  void _handleError(
    ScaffoldMessengerState messenger, {
    required String errorMessage,
  }) {
    log.e(errorMessage);
    messenger.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
    widget.onError?.call(errorMessage);
  }

  void _handleSuccess(
    ScaffoldMessengerState messenger, {
    required User user,
    required String successMessage,
  }) {
    widget.onSuccess?.call(user);
    messenger.showSnackBar(
      SnackBar(
        content: Text(successMessage),
      ),
    );
  }
}
