import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/component/car_log_card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class CarLogsListView extends StatelessWidget {
  final List<CarLog> carLogs;

  const CarLogsListView({
    super.key,
    required this.carLogs,
  });

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: 32,
        top: 64,
        right: 64,
        bottom: 64,
      ),
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
            child: CarLogCard(
              carLog: carLog,
              roundedCorners: roundedCorners,
            ),
          ),
        );
      },
    );
  }
}
