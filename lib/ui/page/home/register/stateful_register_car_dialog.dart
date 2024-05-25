import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/new_car.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/register_car_dialog.dart';

class StatefulRegisterCarDialog extends StatefulWidget {
  final CarRegistry _carRegistry;

  const StatefulRegisterCarDialog({
    super.key,
    required final CarRegistry carRegistry,
  }) : _carRegistry = carRegistry;

  @override
  State<StatefulRegisterCarDialog> createState() =>
      _StatefulRegisterCarDialogState();
}

class _StatefulRegisterCarDialogState extends State<StatefulRegisterCarDialog> {
  final registrationIdController = TextFieldController();
  final makeController = TextFieldController();
  final modelController = TextFieldController();
  final yearController = TextFieldController(numeric: true);
  final colorController = TextFieldController();
  final ownerController = TextFieldController();
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
    return RegisterCarDialog(
      registrationIdController: registrationIdController,
      makeController: makeController,
      modelController: modelController,
      yearController: yearController,
      colorController: colorController,
      ownerController: ownerController,
      onRegisterCar: onRegisterCar,
      onCancel: onCancel,
      loading: loading,
    );
  }

  void onCancel() {
    Navigator.of(context).pop();
  }

  void onRegisterCar() async {
    try {
      await widget._carRegistry.registerCar(
        NewCar(
          registrationId: registrationIdController.text,
          make: makeController.text,
          model: modelController.text,
          year: int.tryParse(yearController.text) ?? -1,
          color: colorController.text,
          owner: ownerController.text,
        ),
      );
      if (!mounted) return;
      context.pop();
    } on FieldCannotBeBlankException catch (exception) {
      switch (exception.fieldName) {
        case 'registration_id':
          registrationIdController.error = 'Registration ID is required';
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

  @override
  void dispose() {
    registrationIdController.dispose();
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    colorController.dispose();
    ownerController.dispose();
    super.dispose();
  }
}
