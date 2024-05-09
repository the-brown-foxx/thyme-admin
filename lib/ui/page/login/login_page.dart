import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_card.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool passwordIncorrect;

  const LoginPage({
    super.key,
    required this.passwordController,
    required this.onLogin,
    required this.passwordIncorrect,

  });

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: LoginCard(
                passwordController: passwordController,
                onLogin: onLogin,
                passwordIncorrect: passwordIncorrect,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
