import 'package:wt_firepod/wt_firepod.dart';

class FirepodListDouble extends FirepodList<double> {
  FirepodListDouble({
    required String name,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) : super(
          name: name,
          path: path,
          decoder: (Object object) => double.parse(object.toString()),
          encoder: (double value) => value,
          watch: watch,
          autoSave: autoSave,
        );
}
