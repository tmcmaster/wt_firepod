import 'package:flutter/material.dart';
import 'package:wt_firepod/src/auth/flutterfire_auth.dart';
import 'package:wt_firepod/src/auth/user_auth.dart';
import 'package:wt_firepod/src/auth/user_auth_result.dart';
import 'package:wt_logging/wt_logging.dart';

class EmailSignInForm extends StatefulWidget {
  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  const EmailSignInForm({
    super.key,
    required this.firebaseLogin,
    required this.landingRoute,
  });

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  static final log = logger(EmailSignInForm);

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Email Sign In'),
            onPressed: () {
              log.d('Logging in with email: ${emailController.text}');
              widget.firebaseLogin
                  .emailSignIn(emailController.text, passwordController.text)
                  .then((UserAuthResult auth) {
                log.d('Login completed : ${auth.success} : ${auth.user.name}');
                if (auth.user != UserAuth.none) {
                  log.d('Routing to the default page');
                  Navigator.of(context).pushReplacementNamed(widget.landingRoute);
                } else {
                  log.d('Authentication was not successful.');
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

// TODO: remove after testing
// class EmailSignInForm extends StatelessWidget {
//   static final log = logger(EmailSignInForm);
//
//   final FlutterfireAuthNotifier firebaseLogin;
//   final String landingRoute;
//
//   const EmailSignInForm({
//     super.key,
//     required this.firebaseLogin,
//     required this.landingRoute,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final emailController = useTextEditingController();
//     final passwordController = useTextEditingController();
//
//     return SizedBox(
//       width: 300,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//           ),
//           TextField(
//             controller: passwordController,
//             obscureText: true,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             child: const Text('Email Sign In'),
//             onPressed: () {
//               log.d('Logging in with email: ${emailController.text}');
//               firebaseLogin
//                   .emailSignIn(emailController.text, passwordController.text)
//                   .then((UserAuthResult auth) {
//                 log.d('Login completed : ${auth.success} : ${auth.user.name}');
//                 if (auth.user != UserAuth.none) {
//                   log.d('Routing to the default page');
//                   Navigator.of(context).pushReplacementNamed(landingRoute);
//                 } else {
//                   log.d('Authentication was not successful.');
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
