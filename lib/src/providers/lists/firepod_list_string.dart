import 'package:wt_firepod/wt_firepod.dart';

class FirepodListString extends FirepodList<String> {
  FirepodListString({
    required String name,
    required String path,
    bool watch = true,
    bool autoSave = false,
  }) : super(
          name: name,
          path: path,
          decoder: (Object object) => object.toString(),
          encoder: (String value) => value,
          watch: watch,
          autoSave: autoSave,
        );
}
