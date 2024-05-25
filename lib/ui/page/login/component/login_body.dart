import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';

class LoginBody extends StatelessWidget {
  final TextFieldController passwordController;
  final VoidCallback? onLogin;

  const LoginBody({
    super.key,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        ControlledTextField(
          hintText: 'Password',
          obscureText: true,
          controller: passwordController,
          onSubmitted: (final _) => onLogin?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Login',
          onPressed: onLogin,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
