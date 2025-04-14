import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wt_firepod/src/auth_gateway/message_publisher.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class GoogleLoginButton extends ConsumerStatefulWidget {
  final void Function(String message)? onSuccess;
  final void Function(String error)? onError;

  const GoogleLoginButton({super.key, this.onSuccess, this.onError});

  @override
  ConsumerState<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends ConsumerState<GoogleLoginButton> {
  static final log = logger(GoogleLoginButton, level: Level.debug);

  bool loading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => loading = true);

    final messagePublisher = MessagePublisher(
      messenger: ScaffoldMessenger.of(context),
      log: log,
      onSuccess: widget.onSuccess,
      onError: widget.onError,
    );

    final clientId = ref.read(FirebaseProviders.clientId);
    log.d('Web($kIsWeb): $clientId');

    try {
      final googleUser = await GoogleSignIn(
        clientId: clientId,
      ).signIn();
      if (googleUser == null) {
        setState(() => loading = false);
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final auth = ref.read(FirebaseProviders.auth);

      final userCredential = await auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        final user = userCredential.user!;
        messagePublisher.publishMessage(
          'Successfully logged in with Google: ${user.displayName ?? user.email ?? user.uid}',
        );
      } else {
        messagePublisher.publishError('Logging in with Google did not return a user');
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
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(FontAwesomeIcons.google),
              label: const Text('Sign in with Google'),
              onPressed: _signInWithGoogle,
            ),
          );
  }
}
