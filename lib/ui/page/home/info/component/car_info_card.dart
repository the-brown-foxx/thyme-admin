import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
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
    return HerbHubCard(
      largeCornerRadius: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
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
              ),
              Expanded(child: CarLogsListView(carLogs: carLogs)),
            ],
          ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}
