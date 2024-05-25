import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/login/login_page.dart';

class StatefulLoginPage extends StatefulWidget {
  final AdminAuthenticator _adminAuthenticator;

  const StatefulLoginPage({
    super.key,
    required final AdminAuthenticator adminAuthenticator,
  }) : _adminAuthenticator = adminAuthenticator;

  @override
  State<StatefulLoginPage> createState() => _StatefulLoginPageState();
}

class _StatefulLoginPageState extends State<StatefulLoginPage> {
  final passwordController = TextFieldController();
  var loading = false;

  @override
  void initState() {
    navigateToCorrectPage();

    widget._adminAuthenticator.loading.listen((final loading) {
      if (!mounted) return;
      setState(() => this.loading = loading);
    });

    super.initState();
  }

  void navigateToCorrectPage() async {
    widget._adminAuthenticator.loggedIn.listen((final loggedIn) {
      if (loggedIn && mounted) {
        context.go('/home');
        passwordController.text = '';
      }
    });

    try {
      if (!await widget._adminAuthenticator.passwordSet && mounted) {
        context.go('/set-password');
      }
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (mounted) return;
      context.showSnackBar('Connection error');
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return LoginPage(
      passwordController: passwordController,
      onLogin: onLogin,
      loading: loading,
    );
  }

  void onLogin() async {
    try {
      if (!await widget._adminAuthenticator.passwordSet && mounted) {
        context.go('/set-password');
        return;
      }
      await widget._adminAuthenticator.login(passwordController.text);
    } on IncorrectPasswordException {
      setState(() => passwordController.error = 'Incorrect password');
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (!mounted) return;
      context.showSnackBar('Connection error');
    }
  }
}
