import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class RegisterCarBody extends StatelessWidget {
  final TextFieldController registrationIdController;
  final TextFieldController makeController;
  final TextFieldController modelController;
  final TextFieldController yearController;
  final TextFieldController colorController;
  final TextFieldController ownerController;
  final VoidCallback? onRegisterCar;
  final VoidCallback? onCancel;

  const RegisterCarBody({
    super.key,
    required this.registrationIdController,
    required this.makeController,
    required this.modelController,
    required this.yearController,
    required this.colorController,
    required this.ownerController,
    required this.onRegisterCar,
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
          'Register car',
          maxLines: 1,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        ControlledTextField(
          hintText: 'Registration ID',
          controller: registrationIdController,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          hintText: 'Make',
          controller: makeController,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          hintText: 'Model',
          controller: modelController,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          hintText: 'Year',
          controller: yearController,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          hintText: 'Color',
          controller: colorController,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          hintText: 'Owner',
          controller: ownerController,
          roundedCorners: Edge.bottom,
          onSubmitted: (final _) => onRegisterCar?.call(),
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
                text: 'Register',
                onPressed: onRegisterCar,
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
