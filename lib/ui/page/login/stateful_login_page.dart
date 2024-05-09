import 'package:flutter/material.dart';
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

  @override
  Widget build(final BuildContext context) {
    return LoginPage(
      passwordController: passwordController,
      onLogin: () async {
        try {
          await widget._adminAuthenticator.login(passwordController.text);
        } on ApiException catch (exception) {
          if (!context.mounted) return;
          final snackBar = SnackBar(content: Text(exception.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
