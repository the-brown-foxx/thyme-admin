import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/logs/snapshot/components/snapshot.dart';
import 'package:thyme_to_park_admin/ui/page/logs/snapshot/components/snapshot_body.dart';

class SnapshotCard extends StatelessWidget {
  final Car car;
  final CarLog carLog;
  final String snapshotUrl;
  final VoidCallback onClose;

  const SnapshotCard({
    super.key,
    required this.car,
    required this.carLog,
    required this.snapshotUrl,
    required this.onClose,
  });

  @override
  Widget build(final BuildContext context) {
    final car = this.car;

    return TwoPaneCard(
      leftChild: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 64,
            top: 64,
            right: 32,
            bottom: 64,
          ),
          child: SnapshotBody(
            car: car,
            carLog: carLog,
            onClose: onClose,
          ),
        ),
      ),
      rightChild: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          top: 64,
          right: 64,
          bottom: 64,
        ),
        child: Snapshot(snapshotUrl: snapshotUrl),
      ),
    );
  }
}
