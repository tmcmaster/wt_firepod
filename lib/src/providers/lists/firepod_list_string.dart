import 'package:wt_firepod/wt_firepod.dart';

class FirepodListString extends FirepodList<String> {
  FirepodListString({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          decoder: (Object object) => object.toString(),
          encoder: (String value) => value,
        );
}
