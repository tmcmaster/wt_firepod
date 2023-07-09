import 'package:wt_firepod/wt_firepod.dart';

class FirepodListBool extends FirepodList<bool> {
  FirepodListBool({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          decoder: (Object object) => bool.parse(object.toString()),
          encoder: (bool value) => value,
        );
}
