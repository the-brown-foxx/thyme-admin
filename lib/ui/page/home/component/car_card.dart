import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/license_plate.dart';

import '../../../util/corner.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final Set<Corner> roundedCorners;

  const CarCard({
    super.key,
    required this.car,
    this.roundedCorners = Corner.all,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      largeCornerRadius: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.owner,
                  style: context.theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text('${car.color} ${car.year} ${car.make} ${car.model}'),
              ],
            ),
            const Spacer(),
            LicensePlate(registrationId: car.registrationId),
          ],
        ),
      ),
    );
  }
}
