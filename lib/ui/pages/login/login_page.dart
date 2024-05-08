import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/pages/login/components/login_card.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: const LoginCard(),
            ),
          ],
        ),
      ),
    );
  }
}
