import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/license_plate.dart';

class EditCarBody extends StatelessWidget {
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
    required this.makeBlank,
    required this.modelBlank,
    required this.yearBlank,
    required this.colorBlank,
    required this.ownerBlank,
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
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'Make',
          controller: makeController,
          errorText: makeBlank ? 'Make is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onEditCar?.call(),
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'Model',
          controller: modelController,
          errorText: modelBlank ? 'Model is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onEditCar?.call(),
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'Year',
          controller: yearController,
          errorText: yearBlank ? 'Year is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onEditCar?.call(),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'Color',
          controller: colorController,
          errorText: colorBlank ? 'Color is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onEditCar?.call(),
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          hintText: 'Owner',
          controller: ownerController,
          errorText: ownerBlank ? 'Owner required.' : null,
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
                text: 'Edit',
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
