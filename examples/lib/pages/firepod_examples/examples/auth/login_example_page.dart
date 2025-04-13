import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

class LoginExamplePage extends ConsumerStatefulWidget {
  const LoginExamplePage({super.key});

  @override
  ConsumerState<LoginExamplePage> createState() => _LoginExamplePageState();
}

class _LoginExamplePageState extends ConsumerState<LoginExamplePage> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.read(FirebaseProviders.auth);
    final firebaseLogin = ref.read(FirebaseProviders.authNotifier);

    return SizedBox(
      height: 200,
      child: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }

          final user = snapshot.data;

          return user == null
              ? Scaffold(
                  body: Center(
                    child: GoogleSignInForm(
                      firebaseLogin: firebaseLogin,
                      landingRoute: '/',
                    ),
                  ),
                )
              : Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Email: ${user.email ?? "Unknown"}'),
                        Text('Name: ${user.displayName ?? "Unknown"}'),
                        Text('ID: ${user.uid}'),
                        ElevatedButton(
                          onPressed: () async {
                            await auth.signOut();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
