import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class VacantSpaceCard extends StatelessWidget {
  final int vacantSpace;
  final VoidCallback onTap;

  const VacantSpaceCard({
    super.key,
    required this.vacantSpace,
    required this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      roundedCorners: const {},
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.local_parking),
            const SizedBox(width: 8),
            Text(
              vacantSpace.toString(),
              style: context.theme.textTheme.titleMedium,
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
