import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class HerbHubCard extends StatelessWidget {
  final Set<Corner> roundedCorners;
  final bool largeCornerRadius;
  final Widget child;
  final Color? containerColor;

  const HerbHubCard({
    super.key,
    this.roundedCorners = Corner.all,
    this.largeCornerRadius = false,
    this.containerColor,
    required this.child,
  });

  @override
  Widget build(final BuildContext context) {
    final containerColor =
        this.containerColor ?? context.theme.colorScheme.surface;
    final borderRadius = largeCornerRadius
        ? BorderRadius.circular(32.0)
        : BorderRadius.only(
            topLeft: roundedCorners.getRadius(Corner.topLeft),
            topRight: roundedCorners.getRadius(Corner.topRight),
            bottomLeft: roundedCorners.getRadius(Corner.bottomLeft),
            bottomRight: roundedCorners.getRadius(Corner.bottomRight),
          );

    return Card.outlined(
      color: containerColor,
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.theme.colorScheme.onSurface,
          width: 2.0,
        ),
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
