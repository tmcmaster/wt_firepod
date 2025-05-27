import 'dart:async';
import 'dart:convert';
import 'dart:math';

// import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wt_firepod/src/auth/user_auth.dart';
import 'package:wt_firepod/src/auth/user_auth_result.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class FlutterfireAuthNotifier extends StateNotifier<UserAuth> {
  static final log = logger(FlutterfireAuthNotifier);

  static const linkEmailSignInEnabled = true;

  final Ref ref;
  late StreamSubscription _streamListener;
  late FirebaseAuth firebaseAuth;

  late GoogleSignIn _googleSignIn;

  FlutterfireAuthNotifier(this.ref) : super(UserAuth.none) {
    firebaseAuth = ref.read(FirebaseProviders.auth);

    _streamListener =
        firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        log.d('User signed out');
        state = UserAuth.none;
      } else {
        log.d('User signed in: ${user.displayName}');
        // TODO: we need to check if the UID authorized in the database.
        // TODO: need to add firebase database support to this package (need to pass in which databaseProvider to use).
        // TODO: need to sort out how to userAuthProvider know about the database provider (maybe need to use family??).
        // TODO: might need to make this package a firebase package that has database and auth features.
        state = UserAuth(
          uuid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
      }
    });

    final firebaseOptions = ref.read(FirebaseProviders.firebaseOptions);
    _googleSignIn = GoogleSignIn(
      clientId:
          kIsWeb ? firebaseOptions.appId : firebaseOptions.androidClientId,
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  void dispose() {
    _streamListener.cancel();
    super.dispose();
  }

  // Future<void> getUserProfile() async {
  //   final callable = FirebaseFunctions.instance.httpsCallable('userProfile');
  //   final results = await callable();
  //   log.d(results.toString());
  // }

  Future<void> logout() {
    final userLog = ref.read(UserLog.provider);
    _googleSignIn.disconnect();
    return firebaseAuth.signOut().then(
      (_) {
        log.i('User has logged out successfully');
        userLog.info('User has logged out successfully');
      },
      onError: (error) {
        log.i('Logout error: $error');
        userLog.error('Logout error: $error');
      },
    );
  }

  Future<UserAuthResult> emailSignIn(String email, String password) {
    log.d('emailSignIn');
    return _waitForCredentials(
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password),
    );
  }

  Future<UserAuthResult> linkEmailSignIn(String email, String password) {
    if (!linkEmailSignInEnabled) {
      throw Exception('Linking email sign in support is disabled');
    }

    final completer = Completer<UserAuthResult>();

    if (firebaseAuth.currentUser == null) {
      completer.completeError('User is not currently logging in.');
    } else {
      try {
        final credentials =
            EmailAuthProvider.credential(email: email, password: password);
        log.d('Email Provider ID: ${credentials.providerId}');
        firebaseAuth.currentUser
            ?.linkWithCredential(credentials)
            .then((credentials) {
          final user = credentials.user;
          if (user != null) {
            completer.complete(
              UserAuthResult.success(
                UserAuth(
                  uuid: user.uid,
                  name: user.displayName ?? '',
                  email: user.email ?? '',
                ),
              ),
            );
          } else {
            completer.completeError('Could not create a linked email login');
          }
        }).onError((error, stackTrace) {
          final errorString = error.toString();
          log.d('(2) _handleCredentialsFuture errorString: $errorString');
          completer.completeError(errorString);
        });
      } catch (error) {
        final errorString = error.toString();
        log.d('(3) _handleCredentialsFuture errorString: $errorString');
        completer.completeError(errorString);
      }
    }

    return completer.future;
  }

  Future<UserAuthResult> unlinkEmailSignIn(String email, String password) {
    if (!linkEmailSignInEnabled) {
      throw Exception('Linking email sign in support is disabled');
    }
    final completer = Completer<UserAuthResult>();

    if (firebaseAuth.currentUser == null) {
      completer.completeError('User is not currently logging in.');
    } else {
      try {
        final credentials =
            EmailAuthProvider.credential(email: email, password: password);
        log.d('Email Provider ID: ${credentials.providerId}');
        completer.completeError('WIP');
        firebaseAuth.currentUser?.unlink(credentials.providerId).then(
              (value) => log.d(value),
              onError: (error, stackTrace) => log.e(error),
            );
      } catch (error) {
        final errorString = error.toString();
        log.d('(3) _handleCredentialsFuture errorString: $errorString');
        completer.completeError(errorString);
      }
    }

    return completer.future;
  }

  Future<UserAuthResult> createUser(String email, String password) {
    log.d('createUser');
    return _waitForCredentials(
      firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<UserAuthResult> resetPassword(String email) {
    final completer = Completer<UserAuthResult>();

    log.d('resetPassword');
    firebaseAuth.sendPasswordResetEmail(email: email).then((result) {
      log.d('resetPassword : success');
      completer.complete(UserAuthResult.success(UserAuth.none));
    }).catchError((error, stacktrace) {
      log.d('resetPassword : error : $error');
      completer.complete(UserAuthResult.error(error.toString()));
    });

    return completer.future;
  }

  Future<UserAuthResult> anonymousSignIn() {
    log.d('anonymousSignIn');
    return _waitForCredentials(firebaseAuth.signInAnonymously());
  }

  Future<UserAuthResult> googleSignIn() {
    log.d('googleSignIn');
    final completer = Completer<UserAuthResult>();

    final clientId = ref.read(FirebaseProviders.firebaseOptions).iosClientId;

    GoogleSignIn(
      clientId: clientId,
    ).signIn().then((GoogleSignInAccount? account) {
      if (account != null) {
        account.authentication.then((authentication) {
          final credential = GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken,
          );
          firebaseAuth.signInWithCredential(credential).then((userCredentials) {
            log.d('Login Value: $userCredentials');
            final user = UserAuthResult.success(UserAuth(
              email: userCredentials.user?.email ?? '',
              uuid: userCredentials.user?.uid ?? '',
              name: userCredentials.user?.displayName ?? '',
            ));
            completer.complete(user);
          }).catchError((error) {
            log.e('Login Error: $error');
            completer.completeError(error.toString());
          });
        }).catchError((error) {
          log.e('Login Error: $error');
          completer.completeError(error.toString());
        });
      }
    }).catchError((error) {
      log.e('Login Error: $error');
      completer.completeError(error.toString());
    });

    // _createGoogleCredentials().then(
    //   (credentials) {
    //     _waitForCredentials(firebaseAuth.signInWithCredential(credentials))
    //         .then(
    //       (userAuthResults) {
    //         log.d('googleSignIn : success : ${userAuthResults.user.email}');
    //         completer.complete(userAuthResults);
    //       },
    //       onError: (error) {
    //         log.d(
    //           'googleSignIn : error : Could not get UserAuthResults: $error',
    //         );
    //         completer.completeError('Could not get UserAuthResults: $error');
    //       },
    //     );
    //   },
    //   onError: (error) {
    //     log.d(
    //       'googleSignIn : error : Could not get Google credentials: $error',
    //     );
    //     completer.completeError('Could not get Google credentials: $error');
    //   },
    // );

    return completer.future;
  }

  Future<UserAuthResult> appleSignIn() {
    log.d('appleSignIn');
    final completer = Completer<UserAuthResult>();

    _createAppleCredentials().then((oAuthCredential) {
      _waitForCredentials(firebaseAuth.signInWithCredential(oAuthCredential))
          .then((userAuthResults) {
        completer.complete(userAuthResults);
      }).catchError((error) {
        completer.completeError('Could not get the UserAuthResults: $error');
      });
    }).catchError((error) {
      completer.completeError('Could not get the Apple credentials: $error');
    });

    return completer.future;
  }

  Future<UserAuthResult> phoneSignIn(String mobileNumber) {
    final completer = Completer<UserAuthResult>();

    log.d('phoneSignIn: mobile number: $mobileNumber');
    firebaseAuth.signInWithPhoneNumber(mobileNumber).then((confirmationResult) {
      completer.complete(UserAuthResult.confirmation(confirmationResult));
    }).onError((error, stackTrace) {
      completer.complete(UserAuthResult.error(error.toString()));
    });

    return completer.future;
  }

  Future<UserAuthResult> verifyPhoneNumber(
    ConfirmationResult confirmationResult,
    String verificationCode,
  ) {
    return _waitForCredentials(confirmationResult.confirm(verificationCode));
  }

  Future<OAuthCredential> _createAppleCredentials() {
    final completer = Completer<OAuthCredential>();

    log.d('_createAppleCredentials');
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    final rawNonce =
        List.generate(32, (_) => charset[random.nextInt(charset.length)])
            .join();
    final bytes = utf8.encode(rawNonce);
    final digest = sha256.convert(bytes);
    final nonce = digest.toString();
    SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    ).then((appleCredential) {
      final oAuthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      completer.complete(oAuthCredential);
    }).catchError((error) {
      completer.completeError('Could mot get Apple ID credentials.');
    });

    return completer.future;
  }

  Future<OAuthCredential> _createGoogleCredentials() {
    final completer = Completer<OAuthCredential>();

    log.d('_createGoogleCredentials');
    // GoogleSignIn().signIn().then((googleUser) {
    _googleSignIn.signIn().then(
      (googleUser) {
        if (googleUser == null) {
          completer.completeError('User is not logged into Google.');
        } else {
          googleUser.authentication.then((googleAuth) {
            final oAuthCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            completer.complete(oAuthCredential);
          }).catchError((error) {
            completer.completeError('Could not get googleAuth: $error');
          });
        }
      },
      onError: (error) {
        completer.completeError('Could not sign in user: $error');
      },
    );

    return completer.future;
  }

  Future<UserAuthResult> _waitForCredentials(
    Future<UserCredential> credentialFuture,
  ) {
    final completer = Completer<UserAuthResult>();
    log.d('_handleCredentialsFuture: Handling credentials....');
    try {
      credentialFuture.then((credentials) {
        final userAuthResult = _processCredentials(credentials);
        log.d(
          '(1) _handleCredentialsFuture successString: ${userAuthResult.user.email}',
        );
        completer.complete(userAuthResult);
      }).onError((error, stackTrace) {
        final errorString = error.toString();
        log.d('(2) _handleCredentialsFuture errorString: $errorString');
        log.d('(2) _handleCredentialsFuture errorString: $error');
        completer.completeError(errorString);
      });
    } catch (error) {
      final errorString = error.toString();
      log.d('(3) _handleCredentialsFuture errorString: $errorString');
      completer.completeError(errorString);
    }
    return completer.future;
  }

  UserAuthResult _processCredentials(UserCredential credentials) {
    log.d('_handleCredentials: $credentials');

    try {
      final user = credentials.user;
      if (user == null) {
        return UserAuthResult.error('Credentials did not contain a user.');
      }

      log.d('New user has been created: $user');

      final userAuth = UserAuth(
        uuid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
      state = userAuth;

      log.d('user has been updated: $user');

      return UserAuthResult.success(userAuth);
    } catch (error) {
      return UserAuthResult.error(error.toString());
    }
  }
}
