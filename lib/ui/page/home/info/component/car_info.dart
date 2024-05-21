import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class CarInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Set<Corner> roundedCorners;

  const CarInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.roundedCorners = Corner.all,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      roundedCorners: roundedCorners,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: context.theme.textTheme.labelSmall),
                Text(value, style: context.theme.textTheme.bodyLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
