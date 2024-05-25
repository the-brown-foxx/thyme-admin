import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/parking/model/parking_space_count.dart';
import 'package:thyme_to_park_admin/service/parking/parking_space_counter.dart';
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
  final totalSpaceController = TextEditingController();
  final vacantSpaceController = TextEditingController();
  var oldTotalSpaceController = '';
  var oldVacantSpaceController = '';
  var totalSpaceBlank = false;
  var vacantSpaceBlank = false;
  var totalSpaceIsLessThanVacantSpace = false;
  var loading = false;

  @override
  void initState() {
    // TODO: implement loading
    totalSpaceController.addListener(() {
      if (oldTotalSpaceController != totalSpaceController.text && mounted) {
        setState(() {
          totalSpaceBlank = false;
          totalSpaceIsLessThanVacantSpace = false;
        });
      }
      if (int.tryParse(totalSpaceController.text) == null &&
          totalSpaceController.text != '' && mounted) {
        totalSpaceController.text = oldTotalSpaceController;
      }
      oldTotalSpaceController = totalSpaceController.text;
    });

    vacantSpaceController.addListener(() {
      if (oldVacantSpaceController != vacantSpaceController.text && mounted) {
        setState(() {
          vacantSpaceBlank = false;
        });
      }
      if (int.tryParse(vacantSpaceController.text) == null &&
          vacantSpaceController.text != '' && mounted) {
        vacantSpaceController.text = oldVacantSpaceController;
      }
      oldVacantSpaceController = vacantSpaceController.text;
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
    return SetParkingSpaceCountPage(
      totalSpaceController: totalSpaceController,
      vacantSpaceController: vacantSpaceController,
      onSetParkingSpaceCount: onSetParkingSpaceCount,
      totalSpaceBlank: totalSpaceBlank,
      vacantSpaceBlank: vacantSpaceBlank,
      totalSpaceIsLessThanVacantSpace: totalSpaceIsLessThanVacantSpace,
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
        totalSpaceIsLessThanVacantSpace = true;
      });
    } on FieldCannotBeBlankException catch (exception) {
      if (!mounted) return;
      setState(() {
        if (exception.fieldName == 'totalSpace') {
          totalSpaceBlank = true;
        } else if (exception.fieldName == 'vacantSpace') {
          vacantSpaceBlank = true;
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
