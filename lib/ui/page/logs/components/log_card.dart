import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/license_plate.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class LogCard extends StatelessWidget {
  final CarLog carLog;
  final Set<Corner> roundedCorners;

  const LogCard({
    super.key,
    required this.carLog,
    this.roundedCorners = Corner.all,
  });

  @override
  Widget build(final BuildContext context) {
    final formattedDate = DateFormat.yMMMMEEEEd().format(carLog.dateTime);
    final formattedTime = DateFormat.jms().format(carLog.dateTime);

    return HerbHubCard(
      roundedCorners: roundedCorners,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(carLog.entering ? Icons.login : Icons.logout),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formattedDate),
                    Text(formattedTime),
                  ],
                ),
              ),
              if (carLog.sus) const SizedBox(width: 16),
              if (carLog.sus) const Icon(Icons.warning),
              const SizedBox(width: 16),
              LicensePlate(registrationId: carLog.carRegistrationId),
            ],
          ),
        ),
      ),
    );
  }
}
