import 'dart:async';

import 'package:wt_firepod/src/builders/firebase_database_reference_builder.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_models/wt_models.dart';

import 'firepod.dart';

class GenericSiteDataNotifier<T> extends StateNotifier<T> {
  static final log = logger(GenericSiteDataNotifier, level: Level.debug);

  late ProviderSubscription _removeListener;
  StreamSubscription<DatabaseEvent>? _subscription;
  DatabaseReference? _dbRef;

  final String path;
  final T none;
  final T? Function(Object? json) decoder;
  final dynamic Function(T? object) encoder;
  final bool watch;
  final bool siteEnabled;
  final bool autoSave;
  GenericSiteDataNotifier({
    required Ref ref,
    required this.none,
    required this.path,
    required this.decoder,
    required this.encoder,
    this.watch = false,
    this.siteEnabled = false,
    this.autoSave = true,
  }) : super(none) {
    _setupSubscribers(ref);
    if (siteEnabled) {
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
          state = decoder(snapshot.value) ?? none;
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
