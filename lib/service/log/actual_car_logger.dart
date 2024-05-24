import 'dart:async';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/log/model/car_log.dart';

class ActualCarLogger implements CarLogger {
  final Api _api;
  final TokenStorage _tokenStorage;
  final AdminAuthenticator _adminAuthenticator;

  ActualCarLogger._({
    required final Api api,
    required final TokenStorage tokenStorage,
    required final AdminAuthenticator adminAuthenticator,
  })  : _api = api,
        _tokenStorage = tokenStorage,
        _adminAuthenticator = adminAuthenticator {
    Timer.periodic(const Duration(seconds: 10), (final _) {
      fetch();
    });
  }

  final _loading = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loading => _loading.stream;

  final _carLogs = BehaviorSubject<List<CarLog>>();

  @override
  Stream<List<CarLog>> get carLogs => _carLogs.stream;

  var fetching = false;

  void fetch() async {
    if (fetching) return;
    try {
      fetching = true;
      final response = await get(
        _api.urlOf('/logs'),
        headers: {'Authorization': 'Bearer ${await _tokenStorage.token}'},
      );
      final jsonResponse = _api.parseJsonResponse(response);
      final logsJson = jsonResponse.body['logs'] as List<dynamic>;
      _carLogs.value =
          logsJson.map((final logJson) => CarLog.fromJson(logJson)).toList();
    } on InvalidTokenException {
      await _adminAuthenticator.logout();
    } finally {
      fetching = false;
    }
  }

  @override
  Future<List<CarLog>> getCarLogsByRegistrationId(final String registrationId) async {
    var logs = <CarLog>[];
    try {
      _loading.value = true;
      final response = await get(
        _api.urlOf('/logs/$registrationId'),
        headers: {'Authorization': 'Bearer ${await _tokenStorage.token}'},
      );
      final jsonResponse = _api.parseJsonResponse(response);
      final logsJson = jsonResponse.body['logs'] as List<dynamic>;
      logs = logsJson.map((final logJson) => CarLog.fromJson(logJson)).toList();
    } on InvalidTokenException {
      await _adminAuthenticator.logout();
    } finally {
      _loading.value = false;
    }
    return logs;
  }
}
