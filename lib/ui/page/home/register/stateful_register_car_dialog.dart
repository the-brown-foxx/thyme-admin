import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/new_car.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/register_car_dialog.dart';

class StatefulRegisterCarDialog extends StatefulWidget {
  final CarRegistry _carRegistry;

  const StatefulRegisterCarDialog({
    super.key,
    required final CarRegistry carRegistry,
  })  : _carRegistry = carRegistry;

  @override
  State<StatefulRegisterCarDialog> createState() =>
      _StatefulRegisterCarDialogState();
}

class _StatefulRegisterCarDialogState extends State<StatefulRegisterCarDialog> {
  final registrationIdController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final colorController = TextEditingController();
  final ownerController = TextEditingController();
  var oldRegistrationId = '';
  var oldMake = '';
  var oldModel = '';
  var oldYear = '';
  var oldColor = '';
  var oldOwner = '';
  var registrationIdBlank = false;
  var makeBlank = false;
  var modelBlank = false;
  var yearBlank = false;
  var colorBlank = false;
  var ownerBlank = false;
  var loading = false;

  @override
  void initState() {
    widget._carRegistry.loading.listen((final loading) {
      if (!mounted) return;
      setState(() => this.loading = loading);
    });
    registrationIdController.addListener(() {
      if (oldRegistrationId != registrationIdController.text && mounted) {
        setState(() => registrationIdBlank = false);
      }
      oldRegistrationId = registrationIdController.text;
    });
    makeController.addListener(() {
      if (oldMake != makeController.text && mounted) {
        setState(() => makeBlank = false);
      }
      oldMake = makeController.text;
    });
    modelController.addListener(() {
      if (oldModel != modelController.text && mounted) {
        setState(() => modelBlank = false);
      }
      oldModel = modelController.text;
    });
    yearController.addListener(() {
      if (oldYear != yearController.text && mounted) {
        setState(() => yearBlank = false);
      }
      if (int.tryParse(yearController.text) == null &&
          yearController.text != '' && mounted) {
        yearController.text = oldYear;
      }
      oldYear = yearController.text;
    });
    colorController.addListener(() {
      if (oldColor != colorController.text && mounted) {
        setState(() => colorBlank = false);
      }
      oldColor = colorController.text;
    });
    ownerController.addListener(() {
      if (oldOwner != ownerController.text && mounted) {
        setState(() => ownerBlank = false);
      }
      oldOwner = ownerController.text;
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
      registrationIdBlank: registrationIdBlank,
      makeBlank: makeBlank,
      modelBlank: modelBlank,
      yearBlank: yearBlank,
      colorBlank: colorBlank,
      ownerBlank: ownerBlank,
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
      setState(() {
        switch (exception.fieldName) {
          case 'registration_id':
            registrationIdBlank = true;
          case 'make':
            makeBlank = true;
          case 'model':
            modelBlank = true;
          case 'year':
            yearBlank = true;
          case 'color':
            colorBlank = true;
          case 'owner':
            ownerBlank = true;
        }
      });
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
