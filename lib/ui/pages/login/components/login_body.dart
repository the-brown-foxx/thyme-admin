import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/components/button.dart';
import 'package:thyme_to_park_admin/ui/components/text_field.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

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
        const HerbHubTextField(
          hintText: 'Password',
          obscureText: true,
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Login',
          onPressed: () {},
          alignment: Alignment.center,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
