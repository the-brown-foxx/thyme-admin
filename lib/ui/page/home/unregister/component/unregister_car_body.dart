import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/car_card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class UnregisterCarBody extends StatelessWidget {
  final Car car;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const UnregisterCarBody({
    super.key,
    required this.car,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unregister car',
          maxLines: 2,
          style: context.theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Are you sure you want to unregister this car?',
          style: context.theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        CarCard(car: car),
        const SizedBox(height: 16),
        Row(
          children: [
            HerbHubButton(
              text: 'No',
              onPressed: onCancel,
              roundedCorners: Edge.left,
              type: ButtonType.outlined,
              alignment: Alignment.centerRight,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: HerbHubButton(
                text: 'Yes',
                onPressed: onConfirm,
                roundedCorners: Edge.right,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
