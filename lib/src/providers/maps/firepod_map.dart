import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';

import '../generic/generic_lookup_map.dart';

abstract class FirepodMap<T> {
  late StateNotifierProvider<GenericSiteDataNotifierBase<GenericLookupMap<T>>, GenericLookupMap<T>>
      value;

  FirepodMap({
    required String name,
    required GenericLookupMap<T> none,
    required T Function(Object value) decoder,
    required dynamic Function(T object) encoder,
    required String path,
    String? keyField,
    bool watch = false,
    bool autoSave = false,
  }) {
    value = StateNotifierProvider<GenericSiteDataNotifierBase<GenericLookupMap<T>>,
        GenericLookupMap<T>>(
      name: name,
      (ref) => GenericSiteDataNotifier<GenericLookupMap<T>>(
        ref: ref,
        path: path,
        decoder: GenericLookupMap.createDecoder<T>((object) => decoder(object), keyField),
        encoder: GenericLookupMap.createEncoder<T>((T object) => encoder(object), keyField),
        none: none,
        autoLoad: watch,
        autoSave: autoSave,
      ),
    );
  }

  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<GenericLookupMap>> get notifier =>
      value.notifier;
}
