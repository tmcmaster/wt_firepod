import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/auth_gateway/message_publisher.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class SignUpButton extends ConsumerStatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(String message)? onSuccess;
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
  static final log = logger(SignUpButton);

  bool loading = false;

  Future<void> _signUp() async {
    setState(() {
      loading = true;
    });

    final messagePublisher = MessagePublisher(
      messenger: ScaffoldMessenger.of(context),
      log: log,
      onSuccess: widget.onSuccess,
      onError: widget.onError,
    );

    try {
      final auth = ref.read(FirebaseProviders.auth);
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: widget.emailController.text.trim(),
        password: widget.passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        final user = userCredential.user!;
        messagePublisher.publishMessage(
          'Successfully signed up: ${user.displayName ?? user.email ?? user.uid}',
        );
      } else {
        messagePublisher.publishError('Signup did not return a user');
      }
    } on FirebaseAuthException catch (e) {
      messagePublisher.publishError(
        'There was an error while trying to signup: ${e.message ?? 'Unknown error'}',
      );
    } catch (error) {
      messagePublisher.publishError(error.toString());
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
}
