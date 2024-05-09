import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/ui/page/login/login_page.dart';

// This could probably be stateless but let's just make it stateful
// for consistency and in case we want to add actual state in the future
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
  final passwordController = TextEditingController();
  var oldText = '';
  var passwordIncorrect = false;
  var loading = false;

  void onLogin() async {
    setState(() => loading = true);
    try {
      await widget._adminAuthenticator.login(passwordController.text);
    } on IncorrectPasswordException {
      setState(() => passwordIncorrect = true);
    } on ApiException catch (exception) {
      if (!mounted) return;
      final snackBar = SnackBar(content: Text(exception.message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on ClientException {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Failed to connect to server'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() => loading = false);
  }

  @override
  void initState() {
    passwordController.addListener(() {
      if (oldText != passwordController.text) {
        setState(() => passwordIncorrect = false);
      }
      oldText = passwordController.text;
    });
    super.initState();
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
      passwordIncorrect: passwordIncorrect,
      loading: loading,
    );
  }
}
