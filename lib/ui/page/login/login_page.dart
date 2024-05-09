import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_card.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _passwordController;
  final VoidCallback _onLogin;

  const LoginPage({
    super.key,
    required final TextEditingController passwordController,
    required final VoidCallback onLogin,
  })  : _passwordController = passwordController,
        _onLogin = onLogin;

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
                passwordController: _passwordController,
                onLogin: _onLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
