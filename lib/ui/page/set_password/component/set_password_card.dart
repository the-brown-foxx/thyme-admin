import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/set_password/component/set_password_body.dart';
import 'package:thyme_to_park_admin/ui/page/set_password/component/set_password_image.dart';

class SetPasswordCard extends StatelessWidget {
  final TextFieldController passwordController;
  final TextFieldController repeatPasswordController;
  final VoidCallback? onSetPassword;
  final bool loading;

  const SetPasswordCard({
    super.key,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.onSetPassword,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return TwoPaneCard(
      loading: loading,
      leftChild: Padding(
        padding: const EdgeInsets.all(64.0),
        child: SetPasswordBody(
          passwordController: passwordController,
          repeatPasswordController: repeatPasswordController,
          onSetPassword: !loading ? onSetPassword : null,
        ),
      ),
      rightChild: const SetPasswordImage(),
    );
  }
}
