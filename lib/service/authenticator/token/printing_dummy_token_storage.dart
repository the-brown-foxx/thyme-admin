import 'package:flutter/foundation.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/model/token.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';

class PrintingDummyTokenStorage implements TokenStorage {
  String? _token = '';

  @override
  Future<Token?> get token {
    if (kDebugMode) {
      print('Token: $_token');
    }
    return Future.value(_token);
  }

  @override
  void setToken(final String? token) {
    if (kDebugMode) {
      print('Setting token: $token');
    }
    _token = token;
  }

}