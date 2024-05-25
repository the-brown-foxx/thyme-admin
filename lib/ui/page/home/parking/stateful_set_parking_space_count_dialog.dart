import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/parking/model/parking_space_count.dart';
import 'package:thyme_to_park_admin/service/parking/parking_space_counter.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/home/parking/set_parking_space_count_dialog.dart';

class StatefulSetParkingSpaceCountDialog extends StatefulWidget {
  final ParkingSpaceCounter _parkingSpaceCounter;

  const StatefulSetParkingSpaceCountDialog({
    super.key,
    required final ParkingSpaceCounter parkingSpaceCounter,
  }) : _parkingSpaceCounter = parkingSpaceCounter;

  @override
  State<StatefulSetParkingSpaceCountDialog> createState() =>
      _StatefulSetParkingSpaceCountDialogState();
}

class _StatefulSetParkingSpaceCountDialogState
    extends State<StatefulSetParkingSpaceCountDialog> {
  final totalSpaceController = TextFieldController(numeric: true);
  final vacantSpaceController = TextFieldController(numeric: true);
  var loading = false;
  var alreadySet = false;

  @override
  void initState() {
    // TODO: implement loading

    widget._parkingSpaceCounter.parkingSpaceCount.listen((final count) {
      if (!mounted || alreadySet) return;
      setState(() {
        totalSpaceController.text = count.totalSpace.toString();
        vacantSpaceController.text = count.vacantSpace.toString();
      });
      alreadySet = true;
    });

    super.initState();
  }

  @override
  void dispose() {
    totalSpaceController.dispose();
    vacantSpaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return SetParkingSpaceCountDialog(
      totalSpaceController: totalSpaceController,
      vacantSpaceController: vacantSpaceController,
      onSetParkingSpaceCount: onSetParkingSpaceCount,
      loading: loading,
    );
  }

  void onSetParkingSpaceCount() async {
    try {
      await widget._parkingSpaceCounter.setParkingSpaceCount(
        ParkingSpaceCount(
          totalSpace: int.tryParse(totalSpaceController.text) ?? -1,
          vacantSpace: int.tryParse(vacantSpaceController.text) ?? -1,
        ),
      );
      if (!mounted) return;
      context.pop();
    } on TotalSpaceLessThanVacantSpaceException {
      if (!mounted) return;
      setState(() {
        totalSpaceController.error =
            'Total space cannot be less than vacant space';
      });
    } on FieldCannotBeBlankException catch (exception) {
      if (!mounted) return;
      setState(() {
        if (exception.fieldName == 'totalSpace') {
          totalSpaceController.error = 'Total space is required';
        } else if (exception.fieldName == 'vacantSpace') {
          totalSpaceController.error = 'Vacant space is required';
        }
      });
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (!mounted) return;
      context.showSnackBar('Connection error');
    }
  }
}
