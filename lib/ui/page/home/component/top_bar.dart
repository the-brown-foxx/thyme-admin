import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/icon_button.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class TopBar extends StatelessWidget {
  final double maxContentWidth;
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final bool scrolled;

  const TopBar({
    super.key,
    this.maxContentWidth = double.infinity,
    required this.onChangePassword,
    required this.onLogout,
    this.scrolled = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: scrolled
              ? context.theme.colorScheme.surface
              : context.theme.colorScheme.background,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxContentWidth,
                  minHeight: 64,
                ),
                child: Row(
                  children: [
                    Text(
                      'Cars',
                      style: context.theme.textTheme.titleLarge,
                    ),
                    const Spacer(),
                    HerbHubIconButton(
                      onPressed: onChangePassword,
                      icon: Icons.password,
                    ),
                    const SizedBox(width: 8),
                    HerbHubIconButton(
                      onPressed: onLogout,
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
        ),
      ],
    );
  }
}
