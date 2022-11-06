import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_firepod_examples/models/driver.dart';
import 'package:wt_firepod_examples/widgets/driver_list_tile.dart';

class DriverDefinition extends FirepodListDefinition<Driver> {
  DriverDefinition({
    String path = 'v1/driver',
    String orderBy = 'name',
    String? equalTo,
    int Function(Driver a, Driver b)? sortWith,
  }) : super(
          path: path,
          orderBy: orderBy,
          equalTo: equalTo,
          sortWith: sortWith,
          snapshotToModel: Driver.from.snapshot,
          mapToItem: Driver.from.json,
          itemToMap: Driver.to.firebaseMap,
          snapshotToList: Driver.from.snapshotList,
          formItemDefinitions: {
            'id': ModelFormDefinition<String>(
              label: 'ID',
              isUUID: true,
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
              readOnly: true,
            ),
            'name': ModelFormDefinition<String>(
              label: 'Title',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            'phone': ModelFormDefinition<String>(
              label: 'Phone',
              initialValue: '',
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
          },
          itemBuilder: (driver, _) => DriverListTile(
            driver: driver,
          ),
        );
}
