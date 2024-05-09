import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';

class LoginBody extends StatelessWidget {
  final TextEditingController _passwordController;
  final VoidCallback _onLogin;

  const LoginBody({
    super.key,
    required final TextEditingController passwordController,
    required final VoidCallback onLogin,
  })  : _passwordController = passwordController,
        _onLogin = onLogin;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 32),
        Text(
          'Thyme',
          style: theme.textTheme.displayLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Admin',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Password',
          obscureText: true,
          controller: _passwordController,
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Login',
          onPressed: _onLogin,
          alignment: Alignment.center,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
