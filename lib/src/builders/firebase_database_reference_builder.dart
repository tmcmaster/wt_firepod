import 'package:wt_firepod/src/firepod.dart';

class FirebaseDatabaseReferenceBuilder {
  static final provider = Provider(
    name: 'FirebaseDatabaseReferenceBuilder',
    (ref) => FirebaseDatabaseReferenceBuilder(ref),
  );

  final Ref ref;

  FirebaseDatabaseReferenceBuilder(this.ref);

  DatabaseReference? build(String path) {
    print('PATH: $path');

    final userRequired = path.contains('{user}');
    final siteRequired = path.contains('{site}');
    final userId = userRequired ? ref.read(FirebaseProviders.auth).currentUser?.uid : null;
    final siteId = siteRequired ? ref.read(FirepodSettings.site.value)?.id : null;

    if (userRequired && userId == null || siteRequired && siteId == null) {
      return null;
    }

    List<String> pathParts = splitPath(path, userId: userId, siteId: siteId);
    final database = ref.read(FirebaseProviders.database);
    DatabaseReference dbRef = database.ref();
    for (String part in pathParts) {
      dbRef = dbRef.child(part);
    }
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
        .map((String part) => part == '{user}'
            ? userId ?? ''
            : part == '{site}'
                ? siteId ?? ''
                : part)
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
