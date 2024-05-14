import 'package:flutter/material.dart';

import 'component/change_password_card.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback? onChangePassword;
  final bool passwordIncorrect;
  final bool passwordTooShort;
  final bool passwordsDoNotMatch;
  final bool loading;

  const ChangePasswordPage({
    super.key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.repeatPasswordController,
    required this.onChangePassword,
    required this.passwordIncorrect,
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
                  child: ChangePasswordCard(
                    oldPasswordController: oldPasswordController,
                    newPasswordController: newPasswordController,
                    repeatPasswordController: repeatPasswordController,
                    onChangePassword: onChangePassword,
                    passwordIncorrect: passwordIncorrect,
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
