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
        _tokenStorage = tokenStorage;

  final _loggedIn = BehaviorSubject.seeded(false);

  @override
  Stream<bool> get loggedIn => _loggedIn.stream;

  @override
  Future<bool> get passwordSet async {
    final response = await get(_api.urlOf('/admin/password-set'));
    final jsonResponse = _api.parseJsonResponse(response);
    return jsonResponse.body['password_set'];
  }

  @override
  Future<void> login(final String password) async {
    final response = await post(
      _api.urlOf('/admin/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'password': password}),
    );
    final jsonResponse = _api.parseJsonResponse(response);
    final Token token = jsonResponse.body['token'];
    _tokenStorage.setToken(token);
    _loggedIn.value = true;
  }

  @override
  Future<void> changePassword({
    final String? oldPassword,
    required final String newPassword,
  }) async {
    final response = await post(
      _api.urlOf('/admin/change-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'old_password': oldPassword,
        'new_password': newPassword,
      }),
    );
    _api.parseJsonResponse(response);
  }

  @override
  void logout() {
    _tokenStorage.setToken(null);
    _loggedIn.value = false;
  }
}
