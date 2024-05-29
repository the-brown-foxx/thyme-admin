import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/empty_indicator.dart';

class WidgetWithPlaceholder extends StatelessWidget {
  final bool showPlaceholder;
  final Widget placeholder;
  final Widget child;

  const WidgetWithPlaceholder({
    super.key,
    required this.showPlaceholder,
    required this.placeholder,
    required this.child,
  });

  factory WidgetWithPlaceholder.withEmptyIndicator({
    required final bool empty,
    required final String emptyMessage,
    required final Widget child,
    final bool flipImage = false,
  }) {
    return WidgetWithPlaceholder(
      showPlaceholder: empty,
      placeholder: EmptyIndicator(
        message: emptyMessage,
        flipImage: flipImage,
      ),
      child: child,
    );
  }

  @override
  Widget build(final BuildContext context) {
    // TODO: Fix jerking animation
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      child: showPlaceholder ? placeholder : child,
    );
  }
}
