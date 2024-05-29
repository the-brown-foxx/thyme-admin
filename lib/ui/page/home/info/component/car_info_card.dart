import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/component/optional_intrinsic_height.dart';
import 'package:thyme_to_park_admin/ui/component/widget_with_placeholder.dart';
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
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: OptionalIntrinsicHeight(
              enabled: carLogs.isEmpty,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  // if (showDivider)
                  //   VerticalDivider(
                  //     width: 2,
                  //     thickness: 2,
                  //     color: context.theme.colorScheme.onSurface,
                  //   ),
                  Expanded(
                    child: WidgetWithPlaceholder.withEmptyIndicator(
                      empty: carLogs.isEmpty,
                      emptyMessage: 'There are no logs for this car',
                      child: CarLogsListView(
                        contentPadding: const EdgeInsets.only(
                          left: 32,
                          top: 64,
                          right: 64,
                          bottom: 64,
                        ),
                        carLogs: carLogs,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // MatchLeftPaneHeightLayout(
          //   leftChild: leftChild,
          //   rightChild: rightChild,
          // ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}
