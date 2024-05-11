import 'package:flutter/material.dart';

import 'component/set_password_card.dart';

class SetPasswordPage extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback? onSetPassword;
  final bool passwordTooShort;
  final bool passwordsDoNotMatch;
  final bool loading;

  const SetPasswordPage({
    super.key,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.onSetPassword,
    required this.passwordTooShort,
    required this.passwordsDoNotMatch,
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
                    passwordTooShort: passwordTooShort,
                    passwordsDoNotMatch: passwordsDoNotMatch,
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
