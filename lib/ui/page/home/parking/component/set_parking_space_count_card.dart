import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/home/parking/component/set_parking_space_count_body.dart';
import 'package:thyme_to_park_admin/ui/page/home/parking/component/set_parking_space_count_image.dart';

class SetParkingSpaceCountCar extends StatelessWidget {
  final TextEditingController totalSpaceController;
  final TextEditingController vacantSpaceController;
  final VoidCallback? onSetParkingSpaceCount;
  final bool totalSpaceBlank;
  final bool vacantSpaceBlank;
  final bool totalSpaceIsLessThanVacantSpace;
  final bool loading;

  const SetParkingSpaceCountCar({
    super.key,
    required this.totalSpaceController,
    required this.vacantSpaceController,
    this.onSetParkingSpaceCount,
    required this.totalSpaceBlank,
    required this.vacantSpaceBlank,
    required this.totalSpaceIsLessThanVacantSpace,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return TwoPaneCard(
      loading: loading,
      leftChild: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: SetParkingSpaceCountBody(
            totalSpaceController: totalSpaceController,
            vacantSpaceController: vacantSpaceController,
            onSetParkingSpaceCount: onSetParkingSpaceCount,
            totalSpaceBlank: totalSpaceBlank,
            vacantSpaceBlank: vacantSpaceBlank,
            totalSpaceIsLessThanVacantSpace:
            totalSpaceIsLessThanVacantSpace,
          ),
        ),
      ),
      rightChild: const SetParkingSpaceCountImage(),
    );
  }
}
