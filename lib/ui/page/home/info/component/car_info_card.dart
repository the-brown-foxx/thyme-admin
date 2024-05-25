import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/two_pane_card.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/component/car_log_list_view.dart';

import 'car_info_body.dart';

class CarInfoCard extends StatelessWidget {
  final Car car;
  final List<CarLog> carLogs;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onCancel;
  final bool loading;

  const CarInfoCard({
    super.key,
    required this.carLogs,
    required this.car,
    required this.onEdit,
    required this.onDelete,
    required this.onCancel,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    // TODO: Make the max height of this card the height of the left pane
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 720),
      child: TwoPaneCard(
        loading: loading,
        leftChild: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 64,
              top: 64,
              right: 32,
              bottom: 64,
            ),
            child: CarInfoBody(
              car: car,
              onEdit: onEdit,
              onDelete: onDelete,
              onCancel: onCancel,
            ),
          ),
        ),
        rightChild: CarLogsListView(
          contentPadding: const EdgeInsets.only(
            left: 32,
            top: 64,
            right: 64,
            bottom: 64,
          ),
          carLogs: carLogs,
        ),
      ),
    );
  }
}
