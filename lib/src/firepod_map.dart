import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'generic_lookup_map.dart';
import 'generic_lookup_map_notifier.dart';

abstract class FirepodMap<T> {
  late StateNotifierProvider<GenericSiteDataNotifier<GenericLookupMap<T>>, GenericLookupMap<T>>
      value;

  FirepodMap({
    required String name,
    required GenericLookupMap<T> none,
    required T Function(Object? value) decoder,
    required dynamic Function(T? object) encoder,
    required String prefixPath,
    String? keyField,
    bool watch = false,
    bool siteEnabled = true,
  }) {
    value =
        StateNotifierProvider<GenericSiteDataNotifier<GenericLookupMap<T>>, GenericLookupMap<T>>(
      name: name,
      (ref) => GenericSiteDataNotifier<GenericLookupMap<T>>(
        ref: ref,
        prefixPath: prefixPath,
        decoder: GenericLookupMap.createDecoder<T>((object) => decoder(object), keyField),
        encoder: GenericLookupMap.createEncoder<T>((T? object) => encoder(object), keyField),
        none: none,
        watch: watch,
        siteEnabled: siteEnabled,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifier<GenericLookupMap>> get notifier => value.notifier;
}

// dynamic Function(GenericLookupMap<T>?)
// dynamic Function(GenericLookupMap<T>?)
