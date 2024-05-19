import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

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
        final lastIndex = cars.length - 1;
        final roundedCorners = index == 0
            ? Edge.top
            : index == lastIndex
            ? Edge.bottom
            : <Corner>{};

        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 0 : 4,
              bottom: index == lastIndex ? 0 : 4,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: CarCard(
                car: cars[index],
                roundedCorners: roundedCorners,
              ),
            ),
          ),
        );
      },
    );
  }
}
