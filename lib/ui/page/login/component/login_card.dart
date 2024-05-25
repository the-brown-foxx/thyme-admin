import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_body.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_image.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController passwordController;
  final VoidCallback? onLogin;
  final bool passwordIncorrect;
  final bool loading;

  const LoginCard({
    super.key,
    required this.passwordController,
    required this.onLogin,
    required this.passwordIncorrect,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return TwoPaneCard(
      loading: loading,
      leftChild: Padding(
        padding: const EdgeInsets.all(64.0),
        child: LoginBody(
          passwordController: passwordController,
          onLogin: !loading ? onLogin : null,
          passwordIncorrect: passwordIncorrect,
        ),
      ),
      rightChild: const LoginImage(),
    );
  }
}
