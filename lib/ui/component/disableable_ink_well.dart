import 'package:flutter/material.dart';

class DisableableInkWell extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const DisableableInkWell({super.key, this.onTap, required this.child});

  @override
  Widget build(final BuildContext context) {
    return onTap == null
        ? Container(child: child)
        : InkWell(
            onTap: onTap,
            child: child,
          );
  }
}
