import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/auth_gateway/message_publisher.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class EmailLoginForm extends ConsumerStatefulWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final void Function(String message)? onSuccess;
  final void Function(String error)? onError;

  const EmailLoginForm({
    super.key,
    this.emailController,
    this.passwordController,
    this.onSuccess,
    this.onError,
  });

  @override
  ConsumerState<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends ConsumerState<EmailLoginForm> {
  static final log = logger(EmailLoginForm);

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool loading = false;

  Future<void> _login() async {
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
      final userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        final user = userCredential.user!;
        messagePublisher.publishMessage(
          'Successfully logged in with Email/Password: ${user.displayName ?? user.email ?? user.uid}',
        );
      } else {
        messagePublisher.publishError('Logging in with Email/Password did not return a user');
      }
    } on FirebaseAuthException catch (e) {
      messagePublisher.publishError(e.message ?? 'Unknown error');
    } catch (error) {
      messagePublisher.publishError(error.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = widget.emailController ?? TextEditingController();
    passwordController = widget.passwordController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.emailController == null) {
      emailController.dispose();
    }
    if (widget.passwordController == null) {
      passwordController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 12),
        if (loading)
          const SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(),
          )
        else
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Login with Email'),
              onPressed: _login,
            ),
          ),
      ],
    );
  }
}
