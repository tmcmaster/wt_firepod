import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/firepod_state_notifier_providers.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';
import 'package:wt_provider_manager/provider_manager.dart';

class FirepodScalar<T> with FirepodStateNotifierProviders<T>, WaitForIsReadyProvider {
  @override
  late StateNotifierProvider<GenericSiteDataNotifierBase<T>, T> value;
  @override
  late final Provider<Future> isReady;

  final _isReady = Completer<void>();

  FirepodScalar({
    required String name,
    required T none,
    required String path,
    bool watch = false,
    bool autoSave = false,
    required T Function(Object value) decoder,
    required dynamic Function(T object) encoder,
  }) {
    isReady = Provider((ref) => _isReady.future);
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
