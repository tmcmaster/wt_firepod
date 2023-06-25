import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/builders/firebase_database_reference_builder.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_models/wt_models.dart';

class GenericSiteDataNotifier<T> extends GenericSiteDataNotifierBase<T> {
  static final log = logger(GenericSiteDataNotifier, level: Level.warning);

  late ProviderSubscription _removeListener;
  StreamSubscription<DatabaseEvent>? _subscription;
  DatabaseReference? _dbRef;

  final String path;
  final T none;
  final T Function(Object value) decoder;
  final dynamic Function(T object) encoder;
  final bool autoLoad;
  final bool autoSave;
  final bool isScalar;
  GenericSiteDataNotifier({
    required Ref ref,
    required this.none,
    required this.path,
    required this.decoder,
    required this.encoder,
    this.autoLoad = false,
    this.autoSave = false,
    this.isScalar = false,
  }) : super(none) {
    _setupSubscribers(ref);
    if (path.contains('{site}')) {
      log.d('Listening to ${FirepodSettings.site.value.name} for changes.');
      _removeListener = ref.listen<IdSupport?>(FirepodSettings.site.value, (oldSite, newSite) {
        log.d('${FirepodSettings.site.value} has changed');
        _setupSubscribers(ref);
      }, onError: (error, _) {});
    }
  }

  void _setupSubscribers(Ref ref) {
    final dbRefBuilder = ref.read(FirebaseDatabaseReferenceBuilder.provider);
    _dbRef = dbRefBuilder.build(path);
    if (_dbRef == null) {
      state = none;
    } else {
      if (autoLoad) {
        if (_subscription != null) {
          _subscription!.cancel();
        }
        _subscription = _dbRef!.onValue.listen((event) {
          state = event.snapshot.value == null ? none : decoder(event.snapshot.value!);
        }, onError: (error) => log.e(error));
      }
      load();
    }
  }

  @override
  void update(T newValue) {
    state = newValue;
    if (autoSave) {
      save();
    }
  }

  @override
  void save() {
    if (_dbRef != null) {
      _dbRef!.set(encoder(state));
    }
  }

  @override
  void load() {
    if (_dbRef != null) {
      _dbRef!.get().then((snapshot) {
        if (snapshot.exists) {
          if (snapshot.value == null) {
            state = none;
          } else {
            if (isScalar) {
              if (snapshot.value is Map<dynamic, dynamic>) {
                // TODO: need to find out why reading scalar values reads the parent map
                //      this will be loading a lot more data that is need each time.
                final value = (snapshot.value as Map<dynamic, dynamic>)[snapshot.key];
                state = decoder(value) ?? none;
              } else {
                state = snapshot.value == null ? none : decoder(snapshot.value!);
              }
            } else {
              state = snapshot.value == null ? none : decoder(snapshot.value!);
            }
          }
        } else {
          state = none;
        }
      }, onError: (error) => log.e(error));
    }
  }

  @override
  void dispose() {
    if (_subscription != null) {
      _subscription!.cancel();
    }
    _removeListener.close();
    super.dispose();
  }
}
