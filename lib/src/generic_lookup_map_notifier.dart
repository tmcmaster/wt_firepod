import 'dart:async';

import 'package:wt_models/wt_models.dart';

import 'firepod.dart';
import 'utils/logging.dart';

class GenericSiteDataNotifier<T> extends StateNotifier<T> {
  static final log = logger(GenericSiteDataNotifier, level: Level.debug);

  late ProviderSubscription _removeListener;
  StreamSubscription<DatabaseEvent>? _subscription;

  final String prefixPath;
  final String? suffixPath;
  final T none;
  final T? Function(Object? json) decoder;
  final bool watch;
  GenericSiteDataNotifier({
    required Ref ref,
    required this.none,
    required this.prefixPath,
    this.suffixPath,
    required this.decoder,
    this.watch = false,
  }) : super(none) {
    final site = ref.read(FirepodSettings.site.value);
    _readFromDatabase(ref, site);
    log.d('Listening to ${FirepodSettings.site.value.name} for changes.');
    _removeListener = ref.listen<IdSupport?>(FirepodSettings.site.value, (oldSite, newSite) {
      log.d('${FirepodSettings.site.value} has changed');
      _readFromDatabase(ref, newSite);
    }, onError: (error, _) {});
  }

  void _readFromDatabase(Ref ref, IdSupport? site) {
    if (site != null) {
      final siteId = site.getId();
      final database = ref.read(FirebaseProviders.database);

      final dbRef = suffixPath == null
          ? database.ref(prefixPath).child(siteId)
          : database.ref(prefixPath).child(siteId).child(suffixPath!);

      log.d('PrefixPath($prefixPath), SiteId($siteId), SuffixPath($suffixPath)');

      if (watch) {
        if (_subscription != null) {
          _subscription!.cancel();
        }
        _subscription = dbRef.onChildChanged.listen((event) {
          _refreshState(dbRef, site);
        }, onError: (error) => log.e(error));
      }
      _refreshState(dbRef, site);
    } else {
      log.w('There was no site selected.');
      state = none;
    }
  }

  void _refreshState(DatabaseReference dbRef, IdSupport site) {
    dbRef.get().then((snapshot) {
      if (snapshot.exists) {
        state = decoder(snapshot.value) ?? none;
        log.d('Updated site data for ${site.getId()}');
      } else {
        log.w(
            'Could not find the required site data for Site(${site.getId()}) Prefix($prefixPath)');
        state = none;
      }
    }, onError: (error) => log.e(error));
  }

  @override
  void dispose() {
    _removeListener.close();
    super.dispose();
  }
}
