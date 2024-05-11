import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';

class LoginBody extends StatelessWidget {
  final TextEditingController passwordController;
  final VoidCallback? onLogin;
  final bool passwordIncorrect;

  const LoginBody({
    super.key,
    required this.passwordController,
    required this.onLogin,
    required this.passwordIncorrect,
  });

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
          maxLines: 1,
          style: theme.textTheme.displayLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Admin',
          maxLines: 1,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Password',
          obscureText: true,
          controller: passwordController,
          errorText: passwordIncorrect ? 'Incorrect password' : null,
          onSubmitted: (final _) => onLogin?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Login',
          onPressed: onLogin,
          alignment: Alignment.center,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
