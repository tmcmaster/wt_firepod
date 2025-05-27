import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/src/auth_gateway/firepod_login_screen.dart';
import 'package:wt_firepod/src/providers/firebase_providers.dart';

class AuthGate extends ConsumerWidget {
  final Widget child;

  const AuthGate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(FirebaseProviders.auth);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuthGate Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: Colors.purple)),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              if (user != null) {
                return child;
              }
            }
            return const FirepodLoginScreen();
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: Colors.grey)),
            );
          }
        },
      ),
    );
  }
}
