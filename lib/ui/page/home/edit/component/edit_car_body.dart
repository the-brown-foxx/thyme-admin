import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/license_plate.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class EditCarBody extends StatelessWidget {
  final Car car;
  final TextFieldController makeController;
  final TextFieldController modelController;
  final TextFieldController yearController;
  final TextFieldController colorController;
  final TextFieldController ownerController;
  final VoidCallback? onEditCar;
  final VoidCallback? onCancel;

  const EditCarBody({
    super.key,
    required this.car,
    required this.makeController,
    required this.modelController,
    required this.yearController,
    required this.colorController,
    required this.ownerController,
    required this.onEditCar,
    required this.onCancel,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Edit car',
          maxLines: 1,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        LicensePlate(registrationId: car.registrationId),
        const SizedBox(height: 16),
        ControlledTextField(
          icon: Icons.sell,
          hintText: 'Make',
          controller: makeController,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onEditCar?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          icon: Icons.notes,
          hintText: 'Model',
          controller: modelController,
          roundedCorners: const {},
          onSubmitted: (final _) => onEditCar?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          icon: Icons.onetwothree,
          hintText: 'Year',
          controller: yearController,
          roundedCorners: const {},
          onSubmitted: (final _) => onEditCar?.call(),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          icon: Icons.color_lens,
          hintText: 'Color',
          controller: colorController,
          roundedCorners: const {},
          onSubmitted: (final _) => onEditCar?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          icon: Icons.person,
          hintText: 'Owner',
          controller: ownerController,
          roundedCorners: Edge.bottom,
          onSubmitted: (final _) => onEditCar?.call(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            HerbHubButton(
              text: 'Cancel',
              onPressed: onCancel,
              roundedCorners: Edge.left,
              type: ButtonType.outlined,
              alignment: Alignment.centerRight,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: HerbHubButton(
                text: 'Save',
                onPressed: onEditCar,
                roundedCorners: Edge.right,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
