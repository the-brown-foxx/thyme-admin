import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';

import 'component/change_password_card.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextFieldController oldPasswordController;
  final TextFieldController newPasswordController;
  final TextFieldController repeatPasswordController;
  final VoidCallback? onChangePassword;
  final VoidCallback? onCancel;
  final bool loading;

  const ChangePasswordPage({
    super.key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.repeatPasswordController,
    required this.onChangePassword,
    required this.onCancel,
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
                    onCancel: onCancel,
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
