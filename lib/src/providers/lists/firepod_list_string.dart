import 'package:wt_firepod/wt_firepod.dart';

class FirepodListString extends FirepodList<String> {
  FirepodListString({
    required String name,
    required String path,
    bool watch = true,
    bool siteEnabled = false,
  }) : super(
          name: name,
          decoder: (Object? object) => object?.toString(),
          encoder: (String? value) => value,
          path: path,
          watch: watch,
        );
}
