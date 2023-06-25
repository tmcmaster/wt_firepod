import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

class FirepodList<M> {
  late StateNotifierProvider<GenericSiteDataNotifierBase<List<M>>, List<M>> value;

  FirepodList({
    required String name,
    required M Function(Object object) decoder,
    required dynamic Function(M object) encoder,
    required String path,
    String? keyField,
    bool watch = false,
    bool autoSave = false,
  }) {
    List<M> modelListDecoder(Object object) {
      return ((object as List).whereType<Object>()).map((Object o) => decoder(o)).toList();
    }

    List<dynamic>? modelListEncoder(List<M>? list) {
      return list?.map((M? item) => item == null ? null : encoder(item)).toList();
    }

    value = StateNotifierProvider<GenericSiteDataNotifierBase<List<M>>, List<M>>(
      name: name,
      (ref) => GenericSiteDataNotifier<List<M>>(
        ref: ref,
        path: path,
        decoder: modelListDecoder,
        encoder: modelListEncoder,
        none: <M>[],
        autoLoad: watch,
        autoSave: autoSave,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<List<M>>> get notifier => value.notifier;
}
