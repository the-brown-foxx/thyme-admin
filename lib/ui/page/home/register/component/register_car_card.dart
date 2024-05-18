import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/component/register_car_body.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/component/register_car_image.dart';

class RegisterCarCard extends StatelessWidget {
  final TextEditingController registrationIdController;
  final TextEditingController makeController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController colorController;
  final TextEditingController ownerController;
  final VoidCallback? onRegisterCar;
  final VoidCallback? onCancel;
  final bool registrationIdRequired;
  final bool makeRequired;
  final bool modelRequired;
  final bool yearRequired;
  final bool colorRequired;
  final bool ownerRequired;
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
    required this.registrationIdRequired,
    required this.makeRequired,
    required this.modelRequired,
    required this.yearRequired,
    required this.colorRequired,
    required this.ownerRequired,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      largeCornerRadius: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                      registrationIdRequired: registrationIdRequired,
                      makeRequired: makeRequired,
                      modelRequired: modelRequired,
                      yearRequired: yearRequired,
                      colorRequired: colorRequired,
                      ownerRequired: ownerRequired,
                    ),
                  ),
                ),
              ),
              const Expanded(child: RegisterCarImage()),
            ],
          ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}
