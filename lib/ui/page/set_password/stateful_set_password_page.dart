import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/set_password/set_password_page.dart';

// This could probably be stateless but let's just make it stateful
// for consistency and in case we want to add actual state in the future
class StatefulSetPasswordPage extends StatefulWidget {
  final AdminAuthenticator _adminAuthenticator;

  const StatefulSetPasswordPage({
    super.key,
    required final AdminAuthenticator adminAuthenticator,
  }) : _adminAuthenticator = adminAuthenticator;

  @override
  State<StatefulSetPasswordPage> createState() =>
      _StatefulSetPasswordPageState();
}

class _StatefulSetPasswordPageState extends State<StatefulSetPasswordPage> {
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  var oldPassword = '';
  var oldRepeatPassword = '';
  var passwordTooShort = false;
  var passwordsDoNotMatch = false;
  int? minPasswordLength;
  var loading = false;

  void onSetPassword() async {
    setState(() => loading = true);
    await setPassword();
    setState(() => loading = false);
  }
  
  Future<void> setPassword() async {
    if (passwordController.text != repeatPasswordController.text) {
      setState(() => passwordsDoNotMatch = true);
      return;
    }
    
    try {
      await widget._adminAuthenticator
          .changePassword(newPassword: passwordController.text);
      if (!mounted) return;
      context.pop();
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

  @override
  void initState() {
    passwordController.addListener(() {
      if (oldPassword != passwordController.text) {
        setState(() {
          passwordTooShort = false;
          passwordsDoNotMatch = false;
        });
      }
      oldPassword = passwordController.text;
    });
    repeatPasswordController.addListener(() {
      if (oldRepeatPassword != repeatPasswordController.text) {
        setState(() {
          passwordsDoNotMatch = false;
        });
      }
      oldRepeatPassword = repeatPasswordController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return SetPasswordPage(
      passwordController: passwordController,
      repeatPasswordController: repeatPasswordController,
      onSetPassword: onSetPassword,
      passwordTooShort: passwordTooShort,
      passwordsDoNotMatch: passwordsDoNotMatch,
      loading: loading,
    );
  }
}
