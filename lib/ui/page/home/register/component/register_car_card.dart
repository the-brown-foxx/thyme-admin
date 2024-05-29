import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/splash_image.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/component/register_car_body.dart';

class RegisterCarCard extends StatelessWidget {
  final TextFieldController registrationIdController;
  final TextFieldController makeController;
  final TextFieldController modelController;
  final TextFieldController yearController;
  final TextFieldController colorController;
  final TextFieldController ownerController;
  final VoidCallback? onRegisterCar;
  final VoidCallback? onCancel;
  final bool loading;

  const RegisterCarCard({
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
    return TwoPaneCard(
      loading: loading,
      leftChild: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: RegisterCarBody(
            registrationIdController: registrationIdController,
            makeController: makeController,
            modelController: modelController,
            yearController: yearController,
            colorController: colorController,
            ownerController: ownerController,
            onRegisterCar: !loading ? onRegisterCar : null,
            onCancel: !loading ? onCancel : null,
          ),
        ),
      ),
      rightChild: const SplashImage.landing(),
    );
  }
}
