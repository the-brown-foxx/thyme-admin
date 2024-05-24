import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';
import 'package:thyme_to_park_admin/service/parking/model/parking_space_count.dart';
import 'package:thyme_to_park_admin/service/parking/parking_space_counter.dart';

class ActualParkingSpaceCounter implements ParkingSpaceCounter {
  final Api _api;
  final TokenStorage _tokenStorage;
  final AdminAuthenticator _adminAuthenticator;

  ActualParkingSpaceCounter({
    required final Api api,
    required final TokenStorage tokenStorage,
    required final AdminAuthenticator adminAuthenticator,
  })  : _api = api,
        _tokenStorage = tokenStorage,
        _adminAuthenticator = adminAuthenticator {
    fetch();
    Timer.periodic(const Duration(seconds: 10), (final _) {
      fetch();
    });
  }

  final _parkingSpaceCount = BehaviorSubject<ParkingSpaceCount>();

  @override
  Stream<ParkingSpaceCount> get parkingSpaceCount => _parkingSpaceCount.stream;

  var fetching = false;

  void fetch() async {
    if (fetching) return;
    try {
      fetching = true;
      final response = await get(
        _api.urlOf('/parking'),
        headers: {'Authorization': 'Bearer ${await _tokenStorage.token}'},
      );
      final jsonResponse = _api.parseJsonResponse(response);
      _parkingSpaceCount.value = ParkingSpaceCount.fromJson(jsonResponse.body);
    } on InvalidTokenException {
      await _adminAuthenticator.logout();
    } finally {
      fetching = false;
    }
  }

  @override
  Future<void> setParkingSpaceCount(
    final ParkingSpaceCount parkingSpaceCount,
  ) async {
    final response = await post(
      _api.urlOf('/parking'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await _tokenStorage.token}',
      },
      body: jsonEncode({
        'total_space': parkingSpaceCount.totalSpace,
        'vacant_space': parkingSpaceCount.vacantSpace,
      }),
    );
    _api.parseJsonResponse(response);
    fetch();
  }
}
