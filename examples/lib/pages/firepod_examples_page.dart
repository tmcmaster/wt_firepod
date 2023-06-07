import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_map_double.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_map_int.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_object.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_site.dart';

class FirepodExamplesPage extends ConsumerWidget {
  const FirepodExamplesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: const [
          ExampleFirepodSite(),
          ExampleFirepodObject(),
          ExampleFirepodSite(),
          ExampleFirepodMapInt(),
          ExampleFirepodSite(),
          ExampleFirepodMapDouble(),
        ],
      ),
    );
  }
}
