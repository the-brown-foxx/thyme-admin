import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/splash_image.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';

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
    return TwoPaneCard(
      loading: loading,
      leftChild: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: UnregisterCarBody(
            car: car,
            onConfirm: onConfirm,
            onCancel: onCancel,
          ),
        ),
      ),
      rightChild: const SplashImage.landing(),
    );
  }
}
