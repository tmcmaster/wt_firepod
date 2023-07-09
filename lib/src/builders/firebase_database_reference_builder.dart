import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class FirebaseDatabaseReferenceBuilder {
  static final log = logger(FirebaseDatabaseReferenceBuilder, level: Level.warning);
  static final provider = Provider(
    name: 'FirebaseDatabaseReferenceBuilder',
    (ref) => FirebaseDatabaseReferenceBuilder(ref),
  );

  final Ref ref;

  FirebaseDatabaseReferenceBuilder(this.ref);

  DatabaseReference? build(String path) {
    final userRequired = path.contains('{user}');
    final siteRequired = path.contains('{site}');
    final userId = userRequired ? ref.read(FirebaseProviders.auth).currentUser?.uid : null;
    final siteId = siteRequired ? ref.read(FirepodSettings.site.value)?.id : null;

    if (userRequired && userId == null || siteRequired && siteId == null) {
      return null;
    }

    final pathParts = splitPath(path, userId: userId, siteId: siteId);
    log.d('Path Parts: $pathParts');

    final database = ref.read(FirebaseProviders.database);
    DatabaseReference dbRef = database.ref();
    for (final String part in pathParts) {
      dbRef = dbRef.child(part);
    }
    log.d('Path: ${dbRef.path}');

    return dbRef;
  }

  static List<String> splitPath(String path, {String? userId, String? siteId}) {
    if (userId == null && path.contains('{user}')) {
      throw Exception('Path contains a user, but no user has been supplied: $path');
    }
    if (siteId == null && path.contains('{site}')) {
      throw Exception('Path contains a site, but no site use has been supplied: $path');
    }
    if (path.contains('//')) {
      throw Exception('Path should not container //: $path');
    }
    return trimPath(path)
        .split('/')
        .map(
          (String part) => part == '{user}'
              ? userId ?? ''
              : part == '{site}'
                  ? siteId ?? ''
                  : part,
        )
        .toList();
  }

  static String trimPath(String path) {
    String trimmedString = path.trim();
    if (trimmedString.startsWith('/')) {
      trimmedString = trimmedString.substring(1);
    }
    if (trimmedString.endsWith('/')) {
      trimmedString = trimmedString.substring(0, trimmedString.length - 1);
    }
    return trimmedString;
  }
}
