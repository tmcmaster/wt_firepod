import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/utils/transformer.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class FirepodList<M> {
  static final log = logger(FirepodList);

  late StateNotifierProvider<GenericSiteDataNotifierBase<List<M>>, List<M>> value;

  FirepodList({
    required String name,
    required M Function(Object object) decoder,
    required dynamic Function(M object) encoder,
    required String path,
    bool watch = false,
    bool autoSave = false,
    String? idField,
    String? valueField,
  }) : value = StateNotifierProvider<GenericSiteDataNotifierBase<List<M>>, List<M>>(
          name: name,
          (ref) => GenericSiteDataNotifier<List<M>>(
            ref: ref,
            path: path,
            decoder: (Object object) {
              if (object is Map) {
                final jsonMap = Transformer.convertSnapshotMap(object);
                return jsonMap.entries.map((e) {
                  final key = e.key;
                  final value = e.value;
                  final map = value is Map
                      ? {
                          ...value,
                          if (idField != null) idField: key,
                        }
                      : {
                          if (valueField != null) valueField: value,
                          if (idField != null) idField: key,
                        };

                  return decoder(map);
                }).toList();
              } else {
                return (object as List).whereType<Object>().map((Object o) {
                  if (o is Map) {
                    final jsonMap = Transformer.convertSnapshotMap(o);
                    return decoder(jsonMap);
                  } else {
                    return decoder(o);
                  }
                }).toList();
              }
            },
            encoder: (List<M>? list) {
              return list?.map((M? item) => item == null ? null : encoder(item)).toList();
            },
            none: <M>[],
            autoLoad: watch,
            autoSave: autoSave,
          ),
        );

  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<List<M>>> get notifier => value.notifier;
}
