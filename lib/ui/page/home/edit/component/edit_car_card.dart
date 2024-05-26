import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/home//edit/component/edit_car_image.dart';
import 'package:thyme_to_park_admin/ui/page/home/edit/component/edit_car_body.dart';
import 'package:thyme_to_park_admin/ui/page/login/component/login_image.dart';

class EditCarCard extends StatelessWidget {
  final Car car;
  final TextFieldController makeController;
  final TextFieldController modelController;
  final TextFieldController yearController;
  final TextFieldController colorController;
  final TextFieldController ownerController;
  final VoidCallback? onEditCar;
  final VoidCallback? onCancel;
  final bool loading;

  const EditCarCard({
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
    return TwoPaneCard(
      loading: loading,
      leftChild: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: EditCarBody(
            car: car,
            makeController: makeController,
            modelController: modelController,
            yearController: yearController,
            colorController: colorController,
            ownerController: ownerController,
            onEditCar: !loading ? onEditCar : null,
            onCancel: !loading ? onCancel : null,
          ),
        ),
      ),
      rightChild: const LoginImage(),
    );
  }
}
