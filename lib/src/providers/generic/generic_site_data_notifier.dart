import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/builders/firebase_database_reference_builder.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_models/wt_models.dart';

class GenericSiteDataNotifier<T> extends GenericSiteDataNotifierBase<T> {
  static final log = logger(GenericSiteDataNotifier);

  ProviderSubscription? _removeSiteListListener;
  ProviderSubscription? _removeUserListener;
  StreamSubscription<DatabaseEvent>? _subscription;
  StreamSubscription<User?>? _userSubscription;
  DatabaseReference? _dbRef;
  @override
  late final Provider<Future> isReady;
  final _isReady = Completer<void>();

  final String path;
  final T none;
  final T Function(Object value) decoder;
  final dynamic Function(T object) encoder;
  final bool autoLoad;
  final bool autoSave;
  final bool isScalar;
  final VoidCallback onLoad;

  GenericSiteDataNotifier({
    required Ref ref,
    required this.none,
    required this.path,
    required this.decoder,
    required this.encoder,
    required this.onLoad,
    this.autoLoad = false,
    this.autoSave = false,
    this.isScalar = false,
  }) : super(none) {
    isReady = Provider((ref) => _isReady.future);
    _setupSubscribers(ref);
    if (path.contains('{site}')) {
      log.d('Listening to site provider ${FirepodSettings.site.value.name} for changes.');
      _removeSiteListListener = ref.listen<IdSupport?>(
        FirepodSettings.site.value,
        fireImmediately: true,
        (_, newSite) {
          log.d('Change Event: Site(${FirepodSettings.site.value}) changed to $newSite');
          if (newSite == null) {
            _removeSubscribers(ref);
          } else {
            _setupSubscribers(ref);
          }
        },
        onError: (error, _) {},
      );
    }
    if (path.contains('{user}')) {
      log.d('Listening to auth provider ${FirebaseProviders.auth.name} for changes.');
      _userSubscription = ref.read(FirebaseProviders.auth).authStateChanges().listen(
        (newUser) {
          log.d('Change Event: User(${FirebaseProviders.auth.name}) has changed to $newUser');
          if (newUser == null) {
            _removeSubscribers(ref);
          } else {
            _setupSubscribers(ref);
          }
        },
      );
    }
  }

  void _removeSubscribers(Ref ref) {
    if (_subscription != null) {
      _subscription!.cancel();
    }
  }

  void _setupSubscribers(Ref ref) {
    final dbRefBuilder = ref.read(FirebaseDatabaseReferenceBuilder.provider);
    _dbRef = dbRefBuilder.build(path);
    if (_dbRef == null) {
      log.w('There were missing path variables, so setting value to none.');
      _setState(none);
    } else {
      if (autoLoad) {
        log.d('Auto load is required: $path');
        if (_subscription != null) {
          _subscription!.cancel();
        }
        _subscription = _dbRef!.onValue.listen(
          (event) {
            try {
              log.t('Change Event for Path($path): ${event.snapshot.value}');
              _setState(event.snapshot.value == null ? none : decoder(event.snapshot.value!));
            } catch (error) {
              log.e('Error while converting value from Ref($path): $error');
            }
          },
          onError: (error) => log.e('Subscription($path) experienced an error: $error'),
        );
        load();
      } else {
        log.d('Auto load is not enabled: $path');
      }
    }
  }

  @override
  Future<void> update(T newValue) async {
    _setState(newValue);
    if (autoSave) {
      await save();
    }
  }

  @override
  Future<void> save() async {
    if (_dbRef != null) {
      log.d('Saving state to database: $path');
      await _dbRef!.set(encoder(state));
    } else {
      log.w('Could not save because the path is not available: $path');
    }
  }

  @override
  String? getPath() {
    return _dbRef?.path;
  }

  @override
  Future<void> load() async {
    log.d('Loading data from path: $path');
    if (_dbRef != null) {
      log.d('Ref(${_dbRef?.path})');
      await _dbRef!.get().then(
        (snapshot) {
          if (snapshot.exists) {
            if (snapshot.value == null) {
              log.w('There was not data in the database, so setting state to none.');
              _setState(none);
            } else {
              log.t('Snapshot(${snapshot.key}) Value(${snapshot.value})');
              if (isScalar) {
                if (snapshot.value is Map<dynamic, dynamic>) {
                  // TODO: need to find out why reading scalar values reads the parent map
                  //      this will be loading a lot more data that is need each time.
                  final value = (snapshot.value! as Map<dynamic, dynamic>)[snapshot.key];
                  if (value == null) {
                    log.w('There was not data in the database, so setting state to none.');
                    _setState(none);
                  } else {
                    log.t('Saving Map: Snapshot(${snapshot.key}) Value(${snapshot.value})');
                    _setState(decoder(value as Object) ?? none);
                  }
                } else {
                  log.t('Saving AAA: Snapshot(${snapshot.key}) Value(${snapshot.value})');
                  _setState(snapshot.value == null ? none : decoder(snapshot.value!));
                }
              } else {
                log.t('Saving BBB: Snapshot(${snapshot.key}) Value(${snapshot.value})');
                _setState(snapshot.value == null ? none : decoder(snapshot.value!));
              }
            }
            log.d('Data has been loaded from the database: $path');
          } else {
            log.w('Path does not exist, so setting state to none.');
            _setState(none);
          }
        },
        onError: (error) {
          log.e('There was an error listening to the database Path($path): $error');
        },
      );
    }
  }

  void _setState(T newState) {
    final loadComplete = state == none && newState != none;
    state = newState;
    if (loadComplete) {
      if (!_isReady.isCompleted) {
        _isReady.complete();
      }
      onLoad();
    }
  }

  @override
  void dispose() {
    log.i('Disposing all of the subscriptions.');
    _subscription?.cancel();
    _removeSiteListListener?.close();
    _removeUserListener?.close();
    _userSubscription?.cancel();
    super.dispose();
  }
}
