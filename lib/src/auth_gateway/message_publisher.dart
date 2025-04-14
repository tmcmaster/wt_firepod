import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MessagePublisher {
  final ScaffoldMessengerState messenger;
  final Logger log;
  final void Function(String message)? onSuccess;
  final void Function(String error)? onError;

  MessagePublisher({
    required this.messenger,
    required this.log,
    this.onSuccess,
    this.onError,
  });

  void publishError(String errorMessage) {
    log.e(errorMessage);
    onError?.call(errorMessage);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void publishMessage(String successMessage) {
    log.d(successMessage);
    onSuccess?.call(successMessage);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          successMessage,
          style: const TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}
