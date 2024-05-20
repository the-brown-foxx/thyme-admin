import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class HerbHubDialog extends StatelessWidget {
  final Widget child;

  const HerbHubDialog({super.key, required this.child});

  @override
  Widget build(final BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          color: context.theme.colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: child,
    );
  }
}
