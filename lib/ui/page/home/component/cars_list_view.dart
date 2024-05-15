import 'package:flutter/material.dart';

import '../../../../service/registry/model/car.dart';
import 'car_card.dart';

class CarsListView extends StatelessWidget {
  final List<Car> cars;
  final double maxContentWidth;

  const CarsListView({
    super.key,
    required this.cars,
    this.maxContentWidth = double.infinity,
  });

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cars.length,
      itemBuilder: (final _, final index) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 0 : 8,
              bottom: index == cars.length - 1 ? 0 : 8,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: CarCard(
                car: cars[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
