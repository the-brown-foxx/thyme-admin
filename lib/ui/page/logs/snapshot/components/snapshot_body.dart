import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/license_plate.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/component/car_info.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/component/car_log_card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class SnapshotBody extends StatelessWidget {
  final Car car;
  final CarLog carLog;
  final VoidCallback onClose;

  const SnapshotBody({
    super.key,
    required this.car,
    required this.carLog,
    required this.onClose,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LicensePlate(registrationId: car.registrationId),
        const SizedBox(height: 16),
        CarLogCard(
          carLog: carLog,
          roundedCorners: Edge.top,
        ),
        const SizedBox(height: 8),
        CarInfo(
          icon: Icons.sell,
          label: 'Make',
          value: car.make,
          roundedCorners: const {},
        ),
        const SizedBox(height: 8),
        CarInfo(
          icon: Icons.notes,
          label: 'Model',
          value: car.model,
          roundedCorners: const {},
        ),
        const SizedBox(height: 8),
        CarInfo(
          icon: Icons.onetwothree,
          label: 'Year',
          value: car.year.toString(),
          roundedCorners: const {},
        ),
        const SizedBox(height: 8),
        CarInfo(
          icon: Icons.color_lens,
          label: 'Color',
          value: car.color,
          roundedCorners: const {},
        ),
        const SizedBox(height: 8),
        CarInfo(
          icon: Icons.person,
          label: 'Owner',
          value: car.owner,
          roundedCorners: Edge.bottom,
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Close',
          onPressed: onClose,
          type: ButtonType.outlined,
          roundedCorners: Corner.all,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
