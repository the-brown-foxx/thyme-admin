import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/ui/page/logs/logs_page.dart';

class StatefulLogsPage extends StatefulWidget {
  final CarLogger _carLogger;

  const StatefulLogsPage({
    super.key,
    required final CarLogger carLogger,
  }) : _carLogger = carLogger;

  @override
  State<StatefulLogsPage> createState() => _StatefulLogsPageState();
}

class _StatefulLogsPageState extends State<StatefulLogsPage> {
  List<CarLog> logs = [];

  @override
  void initState() {
    widget._carLogger.carLogs.listen((final logs) {
      if (!mounted) return;
      setState(() => this.logs = logs);
    });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return LogsPage(
      logs: logs,
      onNavigateUp: onNavigateUp,
      loading: false,
    );
  }

  void onNavigateUp() {
    context.pop();
  }
}
