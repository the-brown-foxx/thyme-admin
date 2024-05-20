import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

import 'component/register_car_card.dart';

class RegisterCarDialog extends StatelessWidget {
  final TextEditingController registrationIdController;
  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController colorController;
  final TextEditingController ownerController;
  final VoidCallback? onRegisterCar;
  final VoidCallback? onCancel;
  final bool registrationIdBlank;
  final bool makeBlank;
  final bool modelBlank;
  final bool yearBlank;
  final bool colorBlank;
  final bool ownerBlank;
  final bool loading;

  const RegisterCarDialog({
    super.key,
    required this.registrationIdController,
    required this.makeController,
    required this.modelController,
    required this.yearController,
    required this.colorController,
    required this.ownerController,
    required this.onRegisterCar,
    required this.onCancel,
    required this.registrationIdBlank,
    required this.makeBlank,
    required this.modelBlank,
    required this.yearBlank,
    required this.colorBlank,
    required this.ownerBlank,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          color: context.theme.colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: RegisterCarCard(
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
        ),
      ),
    );
  }
}
