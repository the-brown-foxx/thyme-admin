import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/component/car_info_card.dart';

class CarInfoDialog extends StatelessWidget {
  final Car car;
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  const CarInfoDialog({
    super.key,
    required this.car,
    required this.onEdit,
    required this.onCancel,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubDialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: CarInfoCard(
          car: car,
          onEdit: onEdit,
          onCancel: onCancel,
          loading: false,
        ),
      ),
    );
  }
}
