import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

class FirepodList<M> {
  late StateNotifierProvider<GenericSiteDataNotifier<List<M?>>, List<M?>> value;

  FirepodList({
    required String name,
    required M? Function(Object? object) decoder,
    required dynamic Function(M? object) encoder,
    required String path,
    String? keyField,
    bool watch = false,
  }) {
    List<M?>? modelListDecoder(Object? object) {
      return object == null
          ? null
          : (object as List<Object?>).map((Object? o) => decoder(o)).toList();
    }

    List<dynamic>? modelListEncoder(List<M?>? list) {
      return list?.map((M? item) => encoder(item)).toList();
    }

    value = StateNotifierProvider<GenericSiteDataNotifier<List<M?>>, List<M?>>(
      name: name,
      (ref) => GenericSiteDataNotifier<List<M?>>(
        ref: ref,
        path: path,
        decoder: modelListDecoder,
        encoder: modelListEncoder,
        none: <M>[],
        watch: watch,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifier<List<M?>>> get notifier => value.notifier;
}
