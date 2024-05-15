import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/api/actual_api.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/actual_admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/model/printing_dummy_token_storage.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';
import 'package:thyme_to_park_admin/service/registry/actual_car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/ui/page/home/stateful_home_screen.dart';
import 'package:thyme_to_park_admin/ui/page/login/stateful_login_page.dart';
import 'package:thyme_to_park_admin/ui/page/set_password/stateful_set_password_page.dart';
import 'package:thyme_to_park_admin/ui/theme/color_schemes.dart';
import 'package:thyme_to_park_admin/ui/theme/text_theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    // Must add this line.
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      minimumSize: Size(800, 400),
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

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
  late final CarRegistry carRegistry = ActualCarRegistry(
    api: api,
    tokenStorage: tokenStorage,
  );

  MyApp({super.key});

  late final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (final context, final state) =>
            StatefulLoginPage(adminAuthenticator: adminAuthenticator),
        routes: [
          GoRoute(
            path: 'set-password',
            builder: (final context, final state) =>
                StatefulSetPasswordPage(adminAuthenticator: adminAuthenticator),
          ),
          GoRoute(
            path: 'home',
            builder: (final context, final state) => StatefulHomeScreen(
              carRegistry: carRegistry,
              adminAuthenticator: adminAuthenticator,
            ),
          ),
        ],
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      title: 'Thyme Admin',
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
