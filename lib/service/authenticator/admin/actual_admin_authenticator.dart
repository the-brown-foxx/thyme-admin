import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';

import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/model/token.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';

class ActualAdminAuthenticator implements AdminAuthenticator {
  final Api _api;
  final TokenStorage _tokenStorage;

  ActualAdminAuthenticator({
    required final Api api,
    required final TokenStorage tokenStorage,
  })  : _api = api,
        _tokenStorage = tokenStorage {
    checkIfLoggedIn();
  }

  void checkIfLoggedIn() async {
    if (await _tokenStorage.token != null) {
      _loggedIn.value = true;
    }
  }

  final _loading = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loading => _loading.stream;

  final _loggedIn = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loggedIn => _loggedIn.stream;

  Future<T> _run<T>(
    final Future<T> Function() function, {
    required final T defaultValue,
  }) async {
    if (_loading.value) return defaultValue;
    try {
      _loading.value = true;
      return await function();
    } finally {
      _loading.value = false;
    }
  }

  @override
  Future<bool> get passwordSet async {
    return await _run(
      () async {
        final response = await get(_api.urlOf('/admin/password-set'));
        final jsonResponse = _api.parseJsonResponse(response);
        return jsonResponse.body['password_set'];
      },
      defaultValue: false,
    );
  }

  @override
  Future<void> login(final String password) async {
    await _run(
      () async {
        final response = await post(
          _api.urlOf('/admin/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'password': password}),
        );
        final jsonResponse = _api.parseJsonResponse(response);
        final Token token = jsonResponse.body['token'];
        await _tokenStorage.setToken(token);
        _loggedIn.value = true;
      },
      defaultValue: null,
    );
  }

  @override
  Future<void> changePassword({
    final String? oldPassword,
    required final String newPassword,
  }) async {
    await _run(
      () async {
        final response = await post(
          _api.urlOf('/admin/change-password'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'old_password': oldPassword,
            'new_password': newPassword,
          }),
        );
        _api.parseJsonResponse(response);
        await logout();
      },
      defaultValue: null,
    );
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.setToken(null);
    _loggedIn.value = false;
  }
}
