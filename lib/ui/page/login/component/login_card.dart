import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/splash_image.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_body.dart';

class LoginCard extends StatelessWidget {
  final TextFieldController passwordController;
  final VoidCallback? onLogin;
  final bool loading;

  const LoginCard({
    super.key,
    required this.passwordController,
    required this.onLogin,
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
        ),
      ),
      rightChild: const SplashImage.landing(),
    );
  }
}
