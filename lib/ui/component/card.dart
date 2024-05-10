import 'package:flutter/material.dart';

class HerbHubCard extends StatelessWidget {
  final Widget child;

  const HerbHubCard({super.key, required this.child});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Card.outlined(
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.onSurface,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(32.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
