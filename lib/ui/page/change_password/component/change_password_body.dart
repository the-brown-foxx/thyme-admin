import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class ChangePasswordBody extends StatelessWidget {
  final TextFieldController oldPasswordController;
  final TextFieldController newPasswordController;
  final TextFieldController repeatPasswordController;
  final VoidCallback? onChangePassword;
  final VoidCallback? onCancel;

  const ChangePasswordBody({
    super.key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.repeatPasswordController,
    required this.onChangePassword,
    required this.onCancel,
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
        ControlledTextField(
          controller: oldPasswordController,
          hintText: 'Old password',
          obscureText: true,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onChangePassword?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          hintText: 'New password',
          obscureText: true,
          controller: newPasswordController,
          roundedCorners: const {},
          onSubmitted: (final _) => onChangePassword?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          hintText: 'Repeat password',
          obscureText: true,
          controller: repeatPasswordController,
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
