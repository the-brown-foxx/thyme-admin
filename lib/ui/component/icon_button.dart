import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class HerbHubIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const HerbHubIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(final BuildContext context) {
    return IconButton.outlined(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: context.theme.colorScheme.primary,
          width: 2,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
