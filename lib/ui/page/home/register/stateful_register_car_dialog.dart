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
  }) : _carRegistry = carRegistry;

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
  var registrationIdRequired = false;
  var makeRequired = false;
  var modelRequired = false;
  var yearRequired = false;
  var colorRequired = false;
  var ownerRequired = false;
  var registrationIdEmpty = false;
  var makeEmpty = false;
  var modelEmpty = false;
  var yearEmpty = false;
  var colorEmpty = false;
  var ownerEmpty = false;
  var loading = false;

  @override
  void initState() {
    widget._carRegistry.loading.listen((final loading) {
      setState(() => this.loading = loading);
    });
    registrationIdController.addListener(() {
      if (oldRegistrationId != registrationIdController.text) {
        setState(() => registrationIdEmpty = false);
      }
      oldRegistrationId = registrationIdController.text;
    });
    makeController.addListener(() {
      if (oldMake != makeController.text) {
        setState(() => makeEmpty = false);
      }
      oldMake = makeController.text;
    });
    modelController.addListener(() {
      if (oldModel != modelController.text) {
        setState(() => modelEmpty = false);
      }
      oldModel = modelController.text;
    });
    yearController.addListener(() {
      if (oldYear != yearController.text) {
        setState(() => yearEmpty = false);
      }
      if (int.tryParse(yearController.text) == null &&
          yearController.text != '') {
        yearController.text = oldYear;
      }
      oldYear = yearController.text;
    });
    colorController.addListener(() {
      if (oldColor != colorController.text) {
        setState(() => colorEmpty = false);
      }
      oldColor = colorController.text;
    });
    ownerController.addListener(() {
      if (oldOwner != ownerController.text) {
        setState(() => ownerEmpty = false);
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
      registrationIdRequired: registrationIdRequired,
      makeRequired: makeRequired,
      modelRequired: modelRequired,
      yearRequired: yearRequired,
      colorRequired: colorRequired,
      ownerRequired: ownerRequired,
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
          year: int.parse(yearController.text),
          color: colorController.text,
          owner: ownerController.text,
        ),
      );
      if (!mounted) return;
      context.pop();
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
