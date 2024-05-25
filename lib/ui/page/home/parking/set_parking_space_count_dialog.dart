import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/dialog.dart';
import 'package:thyme_to_park_admin/ui/page/parking/component/set_parking_space_count_card.dart';

class SetParkingSpaceCountDialog extends StatelessWidget {
  final TextFieldController totalSpaceController;
  final TextFieldController vacantSpaceController;
  final VoidCallback? onSetParkingSpaceCount;
  final bool loading;

  const SetParkingSpaceCountDialog({
    super.key,
    required this.totalSpaceController,
    required this.vacantSpaceController,
    this.onSetParkingSpaceCount,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubDialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080),
        child: SetParkingSpaceCountCard(
          totalSpaceController: totalSpaceController,
          vacantSpaceController: vacantSpaceController,
          onSetParkingSpaceCount: onSetParkingSpaceCount,
          loading: loading,
        ),
      ),
    );
  }
}
