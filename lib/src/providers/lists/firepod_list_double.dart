import 'package:wt_firepod/wt_firepod.dart';

class FirepodListDouble extends FirepodList<double> {
  FirepodListDouble({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          decoder: (Object object) => double.parse(object.toString()),
          encoder: (double value) => value,
        );
}
