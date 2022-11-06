import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/models/supplier.dart';
import 'package:wt_firepod_examples/widgets/supplier_list_tile.dart';

class SupplierDefinition extends FirepodListDefinition<Supplier> {
  SupplierDefinition({
    String path = 'v1/supplier',
    String orderBy = 'name',
    String? equalTo,
    int Function(Supplier a, Supplier b)? sortWith,
  }) : super(
          path: path,
          orderBy: orderBy,
          equalTo: equalTo,
          sortWith: sortWith,
          convertFrom: Supplier.from,
          convertTo: Supplier.to,
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
            'code': ModelFormDefinition<String>(
              type: TextInputType.text,
              label: 'Code',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
          },
          itemBuilder: (supplier, _) => SupplierListTile(
            supplier: supplier,
          ),
        );
}
