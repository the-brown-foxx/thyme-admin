import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/page/change_password/component/change_password_body.dart';
import 'package:thyme_to_park_admin/ui/page/change_password/component/change_password_image.dart';

class ChangePasswordCard extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback? onChangePassword;
  final bool passwordIncorrect;
  final bool passwordTooShort;
  final bool passwordsDoNotMatch;
  final bool loading;

  const ChangePasswordCard({
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
    return HerbHubCard(
      largeCornerRadius: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(64.0),
                  child: ChangePasswordBody(
                    oldPasswordController: oldPasswordController,
                    newPasswordController: newPasswordController,
                    repeatPasswordController: repeatPasswordController,
                    onChangePassword: !loading ? onChangePassword : null,
                    passwordIncorrect: passwordIncorrect,
                    passwordTooShort: passwordTooShort,
                    passwordsDoNotMatch: passwordsDoNotMatch,
                  ),
                ),
              ),
              const Expanded(child: ChangePasswordImage()),
            ],
          ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}
