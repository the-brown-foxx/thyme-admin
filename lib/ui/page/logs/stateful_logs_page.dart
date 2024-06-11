import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/ui/page/logs/logs_page.dart';
import 'package:thyme_to_park_admin/ui/page/logs/snapshot/stateful_snapshot_dialog.dart';

class StatefulLogsPage extends StatefulWidget {
  final CarRegistry _carRegistry;
  final CarLogger _carLogger;

  const StatefulLogsPage({
    super.key,
    required final CarRegistry carRegistry,
    required final CarLogger carLogger,
  })  : _carRegistry = carRegistry,
        _carLogger = carLogger;

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
      onViewLog: onViewLog,
      onNavigateUp: onNavigateUp,
      loading: false,
    );
  }

  void onViewLog(final CarLog carLog) {
    showDialog(
      context: context,
      builder: (final _) => StatefulSnapshotDialog(
        carLogger: widget._carLogger,
        carRegistry: widget._carRegistry,
        carLog: carLog,
      ),
    );
  }

  void onNavigateUp() {
    context.pop();
  }
}
