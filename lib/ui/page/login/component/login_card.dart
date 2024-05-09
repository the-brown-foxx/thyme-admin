import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_body.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_image.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool passwordIncorrect;

  const LoginCard({
    super.key,
    required this.passwordController,
    required this.onLogin,
    required this.passwordIncorrect,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Card.outlined(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.onSurface,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(32.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: LoginBody(
                passwordController: passwordController,
                onLogin: onLogin,
                passwordIncorrect: passwordIncorrect,
              ),
            ),
          ),
          const Expanded(child: LoginImage()),
        ],
      ),
    );
  }
}
