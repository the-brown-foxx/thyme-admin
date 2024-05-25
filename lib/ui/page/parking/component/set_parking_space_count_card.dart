import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/parking/component/set_parking_space_count_body.dart';
import 'package:thyme_to_park_admin/ui/page/parking/component/set_parking_space_count_image.dart';

class SetParkingSpaceCountCard extends StatelessWidget {
  final TextFieldController totalSpaceController;
  final TextFieldController vacantSpaceController;
  final VoidCallback? onSetParkingSpaceCount;
  final bool loading;

  const SetParkingSpaceCountCard({
    super.key,
    required this.totalSpaceController,
    required this.vacantSpaceController,
    this.onSetParkingSpaceCount,
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
          ),
        ),
      ),
      rightChild: const SetParkingSpaceCountImage(),
    );
  }
}
