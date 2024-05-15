import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';


class RegisterCarBody extends StatelessWidget {
  final TextEditingController registrationIdController;
  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController colorController;
  final TextEditingController ownerController;
  final VoidCallback? onRegisterCar;
  final bool registrationIdRequired;
  final bool makeRequired;
  final bool modelRequired;
  final bool yearRequired;
  final bool colorRequired;
  final bool ownerRequired;

  const RegisterCarBody({
    super.key,
    required this.registrationIdController,
    required this.makeController,
    required this.modelController,
    required this.yearController,
    required this.colorController,
    required this.ownerController,
    required this.onRegisterCar,
    required this.registrationIdRequired,
    required this.makeRequired,
    required this.modelRequired,
    required this.yearRequired,
    required this.colorRequired,
    required this.ownerRequired,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        const SizedBox(height: 32),
        Text(
          'Register car',
          maxLines: 1,
          style: theme.textTheme.displayLarge,
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Registration ID',
          controller: registrationIdController,
          errorText:
              registrationIdRequired ? 'Registration ID is required' : null,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Make',
          controller: makeController,
          errorText: makeRequired ? 'Make is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Model',
          controller: modelController,
          errorText: modelRequired ? 'Model is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Year',
          controller: yearController,
          errorText: yearRequired ? 'Year is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Color',
          controller: colorController,
          errorText: colorRequired ? 'Color is required' : null,
          roundedCorners: const {},
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          hintText: 'Owner',
          controller: ownerController,
          errorText: ownerRequired ? 'Owner required.' : null,
          roundedCorners: Edge.bottom,
          onSubmitted: (final _) => onRegisterCar?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Login',
          onPressed: onRegisterCar,
          alignment: Alignment.center,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
