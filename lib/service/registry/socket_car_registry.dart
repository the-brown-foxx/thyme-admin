import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/service/registry/model/car_update.dart';
import 'package:thyme_to_park_admin/service/registry/model/new_car.dart';
import 'package:thyme_to_park_admin/service/socket/socket.dart';

class SocketCarRegistry implements CarRegistry {
  final Socket _socket;

  final _cars = BehaviorSubject<List<Car>>.seeded([]);

  @override
  Stream<List<Car>> get cars => _cars.stream;

  SocketCarRegistry({required final Socket socket}) : _socket = socket {
    _socket.messages.listen((final message) {
      if (message['action'] != 'show_cars') return;
      _cars.value = message['cars']
          .map<Car>((final carJson) => Car.fromJson(carJson))
          .toList();
    });
  }

  final _loading = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loading => _loading.stream;

  @override
  Future<Car> getCar(final String registrationId) async {
    return _cars.value.firstWhere(
      (final element) => element.registrationId == registrationId,
    );
  }

  @override
  @override
  Future<void> registerCar(final NewCar car) async {
    await _socket.send({
      'action': 'register',
      'car': {
        'registration_id': car.registrationId,
        'make': car.make,
        'model': car.model,
        'year': car.year,
        'color': car.color,
        'owner': car.owner,
      },
    });
  }

  @override
  Future<void> unregisterCar(final String registrationId) async {
    await _socket.send({
      'action': 'unregister',
      'registration_id': registrationId,
    });
  }

  @override
  Future<void> updateCar(final CarUpdate car) async {
    await _socket.send({
      'action': 'update',
      'car': {
        'registration_id': car.registrationId,
        'make': car.make,
        'model': car.model,
        'year': car.year,
        'color': car.color,
        'owner': car.owner,
      },
    });
  }
}
