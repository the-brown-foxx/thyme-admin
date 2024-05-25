import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/change_password/component/change_password_body.dart';
import 'package:thyme_to_park_admin/ui/page/change_password/component/change_password_image.dart';

class ChangePasswordCard extends StatelessWidget {
  final TextFieldController oldPasswordController;
  final TextFieldController newPasswordController;
  final TextFieldController repeatPasswordController;
  final VoidCallback? onChangePassword;
  final VoidCallback? onCancel;
  final bool loading;

  const ChangePasswordCard({
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
    return TwoPaneCard(
      loading: loading,
      leftChild: Padding(
        padding: const EdgeInsets.all(64.0),
        child: ChangePasswordBody(
          oldPasswordController: oldPasswordController,
          newPasswordController: newPasswordController,
          repeatPasswordController: repeatPasswordController,
          onChangePassword: !loading ? onChangePassword : null,
          onCancel: !loading ? onCancel : null,
        ),
      ),
      rightChild: const ChangePasswordImage(),
    );
  }
}
