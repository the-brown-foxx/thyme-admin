import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
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
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  var oldPassword = '';
  var newPassword = '';
  var repeatPassword = '';
  var passwordIncorrect = false;
  var passwordTooShort = false;
  var passwordsDoNotMatch = false;
  int? minPasswordLength;
  var loading = false;

  @override
  void initState() {
    widget._adminAuthenticator.loading.listen((final loading) {
      setState(() => this.loading = loading);
    });

    oldPasswordController.addListener(() {
      if (oldPassword != oldPasswordController.text && mounted) {
        setState(() => passwordIncorrect = false);
      }
      oldPassword = oldPasswordController.text;
    });

    newPasswordController.addListener(() {
      if (newPassword != newPasswordController.text && mounted) {
        setState(() {
          passwordTooShort = false;
          passwordsDoNotMatch = false;
        });
      }
      newPassword = newPasswordController.text;
    });

    repeatPasswordController.addListener(() {
      if (repeatPassword != repeatPasswordController.text && mounted) {
        setState(() {
          passwordsDoNotMatch = false;
        });
      }
      repeatPassword = repeatPasswordController.text;
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
      passwordIncorrect: passwordIncorrect,
      passwordTooShort: passwordTooShort,
      passwordsDoNotMatch: passwordsDoNotMatch,
      loading: loading,
    );
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  void onChangePassword() async {
    if (newPasswordController.text != repeatPasswordController.text) {
      setState(() => passwordsDoNotMatch = true);
      return;
    }

    try {
      await widget._adminAuthenticator.changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      );
      if (!mounted) return;
      context.pop();
    } on IncorrectPasswordException {
      setState(() => passwordIncorrect = true);
    } on PasswordTooShortException catch (exception) {
      setState(() {
        minPasswordLength = exception.minLength;
        passwordTooShort = true;
      });
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (!mounted) return;
      context.showSnackBar('Connection error');
    }
  }
}
