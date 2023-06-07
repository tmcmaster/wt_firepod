import 'package:flutter/material.dart';

class ValueAndAction extends StatelessWidget {
  final String title;
  final Object? value;
  final VoidCallback action;
  final String buttonText;

  const ValueAndAction({
    super.key,
    required this.title,
    required this.value,
    required this.action,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$value',
            softWrap: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: action,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
