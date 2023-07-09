import 'package:flutter_test/flutter_test.dart';
import 'package:wt_firepod/src/builders/firebase_database_reference_builder.dart';

void main() {
  const splitPath = FirebaseDatabaseReferenceBuilder.splitPath;
  const trimPath = FirebaseDatabaseReferenceBuilder.trimPath;

  group('FirebaseDatabaseReferenceBuilder tests', () {
    test('Testing splitPath', () {
      expect(splitPath('/a/b/c'), ['a', 'b', 'c'], reason: 'Slash at start');
      expect(splitPath('a/b/c'), ['a', 'b', 'c'], reason: 'No slash at start');
      expect(splitPath('a/{user}/b/c', userId: 'USER'), ['a', 'USER', 'b', 'c'],
          reason: 'User supplied',);
      expect(splitPath('a/{site}/b/c', siteId: 'SITE'), ['a', 'SITE', 'b', 'c'],
          reason: 'User supplied',);
      expect(splitPath('a/{site}/b/{user}/c', siteId: 'SITE', userId: 'USER'),
          ['a', 'SITE', 'b', 'USER', 'c'],
          reason: 'User supplied',);
      expect(splitPath('a/{user}/b/{user}/c', siteId: 'SITE', userId: 'USER'),
          ['a', 'USER', 'b', 'USER', 'c'],
          reason: 'Using User multiple times',);
      expect(() => splitPath('/a/b/{user}/c'), throwsA(isA<Exception>()),
          reason: 'User but not supplied',);
      expect(() => splitPath('/a/b/{site}/c'), throwsA(isA<Exception>()),
          reason: 'Site but not supplied',);
      expect(() => splitPath('/a/{user}/b/{site}/c'), throwsA(isA<Exception>()),
          reason: 'Site and User, but not supplied',);
    });
    test('Testing trimString', () {
      expect(trimPath('/a/b/c'), 'a/b/c', reason: 'Slash at start');
      expect(trimPath('a/b/c/'), 'a/b/c', reason: 'Slash at end');
      expect(trimPath('a/b/c'), 'a/b/c', reason: 'No slash at start');
      expect(trimPath('  a/b/c  '), 'a/b/c', reason: 'Whitespace around');
      expect(trimPath('  /a/b/c/  '), 'a/b/c', reason: 'Slashes and whitespace');
    });
  });
}
