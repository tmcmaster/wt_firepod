import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wt_firepod/wt_firepod.dart';

final productFormDefinition = {
  'id': ModelFormDefinition<String>(
    label: 'ID',
    isUUID: true,
    initialValue: '',
    validators: [
      FormBuilderValidators.required(),
    ],
    readOnly: true,
  ),
  'title': ModelFormDefinition<String>(
    label: 'Title',
    initialValue: '',
    validators: [
      FormBuilderValidators.required(),
    ],
  ),
  'price': ModelFormDefinition<double>(
    label: 'Price',
    initialValue: 0.0,
    validators: [
      FormBuilderValidators.required(),
    ],
  ),
  'weight': ModelFormDefinition<double>(
    label: 'Weight',
    initialValue: 0.0,
    validators: [
      FormBuilderValidators.required(),
    ],
  ),
};
