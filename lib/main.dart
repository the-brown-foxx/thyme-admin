import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/pages/login/login_page.dart';
import 'package:thyme_to_park_admin/ui/theme/color_schemes.dart';
import 'package:thyme_to_park_admin/ui/theme/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
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
      home: const LoginPage(),
    );
  }
}