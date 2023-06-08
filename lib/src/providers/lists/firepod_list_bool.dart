import 'package:wt_firepod/wt_firepod.dart';

class FirepodListBool extends FirepodList<bool> {
  FirepodListBool({
    required String name,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) : super(
          name: name,
          path: path,
          decoder: (Object object) => bool.parse(object.toString()),
          encoder: (bool value) => value,
          watch: watch,
          autoSave: autoSave,
        );
}
