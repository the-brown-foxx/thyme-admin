import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/page/home/unregister/component/unregister_car_image.dart';

import 'unregister_car_body.dart';

class UnregisterCarCard extends StatelessWidget {
  final Car car;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool loading;

  const UnregisterCarCard({
    super.key,
    required this.car,
    required this.onConfirm,
    required this.onCancel,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      largeCornerRadius: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: UnregisterCarBody(
                      car: car,
                      onConfirm: onConfirm,
                      onCancel: onCancel,
                    ),
                  ),
                ),
              ),
              const Expanded(child: UnregisterCarImage()),
            ],
          ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}
