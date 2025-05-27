import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/auth_gateway/message_publisher.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class SignOutButton extends ConsumerWidget {
  static final log = logger(SignOutButton);

  final void Function(String message)? onSuccess;
  final void Function(String error)? onError;

  const SignOutButton({
    super.key,
    this.onSuccess,
    this.onError,
  });

  Future<void> _signOut(MessagePublisher messagePublisher, FirebaseAuth auth) async {
    try {
      await auth.signOut();
      messagePublisher.publishMessage('Signed out successfully');
    } catch (error) {
      messagePublisher.publishMessage('There was an error while signing out: $error');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagePublisher = MessagePublisher(
      messenger: ScaffoldMessenger.of(context),
      log: log,
      onSuccess: onSuccess,
      onError: onError,
    );
    final auth = ref.read(FirebaseProviders.auth);
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Sign out',
      onPressed: () => _signOut(messagePublisher, auth),
    );
  }
}
