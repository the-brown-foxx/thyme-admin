import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';

import 'package:thyme_to_park_admin/service/registry/model/car_update.dart';

import 'package:thyme_to_park_admin/service/registry/model/new_car.dart';

import '../api/api.dart';
import '../authenticator/token/token_storage.dart';
import 'car_registry.dart';

class ActualCarRegistry implements CarRegistry {
  final Api _api;
  final TokenStorage _tokenStorage;

  ActualCarRegistry({
    required final Api api,
    required final TokenStorage tokenStorage,
  })  : _api = api,
        _tokenStorage = tokenStorage;

  final _loading = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loading => _loading.stream;

  final _cars = BehaviorSubject.seeded(<Car>[]);

  @override
  Stream<List<Car>> get cars => _cars.stream;

  @override
  Future<Car> getCar(final String registrationId) async {
    final response = await get(
      _api.urlOf('/cars/$registrationId'),
      headers: {'Authorization': 'Bearer ${_tokenStorage.token}'},
    );
    final jsonResponse = _api.parseJsonResponse(response);
    return Car.fromJson(jsonResponse.body['car']);
  }

  @override
  Future<void> registerCar(final NewCar car) async {
    final response = await post(
      _api.urlOf('/cars'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_tokenStorage.token}',
      },
      body: {
        'registration_id': car.registrationId,
        'make': car.make,
        'model': car.model,
        'year': car.year,
        'color': car.color,
      },
    );
    _api.parseJsonResponse(response);
  }

  @override
  Future<void> updateCar(final CarUpdate car) async {
    final response = await patch(
      _api.urlOf('/cars'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_tokenStorage.token}',
      },
      body: {
        'registration_id': car.registrationId,
        'make': car.make,
        'model': car.model,
        'year': car.year,
        'color': car.color,
      },
    );
    _api.parseJsonResponse(response);
  }

  @override
  Future<void> unregisterCar(final String registrationId) async {
    final response = await delete(
      _api.urlOf('/cars/$registrationId'),
      headers: {'Authorization': 'Bearer ${_tokenStorage.token}'},
    );
    _api.parseJsonResponse(response);
  }
}
