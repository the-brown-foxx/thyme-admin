import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/stateful_car_info_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/unregister/unregister_car_dialog.dart';

class StatefulUnregisterCarDialog extends StatefulWidget {
  final Car car;
  final CarRegistry _carRegistry;
  final CarLogger _carLogger;

  const StatefulUnregisterCarDialog({
    super.key,
    required this.car,
    required final CarRegistry carRegistry,
    required final CarLogger carLogger,
  })  : _carRegistry = carRegistry,
        _carLogger = carLogger;

  @override
  State<StatefulUnregisterCarDialog> createState() =>
      _StatefulUnregisterCarDialogState();
}

class _StatefulUnregisterCarDialogState
    extends State<StatefulUnregisterCarDialog> {
  var loading = false;

  @override
  void initState() {
    widget._carRegistry.loading.listen((final loading) {
      if (!mounted) return;
      setState(() => this.loading = loading);
    });

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return UnregisterCarDialog(
      car: widget.car,
      onConfirm: onConfirm,
      onCancel: onCancel,
      loading: loading,
    );
  }

  void onConfirm() async {
    try {
      await widget._carRegistry.unregisterCar(widget.car.registrationId);
      if (!mounted) return;
      context.pop();
    } on ApiException catch (exception) {
      context.showSnackBar(exception.message);
    } on ClientException {
      context.showSnackBar('Connection error');
    }
  }

  void onCancel() {
    context.pop();
    openCarInfoDialog();
  }

  void openCarInfoDialog() {
    showDialog(
      context: context,
      builder: (final _) => StatefulCarInfoDialog(
        car: widget.car,
        carRegistry: widget._carRegistry,
        carLogger: widget._carLogger,
      ),
    );
  }
}
