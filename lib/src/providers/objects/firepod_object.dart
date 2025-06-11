import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/firepod_state_notifier_providers.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';
import 'package:wt_firepod/src/utils/transformer.dart';
import 'package:wt_provider_manager/provider_manager.dart';

class FirepodObject<T> with FirepodStateNotifierProviders<T>, WaitForIsReadyProvider {
  @override
  late StateNotifierProvider<GenericSiteDataNotifierBase<T>, T> value;
  @override
  late final Provider<Future> isReady;

  final _isReady = Completer<void>();

  FirepodObject({
    required String name,
    required T none,
    required T Function(Map<dynamic, dynamic> value) decoder,
    required dynamic Function(T model) encoder,
    required String path,
    bool watch = false,
    bool autoSave = false,
  }) {
    isReady = Provider((ref) => _isReady.future);
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
        onLoad: () {
          if (!_isReady.isCompleted) {
            _isReady.complete();
          }
        },
      ),
    );
  }

  Refreshable<GenericSiteDataNotifierBase<T>> get notifier => value.notifier;
}
