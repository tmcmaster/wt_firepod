import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/builders/firebase_database_reference_builder.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_models/wt_models.dart';

class GenericSiteDataNotifier<T> extends StateNotifier<T> {
  static final log = logger(GenericSiteDataNotifier, level: Level.debug);

  late ProviderSubscription _removeListener;
  StreamSubscription<DatabaseEvent>? _subscription;
  DatabaseReference? _dbRef;

  final String path;
  final T none;
  final T? Function(Object? value) decoder;
  final dynamic Function(T? object) encoder;
  final bool watch;
  final bool autoSave;
  final bool isScalar;
  GenericSiteDataNotifier({
    required Ref ref,
    required this.none,
    required this.path,
    required this.decoder,
    required this.encoder,
    this.watch = false,
    this.autoSave = true,
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
      if (watch) {
        if (_subscription != null) {
          _subscription!.cancel();
        }
        _subscription = _dbRef!.onValue.listen((event) {
          state = decoder(event.snapshot.value) ?? none;
        }, onError: (error) => log.e(error));
      }
      load();
    }
  }

  void update(T newValue) {
    state = newValue;
    if (autoSave) {
      save();
    }
  }

  void save() {
    if (_dbRef != null) {
      _dbRef!.set(encoder(state));
    }
  }

  void load() {
    if (_dbRef != null) {
      _dbRef!.get().then((snapshot) {
        if (snapshot.exists) {
          // TODO: need to find out why reading scalar values reads the parent map
          //      this will be loading a lot more data that is need each time.
          final newValue = snapshot.value == null
              ? null
              : isScalar
                  ? (snapshot.value as Map<dynamic, dynamic>)[snapshot.key]
                  : snapshot.value;
          state = decoder(newValue) ?? none;
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
