import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class AsyncExamplePage extends ConsumerWidget {
  static final log = logger(AsyncExamplePage, level: Level.debug);

  const AsyncExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Example Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Counter(ref),
              const SizedBox(
                height: 200,
              ),
              FutureBuilder(
                future: ref.watch(futureCombined.future),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('ERROR: ${snapshot.error}');
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Text('NONE');
                      case ConnectionState.waiting:
                        return const Text('WAITING');
                      case ConnectionState.active:
                        return Text('${snapshot.data}');
                      case ConnectionState.done:
                        return Text('${snapshot.data}');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static final futureCombined = FutureProvider<String>((ref) async {
    log.d('Future Combined.');
    return WaitFor.threeFutures(
      ref.read(futureOne.future),
      ref.read(futureTwo.future),
      ref.read(futureThree.future),
      (v1, v2, v3) => '$v1 : $v2 : $v3',
    );
  });

  static final futureOne = FutureProvider<String>((ref) async {
    log.d('Future One started.');
    await Future.delayed(const Duration(seconds: 10));
    log.d('Future One completed.');
    return 'Future One';
  });

  static final futureTwo = FutureProvider<String>((ref) async {
    log.d('Future Two started.');
    await Future.delayed(const Duration(seconds: 14));
    log.d('Future Two completed.');
    return 'Future Two';
  });

  static final futureThree = FutureProvider<String>((ref) async {
    log.d('Future Three started.');
    await Future.delayed(const Duration(seconds: 8));
    log.d('Future Three completed.');
    return 'Future Three';
  });

  static final counterProvider = StreamProvider<int>((ref) => counting());

  static Stream<int> counting() async* {
    for (int i = 1; i <= 30; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }
}

class Counter extends ConsumerWidget {
  final WidgetRef ref;

  const Counter(this.ref, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterAsync = ref.watch(AsyncExamplePage.counterProvider);
    return counterAsync.when(
      data: (int value) => Text(
        'Current Value: $value',
        style: const TextStyle(fontSize: 24),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
