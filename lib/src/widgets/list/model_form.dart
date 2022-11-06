import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:uuid/uuid.dart';
import 'package:wt_firepod/src/utils/logging.dart';
import 'package:wt_firepod/src/widgets/list/model_form_definition.dart';
import 'package:wt_models/wt_models.dart';

class ModelForm<T extends IdJsonSupport> extends StatefulWidget {
  static final log = logger(ModelForm);

  final T? item;
  final void Function(T model) onSubmit;
  final Map<String, ModelFormDefinition<dynamic>> formItemDefinitions;

  final T Function(Map<String, dynamic> json) mapToItem;
  final Map<String, dynamic> Function(T item) itemToMap;

  const ModelForm({
    Key? key,
    this.item,
    required this.formItemDefinitions,
    required this.onSubmit,
    required this.itemToMap,
    required this.mapToItem,
  }) : super(key: key);

  @override
  State<ModelForm> createState() => _ModelFormState();

  void persistItem(Map<String, dynamic> map) {
    try {
      final item = mapToItem(map);
      onSubmit(item);
    } catch (error) {
      log.e('There was an issue adding new item: ${error.toString()}');
    }
  }
}

class _ModelFormState extends State<ModelForm> {
  static final log = logger(ModelForm);

  static const uuid = Uuid();

  final _formKey = GlobalKey<FormBuilderState>();

  final Map<String, bool> _hasError = {};

  _ModelFormState() {
    Future.delayed(const Duration(milliseconds: 10)).then((_) {
      setState(() {
        log.d('Initialising the hasError map.');
        for (var key in widget.formItemDefinitions.keys) {
          try {
            _hasError[key] = !(_formKey.currentState?.fields[key]?.validate() ?? true);
            log.d('- hasError($key): ${_hasError[key]}');
          } catch (error) {
            log.d('- hasError($key): ${error.toString()}');
          }
        }
      });
    });
  }

  static double stringToDouble(String? value) => value == null || value.isEmpty ? 0 : double.tryParse(value) ?? 0;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> initialValues = _generateInitialValues();

    final fields = widget.formItemDefinitions.keys.map((key) {
      final fieldDefinition = widget.formItemDefinitions[key];

      // TODO: may need to extend the TextInputType enum to include more specific types like double
      // alternatively include option transforms in the definition.
      final isNumber = fieldDefinition!.type == TextInputType.number;

      return FormBuilderTextField(
        key: ValueKey('Form $key'),
        autovalidateMode: AutovalidateMode.always,
        name: key,
        enabled: !fieldDefinition!.readOnly,
        decoration: InputDecoration(
          labelText: widget.formItemDefinitions[key]!.label,
          suffixIcon: _hasError[key] ?? true
              ? const Icon(Icons.error, color: Colors.red)
              : const Icon(Icons.check, color: Colors.green),
        ),
        onChanged: (val) {
          setState(() {
            log.d('-- Setting hasError($key): ${_hasError[key]}');
            _hasError[key] = !(_formKey.currentState?.fields[key]?.validate() ?? true);
          });
        },
        valueTransformer: fieldDefinition.fromString ?? (isNumber ? stringToDouble : null),
        validator: FormBuilderValidators.compose(widget.formItemDefinitions[key]!.validators),
        initialValue: initialValues[key].toString(),
        keyboardType: fieldDefinition.type,
        textInputAction: TextInputAction.next,
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilder(
        key: _formKey,
        // enabled: false,
        onChanged: () {
          _formKey.currentState!.save();
          log.d(_formKey.currentState!.value.toString());
        },
        autovalidateMode: AutovalidateMode.disabled,
        initialValue: initialValues,
        skipDisabled: true,
        child: Column(
          children: [
            ...fields.map((field) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: field,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: allValid() ? () => _persistItem() : null,
                  icon: const Icon(FontAwesomeIcons.floppyDisk),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _generateInitialValues() {
    if (widget.item == null) {
      log.d('Generating initial values from definition.');
      return widget.formItemDefinitions
          .map((key, definition) => MapEntry(key, definition.isUUID ? uuid.v4() : definition.initialValue));
    } else {
      Map<String, dynamic> initialValues = widget.item!.toJson();
      log.d('Generating initial values from item: $initialValues');
      return initialValues;
    }
  }

  bool allValid() {
    for (var key in _hasError.keys) {
      log.d('-- hasError($key): ${_hasError[key]}');
      if (_hasError[key] == true) return false;
    }
    return true;
  }

  void _persistItem() {
    _formKey.currentState!.save();

    Map<String, dynamic> map = {..._formKey.currentState!.value};
    if (map['id'] == null) {
      map['id'] = uuid.v4();
      log.d('Added an ID to the item: ${map['id']}');
    }

    print(map);
    widget.persistItem(map);
  }
}
