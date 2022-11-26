import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/models/customer.dart';
import 'package:wt_firepod_examples/widgets/customer_list_tile.dart';

class CustomerDefinition extends FirepodListDefinition<Customer> {
  CustomerDefinition({
    String path = 'v1/customer',
    String orderBy = 'order',
    String? equalTo,
    int Function(Customer a, Customer b)? sortWith,
  }) : super(
          path: path,
          orderBy: orderBy,
          equalTo: equalTo,
          sortWith: sortWith,
          convertTo: Customer.to,
          convertFrom: Customer.from,
          formItemDefinitions: {
            'id': ModelFormDefinition<String>(
              type: TextInputType.text,
              label: 'ID',
              isUUID: true,
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
              readOnly: true,
            ),
            'name': ModelFormDefinition<String>(
              type: TextInputType.text,
              label: 'Title',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            'phone': ModelFormDefinition<String>(
              type: TextInputType.phone,
              label: 'Phone',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
                DataValidators.phone(),
              ],
            ),
            'email': ModelFormDefinition<String>(
              type: TextInputType.emailAddress,
              label: 'Email',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ],
            ),
            'address': ModelFormDefinition<String>(
              type: TextInputType.text,
              label: 'Address',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            'postcode': ModelFormDefinition<int>(
              type: TextInputType.number,
              fromString: DataTransforms.stringToInt,
              label: 'Postcode',
              initialValue: 0,
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
          },
          itemBuilder: (customer, _) => CustomerListTile(
            customer: customer,
          ),
        );
}
