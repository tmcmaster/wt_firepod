import 'package:flutter/material.dart';

class ValueAndAction extends StatelessWidget {
  final String title;
  final Object? value;
  final Map<String, VoidCallback> actionMap;
  const ValueAndAction({
    super.key,
    required this.title,
    required this.value,
    required this.actionMap,
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
          Wrap(
            children: actionMap.entries
                .map((e) => [
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: e.value,
                        child: Text(e.key),
                      )
                    ])
                .expand((element) => element)
                .toList()
                .sublist(1),
          ),
        ],
      ),
    );
  }
}
