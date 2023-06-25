import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';

import '../generic/generic_site_data_notifier.dart';

class FirepodScalar<T> {
  late StateNotifierProvider<GenericSiteDataNotifierBase<T>, T> value;

  FirepodScalar({
    required String name,
    required T none,
    required String path,
    bool watch = false,
    bool autoSave = false,
    required T Function(Object value) decoder,
    required dynamic Function(T object) encoder,
  }) {
    value = StateNotifierProvider<GenericSiteDataNotifierBase<T>, T>(
      name: name,
      (ref) => GenericSiteDataNotifier<T>(
        ref: ref,
        path: path,
        decoder: (Object object) => decoder(object),
        encoder: (T value) => value == null ? none : encoder(value),
        none: none,
        autoLoad: watch,
        autoSave: autoSave,
        isScalar: true,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<T>> get notifier => value.notifier;
}
