import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/auth/login_example_page.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/example_firepod.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/object/example_firepod_nested_objects.dart';
import 'package:wt_firepod_examples/pages/firepod_examples/examples/object/example_firepod_object_as_map.dart';

final examples = <String, List<Widget>>{
  'User': const [
    LoginExamplePage(),
  ],
  'Site': const [
    ExampleFirepodSite(),
    ExampleUserSiteList(),
  ],
  'List': const [
    ExampleFirepodListString(),
    ExampleFirepodListInt(),
    ExampleFirepodListDouble(),
    ExampleFirepodListBool(),
    ExampleFirepodListObject(),
  ],
  'Scalar': const [
    ExampleFirepodScalar(),
  ],
  'Map': const [
    ExampleFirepodMapBoolean(),
    ExampleFirepodMapDouble(),
    ExampleFirepodMapInt(),
    ExampleFirepodMapString(),
  ],
  'Object': const [
    ExampleFirepodObject(),
    ExampleFirepodMapObject(),
    ExampleFirepodNestedObjects(),
    ExampleFirepodObjectAsMap(),
  ],
};

class FirepodExamplesPage extends ConsumerStatefulWidget {
  const FirepodExamplesPage({super.key});

  @override
  ConsumerState<FirepodExamplesPage> createState() => _FirepodExamplesPageState();
}

class _FirepodExamplesPageState extends ConsumerState<FirepodExamplesPage> {
  List<bool> _isPanelExpanded = List.generate(examples.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Outer scrollable to prevent layout issues
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isPanelExpanded = _isPanelExpanded.mapIndexed((i, item) => index == i ? isExpanded : item).toList();
            });
          },
          children: examples.entries
              .mapIndexed(
                (i, e) => ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(e.key),
                    );
                  },
                  body: Column(
                    children: e.value,
                  ),
                  isExpanded: _isPanelExpanded[i],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
