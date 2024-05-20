import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class ChangePasswordBody extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback? onChangePassword;
  final VoidCallback? onCancel;
  final bool passwordIncorrect;
  final bool passwordTooShort;
  final bool passwordsDoNotMatch;
  final int? minPasswordLength;

  const ChangePasswordBody({
    super.key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.repeatPasswordController,
    required this.onChangePassword,
    required this.onCancel,
    required this.passwordIncorrect,
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
          "Let's change your password!",
          maxLines: 2,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Change your password. '
          'Make sure to make it hard to guess but easy to remember.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Old password',
          obscureText: true,
          controller: oldPasswordController,
          errorText: passwordIncorrect ? 'Incorrect old password.' : null,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onChangePassword?.call(),
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'New password',
          obscureText: true,
          controller: newPasswordController,
          errorText: passwordErrorText,
          roundedCorners: const {},
          onSubmitted: (final _) => onChangePassword?.call(),
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'Repeat password',
          obscureText: true,
          controller: repeatPasswordController,
          errorText: passwordsDoNotMatch ? "Passwords don't match" : null,
          roundedCorners: Edge.bottom,
          onSubmitted: (final _) => onChangePassword?.call(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            HerbHubButton(
              text: 'Cancel',
              onPressed: onCancel,
              roundedCorners:
                  Edge.left,
              type: ButtonType
                  .outlined,
              alignment: Alignment.centerRight,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: HerbHubButton(
                text: 'Change password',
                onPressed: onChangePassword,
                roundedCorners: Edge.right,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
