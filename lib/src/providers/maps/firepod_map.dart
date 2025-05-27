import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/firepod_state_notifier_providers.dart';
import 'package:wt_firepod/src/providers/generic/generic_lookup_map.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';
import 'package:wt_provider_manager/wt_provider_manager.dart';

abstract class FirepodMap<T> with FirepodStateNotifierProviders<GenericLookupMap<T>>, WaitForIsReadyProvider {
  @override
  late StateNotifierProvider<GenericSiteDataNotifierBase<GenericLookupMap<T>>, GenericLookupMap<T>> value;
  @override
  late final Provider<Future> isReady;

  final _isReady = Completer<void>();

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
    isReady = Provider((ref) => _isReady.future);
    value = StateNotifierProvider<GenericSiteDataNotifierBase<GenericLookupMap<T>>, GenericLookupMap<T>>(
      name: name,
      (ref) {
        return GenericSiteDataNotifier<GenericLookupMap<T>>(
          ref: ref,
          path: path,
          decoder: GenericLookupMap.createDecoder<T>((object) => decoder(object), keyField),
          encoder: GenericLookupMap.createEncoder<T>((T object) => encoder(object) as Object, keyField),
          none: none,
          autoLoad: watch,
          autoSave: autoSave,
          onLoad: () {
            if (!_isReady.isCompleted) {
              _isReady.complete();
            }
          },
        );
      },
    );
  }

  Refreshable<GenericSiteDataNotifierBase<GenericLookupMap>> get notifier => value.notifier;
}
