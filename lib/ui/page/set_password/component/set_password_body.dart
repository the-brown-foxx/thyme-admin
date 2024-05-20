import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class SetPasswordBody extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback? onSetPassword;
  final bool passwordTooShort;
  final bool passwordsDoNotMatch;
  final int? minPasswordLength;

  const SetPasswordBody({
    super.key,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.onSetPassword,
    required this.passwordTooShort,
    required this.passwordsDoNotMatch,
    this.minPasswordLength,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final passwordErrorText = passwordTooShort
        ? (minPasswordLength != null
        ? 'Password must be at least $minPasswordLength characters long'
        : 'Password is too short')
        : null;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Let's get you set up!",
          maxLines: 2,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Set your password. '
              'Make sure to make it hard to guess but easy to remember.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Password',
          obscureText: true,
          controller: passwordController,
          errorText: passwordErrorText,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onSetPassword?.call(),
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'Repeat password',
          obscureText: true,
          controller: repeatPasswordController,
          errorText: passwordsDoNotMatch ? "Passwords don't match" : null,
          roundedCorners: Edge.bottom,
          onSubmitted: (final _) => onSetPassword?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Set password',
          onPressed: onSetPassword,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
