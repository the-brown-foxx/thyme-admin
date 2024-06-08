import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/parking/model/parking_space_count.dart';
import 'package:thyme_to_park_admin/service/parking/parking_space_counter.dart';
import 'package:thyme_to_park_admin/service/socket/socket.dart';

class SocketParkingSpaceCounter implements ParkingSpaceCounter {
  final Socket _socket;

  final _parkingSpaceCount = BehaviorSubject<ParkingSpaceCount?>.seeded(
    const ParkingSpaceCount(totalSpace: 0, vacantSpace: 0),
  );

  @override
  Stream<ParkingSpaceCount?> get parkingSpaceCount => _parkingSpaceCount.stream;

  SocketParkingSpaceCounter({required final Socket socket}) : _socket = socket {
    _socket.messages.listen((final message) {
      if (message['action'] != 'show_parking_space_count') return;
      final parkingSpaceCount = message['parking_space_count'];
      _parkingSpaceCount.value = parkingSpaceCount != null
          ? ParkingSpaceCount.fromJson(parkingSpaceCount)
          : null;
    });
  }

  @override
  Stream<bool> get parkingSpaceSet {
    return parkingSpaceCount
        .map((final parkingSpaceCount) => parkingSpaceCount != null);
  }

  @override
  Future<void> setParkingSpaceCount(
    final ParkingSpaceCount parkingSpaceCount,
  ) async {
    await _socket.send({
      'action': 'update',
      'parking_space_count': {
        'total_space': parkingSpaceCount.totalSpace,
        'vacant_space': parkingSpaceCount.vacantSpace,
      },
    });
  }
}
