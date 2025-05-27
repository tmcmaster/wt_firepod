import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/providers/generic/firepod_state_notifier_providers.dart';
import 'package:wt_firepod/src/utils/transformer.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_provider_manager/wt_provider_manager.dart';

class FirepodList<M> with FirepodStateNotifierProviders<List<M>>, WaitForIsReadyProvider {
  static final log = logger(FirepodList);

  @override
  late StateNotifierProvider<GenericSiteDataNotifierBase<List<M>>, List<M>> value;
  @override
  late final Provider<Future> isReady;

  final _isReady = Completer<void>();

  FirepodList({
    required String name,
    required M Function(Object object) decoder,
    required dynamic Function(M object) encoder,
    required String path,
    bool watch = false,
    bool autoSave = false,
    String? idField,
    String? valueField,
  }) {
    isReady = Provider((ref) => _isReady.future);
    value = StateNotifierProvider<GenericSiteDataNotifierBase<List<M>>, List<M>>(
      name: name,
      (ref) => GenericSiteDataNotifier<List<M>>(
        ref: ref,
        path: path,
        decoder: (Object object) {
          if (object is Map) {
            final jsonMap = Transformer.convertSnapshotMap(object);
            return jsonMap.entries.map((e) {
              final key = e.key;
              final value = e.value;
              final map = value is Map
                  ? {
                      ...value,
                      if (idField != null) idField: key,
                    }
                  : {
                      if (valueField != null) valueField: value,
                      if (idField != null) idField: key,
                    };

              return decoder(map);
            }).toList();
          } else {
            return (object as List).whereType<Object>().map((Object o) {
              if (o is Map) {
                final jsonMap = Transformer.convertSnapshotMap(o);
                return decoder(jsonMap);
              } else {
                return decoder(o);
              }
            }).toList();
          }
        },
        encoder: (List<M>? list) {
          return list?.map((M? item) => item == null ? null : encoder(item)).toList();
        },
        none: <M>[],
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

  Refreshable<GenericSiteDataNotifierBase<List<M>>> get notifier => value.notifier;
}
