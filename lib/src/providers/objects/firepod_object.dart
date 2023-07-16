import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';
import 'package:wt_firepod/src/utils/transformer.dart';

class FirepodObject<T> {
  late StateNotifierProvider<GenericSiteDataNotifierBase<T>, T> value;

  FirepodObject({
    required String name,
    required T none,
    required T Function(Map<dynamic, dynamic> value) decoder,
    required dynamic Function(T model) encoder,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) {
    value = StateNotifierProvider<GenericSiteDataNotifierBase<T>, T>(
      name: name,
      (ref) => GenericSiteDataNotifier<T>(
        ref: ref,
        path: path,
        decoder: (value) => decoder(Transformer.convertSnapshotMap(value as Map)),
        encoder: (T? object) => object == null ? null : encoder(object),
        none: none,
        autoLoad: watch,
        autoSave: autoSave,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<T>> get notifier => value.notifier;
}
