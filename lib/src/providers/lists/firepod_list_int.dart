import 'package:wt_firepod/wt_firepod.dart';

class FirepodListInt extends FirepodList<int> {
  FirepodListInt({
    required String name,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) : super(
          name: name,
          path: path,
          decoder: (Object object) => int.parse(object.toString()),
          encoder: (int value) => value,
          watch: watch,
          autoSave: autoSave,
        );
}
