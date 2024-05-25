import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/api/actual_api.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/actual_admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/actual_token_storage.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';
import 'package:thyme_to_park_admin/service/log/actual_car_logger.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/parking/actual_parking_space_counter.dart';
import 'package:thyme_to_park_admin/service/parking/parking_space_counter.dart';
import 'package:thyme_to_park_admin/service/registry/actual_car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/ui/page/change_password/stateful_change_password_page.dart';
import 'package:thyme_to_park_admin/ui/page/home/stateful_home_screen.dart';
import 'package:thyme_to_park_admin/ui/page/login/stateful_login_page.dart';
import 'package:thyme_to_park_admin/ui/page/logs/stateful_logs_page.dart';
import 'package:thyme_to_park_admin/ui/page/parking/stateful_set_parking_space_count_page.dart';
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

  final TokenStorage tokenStorage = ActualTokenStorage();
  late final AdminAuthenticator adminAuthenticator = ActualAdminAuthenticator(
    api: api,
    tokenStorage: tokenStorage,
  );
  late final CarRegistry carRegistry = ActualCarRegistry(
    api: api,
    tokenStorage: tokenStorage,
    adminAuthenticator: adminAuthenticator,
  );
  late final CarLogger carLogger = ActualCarLogger(
    api: api,
    tokenStorage: tokenStorage,
    adminAuthenticator: adminAuthenticator,
  );
  late final ParkingSpaceCounter parkingSpaceCounter =
      ActualParkingSpaceCounter(
    api: api,
    tokenStorage: tokenStorage,
    adminAuthenticator: adminAuthenticator,
  );

  MyApp({super.key});

  late final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (final _, final __) =>
            StatefulLoginPage(adminAuthenticator: adminAuthenticator),
        routes: [
          GoRoute(
            path: 'set-password',
            builder: (final _, final __) =>
                StatefulSetPasswordPage(adminAuthenticator: adminAuthenticator),
          ),
          GoRoute(
            path: 'home',
            builder: (final _, final __) => StatefulHomeScreen(
              carRegistry: carRegistry,
              adminAuthenticator: adminAuthenticator,
              carLogger: carLogger,
              parkingSpaceCounter: parkingSpaceCounter,
            ),
            routes: [
              GoRoute(
                path: 'set-parking-space-count',
                builder: (final _, final __) => StatefulSetParkingSpaceCountPage(
                  parkingSpaceCounter: parkingSpaceCounter,
                ),
              ),
              GoRoute(
                path: 'logs',
                builder: (final _, final __) => StatefulLogsPage(
                  carLogger: carLogger,
                ),
              ),
              GoRoute(
                path: 'change-password',
                builder: (final _, final __) => StatefulChangePasswordPage(
                  adminAuthenticator: adminAuthenticator,
                ),
              ),
            ],
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
