import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/dialog.dart';
import 'package:thyme_to_park_admin/ui/component/loadable_builder.dart';
import 'package:thyme_to_park_admin/ui/page/logs/snapshot/components/snapshot_card.dart';
import 'package:thyme_to_park_admin/ui/util/loadable.dart';

class SnapshotDialog extends StatelessWidget {
  final Loadable<Car> car;
  final CarLog carLog;
  final String snapshotUrl;
  final VoidCallback onClose;

  const SnapshotDialog({
    super.key,
    required this.car,
    required this.carLog,
    required this.snapshotUrl,
    required this.onClose,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubDialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1080, minHeight: 512),
        child: LoadableBuilder(
          loadable: car,
          builder: (final _, final car) => SnapshotCard(
            car: car,
            carLog: carLog,
            snapshotUrl: snapshotUrl,
            onClose: onClose,
          ),
        ),
      ),
    );
  }
}
