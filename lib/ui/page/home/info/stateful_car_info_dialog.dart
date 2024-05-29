import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/car_info_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/unregister/stateful_unregister_car_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/edit/stateful_edit_car_dialog.dart';

class StatefulCarInfoDialog extends StatefulWidget {
  final Car car;
  final CarRegistry _carRegistry;
  final CarLogger _carLogger;

  const StatefulCarInfoDialog({
    super.key,
    required this.car,
    required final CarRegistry carRegistry,
    required final CarLogger carLogger,
  })  : _carRegistry = carRegistry,
        _carLogger = carLogger;

  @override
  State<StatefulCarInfoDialog> createState() => _StatefulCarInfoDialogState();
}

class _StatefulCarInfoDialogState extends State<StatefulCarInfoDialog> {
  late Car car = widget.car;
  var fetching = false;
  Timer? timer;
  List<CarLog> carLogs = [];

  @override
  void initState() {
    updateCar();
    fetch();
    timer = Timer.periodic(const Duration(seconds: 10), (final _) {
      fetch();
    });
    super.initState();
  }

  void updateCar() async {
    final car = await widget._carRegistry.getCar(widget.car.registrationId);
    if (!mounted) return;
    setState(() {
      this.car = car;
    });
  }

  void fetch() async {
    if (fetching) return;
    fetching = true;
    try {
      final carLogs = await widget._carLogger
          .getCarLogsByRegistrationId(widget.car.registrationId);
      setState(() {
        this.carLogs = carLogs;
      });
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (!mounted) return;
      context.showSnackBar('Connection error');
    } finally {
      fetching = false;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return CarInfoDialog(
      car: car,
      carLogs: carLogs,
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
          carLogger: widget._carLogger,
          car: widget.car,
        );
      },
    );
  }

  void onDelete() {
    context.pop();
    showDialog(
      context: context,
      builder: (final _) => StatefulUnregisterCarDialog(
        car: widget.car,
        carRegistry: widget._carRegistry,
        carLogger: widget._carLogger,
      ),
    );
  }

  void onCancel() {
    context.pop();
  }
}
