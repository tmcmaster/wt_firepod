import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod_examples/pages/async_example_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
      child: MaterialApp(
    debugShowCheckedModeBanner: true,
    home: Scaffold(
      body: Center(
        child: Column(
          children: const [
            Text(':-)'),
            SizedBox(
              height: 400,
              child: AsyncExamplePage(),
            ),
          ],
        ),
      ),
    ),
  )));
}
