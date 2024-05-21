import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/home/unregister/unregister_car_dialog.dart';

class StatefulUnregisterCarDialog extends StatefulWidget {
  final Car car;
  final CarRegistry _carRegistry;

  const StatefulUnregisterCarDialog({
    super.key,
    required this.car,
    required final CarRegistry carRegistry,
  }) : _carRegistry = carRegistry;

  @override
  State<StatefulUnregisterCarDialog> createState() =>
      _StatefulUnregisterCarDialogState();
}

class _StatefulUnregisterCarDialogState
    extends State<StatefulUnregisterCarDialog> {
  @override
  Widget build(final BuildContext context) {
    return UnregisterCarDialog(
      car: widget.car,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  void onConfirm() async {
    try {
      await widget._carRegistry.unregisterCar(widget.car.registrationId);
      if (!mounted) return;
      context.pop();
      context.pop();
    } on ApiException catch (exception) {
      context.showSnackBar(exception.message);
    } on ClientException {
      context.showSnackBar('Connection error');
    }
  }

  void onCancel() {
    context.pop();
  }
}
