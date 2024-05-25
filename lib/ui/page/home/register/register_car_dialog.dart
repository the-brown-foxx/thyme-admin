import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/dialog.dart';

import 'component/register_car_card.dart';

class RegisterCarDialog extends StatelessWidget {
  final TextFieldController registrationIdController;
  final TextFieldController makeController;
  final TextFieldController modelController;
  final TextFieldController yearController;
  final TextFieldController colorController;
  final TextFieldController ownerController;
  final VoidCallback? onRegisterCar;
  final VoidCallback? onCancel;
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
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubDialog(
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
          loading: loading,
        ),
      ),
    );
  }
}
