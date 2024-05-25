import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/dialog.dart';

import 'component/edit_car_card.dart';

class EditCarDialog extends StatelessWidget {
  final Car car;
  final TextFieldController makeController;
  final TextFieldController modelController;
  final TextFieldController yearController;
  final TextFieldController colorController;
  final TextFieldController ownerController;
  final VoidCallback? onEditCar;
  final VoidCallback? onCancel;
  final bool loading;

  const EditCarDialog({
    super.key,
    required this.car,
    required this.makeController,
    required this.modelController,
    required this.yearController,
    required this.colorController,
    required this.ownerController,
    required this.onEditCar,
    required this.onCancel,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubDialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: EditCarCard(
          car: car,
          makeController: makeController,
          modelController: modelController,
          yearController: yearController,
          colorController: colorController,
          ownerController: ownerController,
          onEditCar: onEditCar,
          onCancel: onCancel,
          loading: loading,
        ),
      ),
    );
  }
}
