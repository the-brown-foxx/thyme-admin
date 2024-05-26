import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/card_hover_decoration.dart';

class CarCardDecoration extends StatelessWidget {
  final String carColor;
  final bool persistent;
  final HerbHubCard child;

  const CarCardDecoration({
    super.key,
    required this.carColor,
    required this.persistent,
    required this.child,
  });

  @override
  Widget build(final BuildContext context) {
    final gradientColors = switch (carColor.toLowerCase()) {
      'red' => const [
          Colors.pink,
          Colors.red,
          Colors.deepOrange,
        ],
      'orange' => const [
          Colors.deepOrange,
          Colors.orange,
          Colors.amber,
        ],
      'yellow' => const [
          Colors.amber,
          Colors.yellow,
          Colors.lime,
        ],
      'green' => const [
          Colors.lightGreen,
          Colors.green,
          Colors.green,
          Colors.teal,
          Colors.cyan,
        ],
      'blue' => const [
          Colors.cyan,
          Colors.lightBlue,
          Colors.blue,
          Colors.indigo,
        ],
      'purple' => const [
          Colors.indigo,
          Colors.purple,
          Colors.deepPurple,
        ],
      _ => CardHoverDecoration.defaultGradientColors,
    };

    return CardHoverDecoration.forHerbHubCard(
      persistent: persistent,
      gradientColors: gradientColors,
      child: child,
    );
  }
}
