import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/car_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CarCard(
              car: SetPasswordCar(
                registrationId: 'CAR LOS',
                make: 'McLaren',
                model: 'MCL38',
                year: 2024,
                color: 'Orange',
                owner: 'Lando Norris',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
