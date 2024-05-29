import 'package:flutter/material.dart';

class OptionalIntrinsicHeight extends StatelessWidget {
  final bool enabled;
  final Widget child;

  const OptionalIntrinsicHeight({
    super.key,
    required this.enabled,
    required this.child,
  });

  @override
  Widget build(final BuildContext context) {
    return AnimatedCrossFade(
      firstChild: IntrinsicHeight(child: child),
      secondChild: child,
      crossFadeState:
          enabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
    );
  }
}
