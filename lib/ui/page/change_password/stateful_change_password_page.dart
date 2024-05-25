import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/change_password/change_password_page.dart';

class StatefulChangePasswordPage extends StatefulWidget {
  final AdminAuthenticator _adminAuthenticator;

  const StatefulChangePasswordPage({
    super.key,
    required final AdminAuthenticator adminAuthenticator,
  }) : _adminAuthenticator = adminAuthenticator;

  @override
  State<StatefulChangePasswordPage> createState() =>
      _StatefulChangePasswordPageState();
}

class _StatefulChangePasswordPageState
    extends State<StatefulChangePasswordPage> {
  final oldPasswordController = TextFieldController();
  final newPasswordController = TextFieldController();
  final repeatPasswordController = TextFieldController();
  var loading = false;

  @override
  void initState() {
    widget._adminAuthenticator.loading.listen((final loading) {
      if (!mounted) return;
      setState(() => this.loading = loading);
    });

    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return ChangePasswordPage(
      oldPasswordController: oldPasswordController,
      newPasswordController: newPasswordController,
      repeatPasswordController: repeatPasswordController,
      onChangePassword: onChangePassword,
      onCancel: onCancel,
      loading: loading,
    );
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  void onChangePassword() async {
    if (newPasswordController.text != repeatPasswordController.text) {
      repeatPasswordController.error = "Passwords don't match";
      return;
    }

    try {
      await widget._adminAuthenticator.changePassword(
        oldPassword: oldPasswordController.textEditingController.text,
        newPassword: newPasswordController.text,
      );
      if (!mounted) return;
      context.pop();
    } on IncorrectPasswordException {
      oldPasswordController.error = 'Incorrect old password';
    } on PasswordTooShortException catch (exception) {
      newPasswordController.error =
          'Password must be at least ${exception.minLength} characters long';
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (!mounted) return;
      context.showSnackBar('Connection error');
    }
  }
}
