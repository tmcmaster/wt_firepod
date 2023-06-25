import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/firepod_object_interface.dart';
import 'package:wt_firepod/src/providers/generic/generic_site_data_notifier_base.dart';

import '../generic/generic_site_data_notifier.dart';

class FirepodObject<T> implements FirepodObjectInterface<T> {
  @override
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
        decoder: (value) => decoder(value as Map<dynamic, dynamic>),
        encoder: (T? object) => object == null ? null : encoder(object),
        none: none,
        autoLoad: watch,
        autoSave: autoSave,
      ),
    );
  }

  @override
  AlwaysAliveRefreshable<GenericSiteDataNotifierBase<T>> get notifier => value.notifier;
}
