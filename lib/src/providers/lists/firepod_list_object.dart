import 'package:wt_firepod/wt_firepod.dart';

class FirepodListObject<T> extends FirepodList<T> {
  FirepodListObject({
    required super.name,
    required super.path,
    required T Function(Map<dynamic, dynamic>) decoder,
    required Map<dynamic, dynamic> Function(T object) encoder,
    super.watch,
    super.autoSave,
  }) : super(
          decoder: (Object value) {
            return decoder(value as Map<dynamic, dynamic>);
          },
          encoder: (T model) {
            return encoder(model);
          },
        );
}
