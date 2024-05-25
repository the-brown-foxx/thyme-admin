import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/page/parking/component/set_parking_space_count_card.dart';

class SetParkingSpaceCountPage extends StatelessWidget {
  final TextEditingController totalSpaceController;
  final TextEditingController vacantSpaceController;
  final VoidCallback? onSetParkingSpaceCount;
  final bool totalSpaceBlank;
  final bool vacantSpaceBlank;
  final bool totalSpaceIsLessThanVacantSpace;
  final bool loading;

  const SetParkingSpaceCountPage({
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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: SetParkingSpaceCountCard(
                    totalSpaceController: totalSpaceController,
                    vacantSpaceController: vacantSpaceController,
                    onSetParkingSpaceCount: onSetParkingSpaceCount,
                    totalSpaceBlank: totalSpaceBlank,
                    vacantSpaceBlank: vacantSpaceBlank,
                    totalSpaceIsLessThanVacantSpace:
                        totalSpaceIsLessThanVacantSpace,
                    loading: loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
