import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/models/product.dart';

final selectedItemsProvider =
    StateNotifierProvider<SelectedItems<Product>, Set<Product>>((ref) => SelectedItems<Product>());

const debug = false;

class FormExamplePage extends StatefulWidget {
  const FormExamplePage({super.key});

  @override
  State<FormExamplePage> createState() => _FormExamplePageState();
}

class _FormExamplePageState extends State<FormExamplePage> {
  static final log = logger(FormExamplePage, level: Level.debug);

  final _formKey = GlobalKey<FormBuilderState>();

  double stringTpDouble(String? value) => value == null ? 0 : double.parse(value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              showAnimatedDialog(
                context: context,
                barrierDismissible: true,
                animationType: DialogTransitionType.slideFromRight,
                alignment: Alignment.center,
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Add a new Website token'),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilder(
                        key: _formKey,
                        // enabled: false,
                        onChanged: () {
                          _formKey.currentState!.save();
                          log.d(_formKey.currentState!.value.toString());
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                        initialValue: const {
                          'id': '001',
                          'title': 'One',
                          'price': '1',
                          'weight': '11',
                        },
                        skipDisabled: true,
                        child: Column(children: [
                          FormBuilderTextField(
                            key: const ValueKey('Form:id'),
                            autovalidateMode: AutovalidateMode.always,
                            name: 'id',
                            enabled: true,
                            decoration: const InputDecoration(
                              labelText: 'ID',
                            ),
                            onChanged: (val) {},
                            // valueTransformer: (text) => num.tryParse(text),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 10),
                          FormBuilderTextField(
                            key: const ValueKey('Form:title'),
                            autovalidateMode: AutovalidateMode.always,
                            name: 'title',
                            enabled: true,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                            onChanged: (val) {},
                            // valueTransformer: (text) => num.tryParse(text),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 10),
                          FormBuilderTextField(
                            key: const ValueKey('Form:price'),
                            autovalidateMode: AutovalidateMode.always,
                            name: 'price',
                            enabled: true,
                            decoration: const InputDecoration(
                              labelText: 'Price',
                            ),
                            onChanged: (val) {},
                            valueTransformer: stringTpDouble,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 10),
                          FormBuilderTextField(
                            key: const ValueKey('Form:weight'),
                            autovalidateMode: AutovalidateMode.always,
                            name: 'weight',
                            enabled: true,
                            decoration: const InputDecoration(
                              labelText: 'Weight',
                            ),
                            onChanged: (val) {},
                            valueTransformer: stringTpDouble,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _persistItem();
                                },
                                icon: const Icon(FontAwesomeIcons.floppyDisk),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text('Form'),
          ),
        ),
      ),
    );
  }

  void _persistItem() {
    _formKey.currentState!.save();

    Map<String, dynamic> map = {..._formKey.currentState!.value};
    final product = Product.from.json(map);
    log.d(product);
  }
}

class SelectedItemsView extends ConsumerWidget {
  const SelectedItemsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItemsProvider);

    return Consumer(
      builder: (_, ref, __) => Row(
        children: selected.map((i) => Text(i.title)).toList(),
      ),
    );
  }
}
