import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';

class GoogleLoginButton extends ConsumerStatefulWidget {
  final void Function(User user)? onSuccess;
  final void Function(String error)? onError;

  const GoogleLoginButton({super.key, this.onSuccess, this.onError});

  @override
  ConsumerState<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends ConsumerState<GoogleLoginButton> {
  bool loading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => loading = true);

    try {
      final googleUser = await GoogleSignIn().signIn();
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
      if (widget.onSuccess != null) widget.onSuccess!(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (widget.onError != null) widget.onError!(e.message ?? "Unknown error");
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
