import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/home//edit/component/edit_car_image.dart';
import 'package:thyme_to_park_admin/ui/page/home/edit/component/edit_car_body.dart';

class EditCarCard extends StatelessWidget {
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
    required this.makeBlank,
    required this.modelBlank,
    required this.yearBlank,
    required this.colorBlank,
    required this.ownerBlank,
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
            makeBlank: makeBlank,
            modelBlank: modelBlank,
            yearBlank: yearBlank,
            colorBlank: colorBlank,
            ownerBlank: ownerBlank,
          ),
        ),
      ),
      rightChild: const EditCarImage(),
    );
  }
}
