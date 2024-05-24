import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/car_info_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/unregister/stateful_unregister_car_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/edit/stateful_edit_car_dialog.dart';

class StatefulCarInfoDialog extends StatefulWidget {
  final Car car;
  final CarRegistry _carRegistry;

  const StatefulCarInfoDialog({
    super.key,
    required this.car,
    required final CarRegistry carRegistry,
  }) : _carRegistry = carRegistry;

  @override
  State<StatefulCarInfoDialog> createState() => _StatefulCarInfoDialogState();
}

class _StatefulCarInfoDialogState extends State<StatefulCarInfoDialog> {
  @override
  Widget build(final BuildContext context) {
    return CarInfoDialog(
      car: widget.car,
      carLogs: [
        CarLog(
          dateTime: DateTime(2024, 5, 3, 10, 56, 09),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: true,
        ),
        CarLog(
          dateTime: DateTime(2024, 5, 21, 9, 37, 53),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: false,
        ),
        CarLog(
          dateTime: DateTime(2024, 6, 2, 7, 47, 33),
          carRegistrationId: 'CBT4783',
          entering: false,
          image: 'image',
          sus: false,
        ),
        CarLog(
          dateTime: DateTime(2024, 5, 3, 10, 56, 09),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: true,
        ),
        CarLog(
          dateTime: DateTime(2024, 5, 21, 9, 37, 53),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: false,
        ),
        CarLog(
          dateTime: DateTime(2024, 6, 2, 7, 47, 33),
          carRegistrationId: 'CBT4783',
          entering: false,
          image: 'image',
          sus: false,
        ),
        CarLog(
          dateTime: DateTime(2024, 5, 3, 10, 56, 09),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: true,
        ),
        CarLog(
          dateTime: DateTime(2024, 5, 21, 9, 37, 53),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: false,
        ),
        CarLog(
          dateTime: DateTime(2024, 6, 2, 7, 47, 33),
          carRegistrationId: 'CBT4783',
          entering: false,
          image: 'image',
          sus: false,
        ),
        CarLog(
          dateTime: DateTime(2024, 5, 3, 10, 56, 09),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: true,
        ),
        CarLog(
          dateTime: DateTime(2024, 5, 21, 9, 37, 53),
          carRegistrationId: 'CBT4783',
          entering: true,
          image: 'image',
          sus: false,
        ),
        CarLog(
          dateTime: DateTime(2024, 6, 2, 7, 47, 33),
          carRegistrationId: 'CBT4783',
          entering: false,
          image: 'image',
          sus: false,
        ),
      ],
      onEdit: onEdit,
      onDelete: onDelete,
      onCancel: onCancel,
    );
  }

  void onEdit() {
    context.pop();
    showDialog(
      context: context,
      builder: (final _) {
        return StatefulEditCarDialog(
          carRegistry: widget._carRegistry,
          car: widget.car,
        );
      },
    );
  }

  void onDelete() {
    showDialog(
      context: context,
      builder: (final _) => StatefulUnregisterCarDialog(
        car: widget.car,
        carRegistry: widget._carRegistry,
      ),
    );
  }

  void onCancel() {
    context.pop();
  }
}
