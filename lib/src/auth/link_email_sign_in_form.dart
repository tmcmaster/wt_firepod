import 'package:flutter/material.dart';
import 'package:wt_firepod/src/auth/auth.dart';
import 'package:wt_logging/wt_logging.dart';

class LinkEmailSignInForm extends StatefulWidget {
  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  const LinkEmailSignInForm({
    super.key,
    required this.firebaseLogin,
    required this.landingRoute,
  });

  @override
  State<LinkEmailSignInForm> createState() => _LinkEmailSignInFormState();
}

class _LinkEmailSignInFormState extends State<LinkEmailSignInForm> {
  static final log = logger(LinkEmailSignInForm);

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
            child: const Text('Link Email Sign In'),
            onPressed: () {
              log.d('Linking email sign in with logged in account: ${emailController.text}');
              widget.firebaseLogin
                  .linkEmailSignIn(emailController.text, passwordController.text)
                  .then((UserAuthResult auth) {
                log.d('Login completed : ${auth.success} : ${auth.user.name}');
                if (auth.user != UserAuth.none) {
                  log.d('Linking email sign in was successful. Routing to the default page.');
                  Navigator.of(context).pushReplacementNamed(widget.landingRoute);
                } else {
                  log.d('Linking email sign in was not successful.');
                }
              });
            },
          ),
          ElevatedButton(
            child: const Text('Unlink Email Sign In'),
            onPressed: () {
              log.d('Unlinking email sign in with logged in account: ${emailController.text}');
              widget.firebaseLogin
                  .unlinkEmailSignIn(emailController.text, passwordController.text)
                  .then((UserAuthResult auth) {
                log.d('Login completed : ${auth.success} : ${auth.user.name}');
                if (auth.user != UserAuth.none) {
                  log.d('Unlinking email sign in was successful. Routing to the default page.');
                  Navigator.of(context).pushReplacementNamed(widget.landingRoute);
                } else {
                  log.d('Unlinking email sign in was not successful.');
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
