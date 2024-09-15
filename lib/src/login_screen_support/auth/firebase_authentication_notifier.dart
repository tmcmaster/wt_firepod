import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_interface.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_user.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class FirebaseAuthenticationNotifier extends AppScaffoldAuthenticationInterface {
  static final log = logger(
    FirebaseAuthenticationNotifier,
    level: Level.debug,
  );

  final Ref ref;
  FirebaseAuthenticationNotifier(this.ref)
      : super(
          AppScaffoldUser.empty(),
        ) {
    final subscription = ref.read(FirebaseProviders.auth).userChanges().listen(
      (user) {
        transformUser(user).then((appScaffoldUser) => state = appScaffoldUser);
      },
    );

    ref.onDispose(() {
      subscription.cancel();
    });
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    log.d('Signing in user');
    await ref
        .read(FirebaseProviders.auth)
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    log.d('Signing out user');
    await ref.read(FirebaseProviders.auth).signOut();
  }

  @override
  Future<void> passwordReset() {
    // TODO: implement passwordReset
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? account = await GoogleSignIn(
      clientId: '626479055094-qih6hfrg4cppf316rru2i7orreprbh7h.apps.googleusercontent.com',
    ).signIn();

    if (account != null) {
      final GoogleSignInAuthentication authentication = await account.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      final userCredentials =
          await ref.read(FirebaseProviders.auth).signInWithCredential(credential);

      log.d('User: ${userCredentials.user}');
    }
  }

  Future<AppScaffoldUser> transformUser(User? user) async {
    if (user == null) {
      return AppScaffoldUser.empty();
    } else {
      final userId = user.uid;
      final userDetailsSnapshot =
          await ref.read(FirebaseProviders.database).ref('/v2/users').child(userId).get();
      final jsonMap = userDetailsSnapshot.value as Map?;
      final firstName = (jsonMap?['firstName'] ?? '') as String;
      final lastName = (jsonMap?['lastName'] ?? '') as String;
      return AppScaffoldUser(
        id: user.uid,
        firstName: firstName,
        lastName: lastName,
        email: user.email ?? '',
        authenticated: true,
      );
    }
  }
}
