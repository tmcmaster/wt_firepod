import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  final VoidCallback? onSignedOut;

  const SignOutButton({super.key, this.onSignedOut});

  Future<void> _signOut(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    await FirebaseAuth.instance.signOut();

    onSignedOut?.call();

    messenger.showSnackBar(
      const SnackBar(content: Text('Signed out')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Sign out',
      onPressed: () => _signOut(context),
    );
  }
}
