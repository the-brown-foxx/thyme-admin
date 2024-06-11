import 'package:thyme_to_park_admin/service/registry/model/car.dart';

import 'model/car_update.dart';
import 'model/new_car.dart';

abstract interface class CarRegistry {
  Stream<bool> get loading;

  Stream<List<Car>> get cars;

  Stream<Car> getLiveCar(final String registrationId);

  @Deprecated('Use `getLiveCar` instead')
  Future<Car> getCar(final String registrationId);

  Future<void> registerCar(final NewCar car);

  Future<void> updateCar(final CarUpdate car);

  Future<void> unregisterCar(final String registrationId);
}