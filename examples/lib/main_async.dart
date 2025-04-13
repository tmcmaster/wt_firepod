import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/async/async_example_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Scaffold(
          body: Center(
            child: Column(
              children: [
                Text(':-)'),
                SizedBox(
                  height: 400,
                  child: AsyncExamplePage(),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
