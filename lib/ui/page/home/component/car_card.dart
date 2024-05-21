import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/disableable_ink_well.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/license_plate.dart';

import '../../../util/corner.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback? onTap;
  final Set<Corner> roundedCorners;

  const CarCard({
    super.key,
    required this.car,
    this.onTap,
    this.roundedCorners = Corner.all,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      roundedCorners: roundedCorners,
      child: DisableableInkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.owner,
                      style: context.theme.textTheme.titleMedium,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${car.color} ${car.year} ${car.make} ${car.model}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              LicensePlate(registrationId: car.registrationId),
            ],
          ),
        ),
      ),
    );
  }
}
