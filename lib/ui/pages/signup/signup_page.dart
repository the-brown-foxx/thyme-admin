import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/pages/signup/components/signup_header.dart';

import 'components/signup_body.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SignupHeader()),
          Divider(
            thickness: 2,
            height: 0,
          ),
          SignupBody(),
        ],
      ),
    );
  }
}
