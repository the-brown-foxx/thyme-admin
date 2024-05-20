import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class CarInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const CarInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase()),
            Text(value, style: context.theme.textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
