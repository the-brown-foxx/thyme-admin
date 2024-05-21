import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/license_plate.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/component/car_info.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class CarInfoBody extends StatelessWidget {
  final Car car;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const CarInfoBody({
    super.key,
    required this.car,
    required this.onEdit,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        LicensePlate(registrationId: car.registrationId),
        const SizedBox(height: 16),
        CarInfo(icon: Icons.sell, label: 'Make', value: car.make),
        const SizedBox(height: 16),
        CarInfo(icon: Icons.notes, label: 'Model', value: car.model),
        const SizedBox(height: 16),
        CarInfo(
          icon: Icons.onetwothree,
          label: 'Year',
          value: car.year.toString(),
        ),
        const SizedBox(height: 16),
        CarInfo(icon: Icons.color_lens, label: 'Color', value: car.color),
        const SizedBox(height: 16),
        CarInfo(icon: Icons.person, label: 'Owner', value: car.owner),
        const SizedBox(height: 16),
        Row(
          children: [
            HerbHubButton(
              text: 'Cancel',
              onPressed: onCancel,
              roundedCorners: Edge.left,
              type: ButtonType.outlined,
              alignment: Alignment.centerRight,
            ),
            const SizedBox(width: 8),
            HerbHubButton(
              text: 'Delete',
              onPressed: onDelete,
              roundedCorners: const {},
              type: ButtonType.outlined,
              alignment: Alignment.centerRight,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: HerbHubButton(
                text: 'Edit',
                onPressed: onEdit,
                roundedCorners: Edge.right,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        )
      ],
    );
  }
}
