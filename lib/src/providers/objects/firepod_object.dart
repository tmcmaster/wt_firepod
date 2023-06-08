import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../generic/generic_lookup_map_notifier.dart';

class FirepodObject<T> {
  late StateNotifierProvider<GenericSiteDataNotifier<T>, T> value;

  FirepodObject({
    required String name,
    required T none,
    required T Function(Map<dynamic, dynamic> value) decoder,
    required dynamic Function(T model) encoder,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) {
    value = StateNotifierProvider<GenericSiteDataNotifier<T>, T>(
      name: name,
      (ref) => GenericSiteDataNotifier<T>(
        ref: ref,
        path: path,
        decoder: (value) => value == null ? none : decoder(value as Map<dynamic, dynamic>),
        encoder: (T? object) => object == null ? null : encoder(object),
        none: none,
        watch: watch,
        autoSave: autoSave,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifier<T>> get notifier => value.notifier;
}
