import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/ui/page/logs/components/log_card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class LogsListView extends StatelessWidget {
  final List<CarLog> carLogs;
  final Function(CarLog carLog) onViewLog;
  final double maxContentWidth;

  const LogsListView({
    super.key,
    required this.carLogs,
    required this.onViewLog,
    this.maxContentWidth = double.infinity,
  });

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: carLogs.length,
      itemBuilder: (final _, final index) {
        final lastIndex = carLogs.length - 1;
        final roundedCorners = lastIndex == 0
            ? Corner.all
            : index == 0
            ? Edge.top
            : index == lastIndex
            ? Edge.bottom
            : <Corner>{};

        final carLog = carLogs[index];

        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 0 : 4,
              bottom: index == lastIndex ? 0 : 4,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: LogCard(
                carLog: carLog,
                onView: () => onViewLog(carLog),
                roundedCorners: roundedCorners,
              ),
            ),
          ),
        );
      },
    );
  }
}
