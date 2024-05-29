import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car_update.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/home/edit/edit_car_dialog.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/stateful_car_info_dialog.dart';

class StatefulEditCarDialog extends StatefulWidget {
  final CarRegistry _carRegistry;
  final CarLogger _carLogger;
  final Car car;

  const StatefulEditCarDialog({
    super.key,
    required final CarRegistry carRegistry,
    required final CarLogger carLogger,
    required this.car,
  })  : _carRegistry = carRegistry,
        _carLogger = carLogger;

  @override
  State<StatefulEditCarDialog> createState() => _StatefulEditCarDialogState();
}

class _StatefulEditCarDialogState extends State<StatefulEditCarDialog> {
  final makeController = TextFieldController();
  final modelController = TextFieldController();
  final yearController = TextFieldController(numeric: true);
  final colorController = TextFieldController();
  final ownerController = TextFieldController();
  var loading = false;

  @override
  void initState() {
    makeController.text = widget.car.make;
    modelController.text = widget.car.model;
    yearController.text = widget.car.year.toString();
    colorController.text = widget.car.color;
    ownerController.text = widget.car.owner;

    widget._carRegistry.loading.listen((final loading) {
      if (!mounted) return;
      setState(() => this.loading = loading);
    });

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return EditCarDialog(
      car: widget.car,
      makeController: makeController,
      modelController: modelController,
      yearController: yearController,
      colorController: colorController,
      ownerController: ownerController,
      onEditCar: onEditCar,
      onCancel: onCancel,
      loading: loading,
    );
  }

  void onCancel() {
    context.pop();
    openCarInfoDialog();
  }

  void onEditCar() async {
    try {
      await widget._carRegistry.updateCar(
        CarUpdate(
          registrationId: widget.car.registrationId,
          make: makeController.text,
          model: modelController.text,
          year: int.tryParse(yearController.text) ?? -1,
          color: colorController.text,
          owner: ownerController.text,
        ),
      );
      if (!mounted) return;
      context.pop();
      openCarInfoDialog();
    } on FieldCannotBeBlankException catch (exception) {
      switch (exception.fieldName) {
        case 'make':
          makeController.error = 'Make is required';
        case 'model':
          modelController.error = 'Model is required';
        case 'year':
          yearController.error = 'Year is required';
        case 'color':
          colorController.error = 'Color is required';
        case 'owner':
          ownerController.error = 'Owner is required';
      }
    } on InvalidTokenException {
      if (!mounted) return;
      context.showSnackBar('Invalid token');
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (!mounted) return;
      context.showSnackBar('Connection error');
    }
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

  @override
  void dispose() {
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    colorController.dispose();
    ownerController.dispose();
    super.dispose();
  }
}
