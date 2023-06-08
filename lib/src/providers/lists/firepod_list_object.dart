import 'package:wt_firepod/wt_firepod.dart';

class FirepodListObject<T> extends FirepodList<T> {
  FirepodListObject({
    required String name,
    required String path,
    required T Function(Map<dynamic, dynamic>) decoder,
    required Map<dynamic, dynamic> Function(T object) encoder,
    String? keyField,
    bool watch = true,
    bool siteEnabled = false,
  }) : super(
          name: name,
          decoder: (Object? value) {
            return value == null ? null : decoder(value as Map<dynamic, dynamic>);
          },
          encoder: (T? model) {
            return model == null ? null : encoder(model);
          },
          path: path,
          watch: watch,
          keyField: keyField,
        );
}
