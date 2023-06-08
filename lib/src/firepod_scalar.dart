import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'generic_lookup_map_notifier.dart';

class FirepodScalar<T> {
  late StateNotifierProvider<GenericSiteDataNotifier<T>, T> value;

  FirepodScalar({
    required String name,
    required T none,
    required String path,
    bool watch = false,
    bool siteEnabled = true,
  }) {
    value = StateNotifierProvider<GenericSiteDataNotifier<T>, T>(
      name: name,
      (ref) => GenericSiteDataNotifier<T>(
          ref: ref,
          path: path,
          decoder: (value) => value as T,
          encoder: (object) => object,
          none: none,
          watch: watch,
          isScalar: true,
          siteEnabled: siteEnabled),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifier<T>> get notifier => value.notifier;
}
