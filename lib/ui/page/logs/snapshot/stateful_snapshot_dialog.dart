import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/logs/snapshot/snapshot_dialog.dart';
import 'package:thyme_to_park_admin/ui/util/handle_common_exceptions.dart';
import 'package:thyme_to_park_admin/ui/util/loadable.dart';

class StatefulSnapshotDialog extends StatefulWidget {
  final CarRegistry _carRegistry;
  final CarLogger _carLogger;
  final CarLog carLog;

  const StatefulSnapshotDialog({
    super.key,
    required final CarRegistry carRegistry,
    required final CarLogger carLogger,
    required this.carLog,
  })  : _carRegistry = carRegistry,
        _carLogger = carLogger;

  @override
  State<StatefulSnapshotDialog> createState() => _StatefulSnapshotDialogState();
}

class _StatefulSnapshotDialogState extends State<StatefulSnapshotDialog> {
  Loadable<Car> car = const Loading();

  @override
  void initState() {
    widget._carRegistry.getLiveCar(widget.carLog.carRegistrationId).listen(
      (final car) {
        setState(() => this.car = Loaded(car));
      },
      onError: (final exception) {
        if (exception is CarNotFoundException) {
          context.showSnackBar(exception.message);
        } else {
          context.handleCommonExceptions(exception);
        }
      },
    );
    super.initState();
  }



  @override
  Widget build(final BuildContext context) {
    return SnapshotDialog(
      car: car,
      snapshotUrl: widget._carLogger.getImageUrl(widget.carLog.image),
      carLog: widget.carLog,
      onClose: onClose,
    );
  }

  void onClose() {
    context.pop();
  }
}
