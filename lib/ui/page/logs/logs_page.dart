import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/ui/page/logs/components/logs_list_view.dart';
import 'package:thyme_to_park_admin/ui/page/logs/components/logs_top_bar.dart';

class LogsPage extends StatelessWidget {
  final List<CarLog> logs;
  final VoidCallback onNavigateUp;
  final bool loading;

  const LogsPage({
    super.key,
    required this.logs,
    required this.onNavigateUp,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LogsTopBar(
            onNavigateUp: onNavigateUp,
            loading: loading,
            maxContentWidth: 1080,
          ),
          Expanded(
            child: LogsListView(
              carLogs: logs,
              maxContentWidth: 1080,
            ),
          ),
        ],
      ),
    );
  }
}
