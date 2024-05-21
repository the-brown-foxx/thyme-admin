import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/unregister/component/unregister_car_card.dart';

class UnregisterCarDialog extends StatelessWidget {
  final Car car;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool loading;

  const UnregisterCarDialog({
    super.key,
    required this.car,
    required this.onConfirm,
    required this.onCancel,
    required this.loading
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubDialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: UnregisterCarCard(
          car: car,
          onConfirm: onConfirm,
          onCancel: onCancel,
          loading: loading,
        ),
      ),
    );
  }
}
