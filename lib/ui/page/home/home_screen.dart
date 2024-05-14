import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    // return const Scaffold(body: Text('Logged in'));
    return Scaffold(
      body: HerbHubButton(
          text: 'ChangePassword',
          onPressed: () {
            context.go('/change-password');
          },
          alignment: Alignment.center,
        ),
    );
        
  }
}
