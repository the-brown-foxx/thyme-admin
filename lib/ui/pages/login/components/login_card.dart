import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/pages/login/components/login_body.dart';
import 'package:thyme_to_park_admin/ui/pages/login/components/login_image.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

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
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(64.0),
              child: LoginBody(),
            ),
          ),
          Expanded(
            child: LoginImage(),
          ),
        ],
      ),
    );
  }
}
