import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/object/example_firepod_nested_objects.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/object/example_firepod_object_as_map.dart';

class FirepodExamplesPage extends ConsumerWidget {
  const FirepodExamplesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: const [
          ExampleFirepodSite(),
          ExampleFirepodListString(),
          ExampleFirepodListInt(),
          ExampleFirepodListDouble(),
          ExampleFirepodListBool(),
          ExampleFirepodListObject(),
          ExampleUserSiteList(),
          ExampleFirepodScalar(),
          ExampleFirepodMapBoolean(),
          ExampleFirepodMapDouble(),
          ExampleFirepodMapInt(),
          ExampleFirepodMapString(),
          ExampleFirepodObject(),
          ExampleFirepodMapObject(),
          ExampleFirepodNestedObjects(),
          ExampleFirepodObjectAsMap(),
        ],
      ),
    );
  }
}
