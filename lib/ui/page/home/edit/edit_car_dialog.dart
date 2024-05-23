import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'component/edit_car_card.dart';

class EditCarDialog extends StatelessWidget {
  final Car car;
  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController colorController;
  final TextEditingController ownerController;
  final VoidCallback? onEditCar;
  final VoidCallback? onCancel;
  final bool makeBlank;
  final bool modelBlank;
  final bool yearBlank;
  final bool colorBlank;
  final bool ownerBlank;
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
        child: EditCarCard(
          car: car,
          makeController: makeController,
          modelController: modelController,
          yearController: yearController,
          colorController: colorController,
          ownerController: ownerController,
          onEditCar: onEditCar,
          onCancel: onCancel,
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
