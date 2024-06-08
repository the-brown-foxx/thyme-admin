import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/socket/socket.dart';

import 'model/car_log.dart';

class SocketCarLogger implements CarLogger {
  final Socket _socket;

  final _carLogs = BehaviorSubject<List<CarLog>>.seeded([]);

  @override
  Stream<List<CarLog>> get carLogs => _carLogs.stream;

  SocketCarLogger({
    required final Socket socket,
  }) : _socket = socket {
    _socket.messages.listen((final message) {
      if (message['action'] != 'show_logs') return;
      _carLogs.value = message['logs']
          .map<CarLog>((final logJson) => CarLog.fromJson(logJson))
          .toList();
    });
  }

  final _loading = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loading => _loading.stream;

  @override
  Stream<List<CarLog>> getCarLogsByRegistrationId(
    final String registrationId,
  ) {
    return _carLogs.map(
      (final logs) => logs
          .where((final log) => log.carRegistrationId == registrationId)
          .toList(),
    );
  }
}
