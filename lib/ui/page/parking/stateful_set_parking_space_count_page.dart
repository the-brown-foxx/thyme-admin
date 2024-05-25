import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/parking/model/parking_space_count.dart';
import 'package:thyme_to_park_admin/service/parking/parking_space_counter.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';
import 'package:thyme_to_park_admin/ui/page/parking/set_parking_space_count_page.dart';

class StatefulSetParkingSpaceCountPage extends StatefulWidget {
  final ParkingSpaceCounter _parkingSpaceCounter;

  const StatefulSetParkingSpaceCountPage({
    super.key,
    required final ParkingSpaceCounter parkingSpaceCounter,
  }) : _parkingSpaceCounter = parkingSpaceCounter;

  @override
  State<StatefulSetParkingSpaceCountPage> createState() =>
      _StatefulSetParkingSpaceCountPageState();
}

class _StatefulSetParkingSpaceCountPageState
    extends State<StatefulSetParkingSpaceCountPage> {
  final totalSpaceController = TextFieldController(numeric: true);
  final vacantSpaceController = TextFieldController(numeric: true);
  var loading = false;

  @override
  void initState() {
    // TODO: implement loading
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
    return SetParkingSpaceCountPage(
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
            'Total space must be greater than vacant space';
      });
    } on FieldCannotBeBlankException catch (exception) {
      if (!mounted) return;
      if (exception.fieldName == 'total_space') {
        totalSpaceController.error = 'Total space is required';
      } else if (exception.fieldName == 'vacant_space') {
        vacantSpaceController.error = 'Vacant space is required';
      }
    } on ApiException catch (exception) {
      if (!mounted) return;
      context.showSnackBar(exception.message);
    } on ClientException {
      if (!mounted) return;
      context.showSnackBar('Connection error');
    }
  }
}
