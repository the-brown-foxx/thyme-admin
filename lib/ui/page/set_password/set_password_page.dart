import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';

import 'component/set_password_card.dart';

class SetPasswordPage extends StatelessWidget {
  final TextFieldController passwordController;
  final TextFieldController repeatPasswordController;
  final VoidCallback? onSetPassword;
  final bool loading;

  const SetPasswordPage({
    super.key,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.onSetPassword,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: SetPasswordCard(
                    passwordController: passwordController,
                    repeatPasswordController: repeatPasswordController,
                    onSetPassword: onSetPassword,
                    loading: loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
