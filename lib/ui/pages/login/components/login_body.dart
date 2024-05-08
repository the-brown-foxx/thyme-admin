import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/components/button.dart';
import 'package:thyme_to_park_admin/ui/components/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(height: 24),
        const HerbHubTextField(
          hintText: 'Password',
          obscureText: true,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            HerbHubButton(
              text: 'Signup',
              onPressed: () {},
              type: ButtonType.outlined,
              roundedCorners: Edge.left,
              alignment: Alignment.centerRight,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: HerbHubButton(
                text: 'Login',
                onPressed: () {},
                roundedCorners: Edge.right,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
