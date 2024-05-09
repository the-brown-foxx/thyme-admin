import 'package:flutter/material.dart';

import '../util/corner.dart';

enum ButtonType {
  filled,
  outlined,
}

class HerbHubButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final Set<Corner> roundedCorners;
  final AlignmentGeometry alignment;

  const HerbHubButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.filled,
    this.roundedCorners = Corner.all,
    this.alignment = Alignment.center,
  });

  double get leftPadding => roundedCorners.containsAll(Edge.left) ? 24 : 16;

  double get rightPadding => roundedCorners.containsAll(Edge.right) ? 24 : 16;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final side = switch (type) {
      ButtonType.filled => null,
      ButtonType.outlined =>
          BorderSide(color: theme.colorScheme.primary, width: 2),
    };
    final foregroundColor = switch (type) {
      ButtonType.filled => theme.colorScheme.onPrimary,
      ButtonType.outlined => theme.colorScheme.onSurface,
    };
    final backgroundColor = switch (type) {
      ButtonType.filled => theme.colorScheme.primary,
      ButtonType.outlined => theme.colorScheme.surface,
    };
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: roundedCorners.getRadius(Corner.topLeft),
        topRight: roundedCorners.getRadius(Corner.topRight),
        bottomLeft: roundedCorners.getRadius(Corner.bottomLeft),
        bottomRight: roundedCorners.getRadius(Corner.bottomRight),
      ),
    );

    return FilledButton(
      style: FilledButton.styleFrom(
        side: side,
        shape: shape,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
        alignment: alignment,
      ),
      onPressed: onPressed,
      child: Text(text, maxLines: 1),
    );
  }
}
