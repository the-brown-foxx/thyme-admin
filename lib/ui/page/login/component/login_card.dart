import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_body.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_image.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController _passwordController;
  final VoidCallback _onLogin;

  const LoginCard({
    super.key,
    required final TextEditingController passwordController,
    required final VoidCallback onLogin,
  })  : _passwordController = passwordController,
        _onLogin = onLogin;

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
                passwordController: _passwordController,
                onLogin: _onLogin,
              ),
            ),
          ),
          const Expanded(child: LoginImage()),
        ],
      ),
    );
  }
}
