import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/ui/component/widget_with_placeholder.dart';
import 'package:thyme_to_park_admin/ui/page/logs/components/logs_list_view.dart';
import 'package:thyme_to_park_admin/ui/page/logs/components/logs_top_bar.dart';

class LogsPage extends StatelessWidget {
  final List<CarLog> logs;
  final Function(CarLog carLog) onViewLog;
  final VoidCallback onNavigateUp;
  final bool loading;

  const LogsPage({
    super.key,
    required this.logs,
    required this.onNavigateUp,
    required this.onViewLog,
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
            child: WidgetWithPlaceholder.withEmptyIndicator(
              empty: logs.isEmpty,
              emptyMessage: 'There are no logs yet',
              child: LogsListView(
                carLogs: logs,
                onViewLog: onViewLog,
                maxContentWidth: 1080,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
