import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/service/registry/model/car_update.dart';
import 'package:thyme_to_park_admin/service/registry/model/new_car.dart';

import 'car_registry.dart';

class ActualCarRegistry implements CarRegistry {
  final Api _api;
  final TokenStorage _tokenStorage;
  final AdminAuthenticator _adminAuthenticator;

  ActualCarRegistry._({
    required final Api api,
    required final TokenStorage tokenStorage,
    required final AdminAuthenticator adminAuthenticator,
  })  : _api = api,
        _tokenStorage = tokenStorage,
        _adminAuthenticator = adminAuthenticator;

  factory ActualCarRegistry({
    required final Api api,
    required final TokenStorage tokenStorage,
    required final AdminAuthenticator adminAuthenticator,
  }) {
    final registry = ActualCarRegistry._(
      api: api,
      tokenStorage: tokenStorage,
      adminAuthenticator: adminAuthenticator,
    );
    registry._runMutation(() async {});
    return registry;
  }

  final _loading = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loading => _loading.stream;

  final _cars = BehaviorSubject.seeded(<Car>[]);

  @override
  Stream<List<Car>> get cars => _cars.stream;

  Future<void> _runMutation(final Future<void> Function() mutation) async {
    if (_loading.value) return;
    try {
      _loading.value = true;
      await mutation();
      await _loadCars();
    } on InvalidTokenException {
      await _adminAuthenticator.logout();
    } finally {
      _loading.value = false;
    }
  }

  Future<void> _loadCars() async {
    final response = await get(
      _api.urlOf('/cars'),
      headers: {'Authorization': 'Bearer ${await _tokenStorage.token}'},
    );
    final jsonResponse = _api.parseJsonResponse(response);
    final carsJson = jsonResponse.body['cars'] as List<dynamic>;
    _cars.value =
        carsJson.map((final carJson) => Car.fromJson(carJson)).toList();
  }

  @override
  Future<Car> getCar(final String registrationId) async {
    try {
      final response = await get(
        _api.urlOf('/cars/$registrationId'),
        headers: {'Authorization': 'Bearer ${await _tokenStorage.token}'},
      );
      final jsonResponse = _api.parseJsonResponse(response);
      return Car.fromJson(jsonResponse.body['car']);
    } on InvalidTokenException {
      _adminAuthenticator.logout();
      rethrow;
    }
  }

  @override
  Future<void> registerCar(final NewCar car) async {
    await _runMutation(() async {
      final response = await post(
        _api.urlOf('/cars'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _tokenStorage.token}',
        },
        body: jsonEncode({
          'registration_id': car.registrationId,
          'make': car.make,
          'model': car.model,
          'year': car.year,
          'color': car.color,
          'owner': car.owner,
        }),
      );
      _api.parseJsonResponse(response);
    });
  }

  @override
  Future<void> updateCar(final CarUpdate car) async {
    await _runMutation(() async {
      final response = await patch(
        _api.urlOf('/cars'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await _tokenStorage.token}',
        },
        body: jsonEncode({
          'registration_id': car.registrationId,
          'make': car.make,
          'model': car.model,
          'year': car.year,
          'color': car.color,
          'owner': car.owner,
        }),
      );
      _api.parseJsonResponse(response);
    });
  }

  @override
  Future<void> unregisterCar(final String registrationId) async {
    await _runMutation(() async {
      final response = await delete(
        _api.urlOf('/cars/$registrationId'),
        headers: {'Authorization': 'Bearer ${await _tokenStorage.token}'},
      );
      _api.parseJsonResponse(response);
    });
  }
}
