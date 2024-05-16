import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/page/set_password/component/set_password_body.dart';
import 'package:thyme_to_park_admin/ui/page/set_password/component/set_password_image.dart';

class SetPasswordCard extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback? onSetPassword;
  final bool passwordTooShort;
  final bool passwordsDoNotMatch;
  final bool loading;

  const SetPasswordCard({
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
                  child: SetPasswordBody(
                    passwordController: passwordController,
                    repeatPasswordController: repeatPasswordController,
                    onSetPassword: !loading ? onSetPassword : null,
                    passwordTooShort: passwordTooShort,
                    passwordsDoNotMatch: passwordsDoNotMatch,
                  ),
                ),
              ),
              const Expanded(child: SetPasswordImage()),
            ],
          ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}
