import 'package:wt_firepod/wt_firepod.dart';

class FirepodListInt extends FirepodList<int> {
  FirepodListInt({
    required super.name,
    required super.path,
    super.watch,
    super.autoSave,
  }) : super(
          decoder: (Object object) => int.parse(object.toString()),
          encoder: (int value) => value,
        );
}
