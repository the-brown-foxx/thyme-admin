import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/car_info_dialog.dart';

class StatefulCarInfoDialog extends StatefulWidget {
  final Car car;

  const StatefulCarInfoDialog({super.key, required this.car});

  @override
  State<StatefulCarInfoDialog> createState() => _StatefulCarInfoDialogState();
}

class _StatefulCarInfoDialogState extends State<StatefulCarInfoDialog> {
  @override
  Widget build(final BuildContext context) {
    return CarInfoDialog(
      car: widget.car,
      onEdit: onEdit,
      onCancel: onCancel,
    );
  }

  void onEdit() {
    throw UnimplementedError();
  }

  void onCancel() {
    context.pop();
  }
}
