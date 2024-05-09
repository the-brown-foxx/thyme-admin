import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key,});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text(
            'HerbHub',
            style: theme.textTheme.displayLarge,
          ),
          const SizedBox(height: 24),
          const HerbHubTextField(
            hintText: 'Username',
            roundedCorners: Edge.top,
          ),
          const SizedBox(height: 8),
          const HerbHubTextField(
            hintText: 'Password',
            roundedCorners: Edge.bottom,
            obscureText: true,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              HerbHubButton(
                text: 'Signup',
                onPressed: () {},
                type: ButtonType.outlined,
                roundedCorners: Edge.left,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: HerbHubButton(
                  text: 'Login',
                  onPressed: () {},
                  roundedCorners: Edge.right,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
