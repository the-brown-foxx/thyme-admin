import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/api/actual_api.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/actual_admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/token/printing_dummy_token_storage.dart';
import 'package:thyme_to_park_admin/service/token/token_storage.dart';
import 'package:thyme_to_park_admin/ui/page/home/home_screen.dart';
import 'package:thyme_to_park_admin/ui/page/login/stateful_login_page.dart';
import 'package:thyme_to_park_admin/ui/theme/color_schemes.dart';
import 'package:thyme_to_park_admin/ui/theme/text_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Api api = ActualApi();

  // TODO: Make this the actual one
  final TokenStorage tokenStorage = PrintingDummyTokenStorage();
  late final AdminAuthenticator adminAuthenticator = ActualAdminAuthenticator(
    api: api,
    tokenStorage: tokenStorage,
  );

  MyApp({super.key});

  late final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (final context, final state) =>
          StatefulLoginPage(adminAuthenticator: adminAuthenticator),
      routes: [
        GoRoute(
            path: 'home',
            builder: (final context, final state) => const HomeScreen()),
      ],
    ),
  ]);

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: textTheme,
      ),
      routerConfig: router,
    );
  }
}
