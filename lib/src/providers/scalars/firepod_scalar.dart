import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../generic/generic_lookup_map_notifier.dart';

class FirepodScalar<T> {
  late StateNotifierProvider<GenericSiteDataNotifier<T>, T> value;

  FirepodScalar({
    required String name,
    required T none,
    required String path,
    bool watch = false,
    bool autoSave = false,
    required T Function(Object value) decoder,
    required dynamic Function(T object) encoder,
  }) {
    value = StateNotifierProvider<GenericSiteDataNotifier<T>, T>(
      name: name,
      (ref) => GenericSiteDataNotifier<T>(
        ref: ref,
        path: path,
        decoder: (Object object) => decoder(object),
        encoder: (T value) => value == null ? none : encoder(value),
        none: none,
        watch: watch,
        autoSave: autoSave,
        isScalar: true,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifier<T>> get notifier => value.notifier;
}
