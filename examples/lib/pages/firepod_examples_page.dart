import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_map_boolean.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_map_double.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_map_int.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_map_object.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_map_string.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_object.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod_site.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_user_site_list.dart';

class FirepodExamplesPage extends ConsumerWidget {
  const FirepodExamplesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: const [
          ExampleFirepodSite(),
          ExampleUserSiteList(),
          ExampleFirepodMapBoolean(),
          ExampleFirepodMapDouble(),
          ExampleFirepodMapInt(),
          ExampleFirepodMapString(),
          ExampleFirepodObject(),
          ExampleFirepodMapObject(),
        ],
      ),
    );
  }
}
