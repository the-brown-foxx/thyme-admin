import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/model/token.dart';
import 'package:thyme_to_park_admin/service/token/token_storage.dart';

class ActualTokenStorage implements TokenStorage {
  static const _tokenKey = 'token';

  final _storage = const FlutterSecureStorage();

  @override
  Future<Token?> get token async => await _storage.read(key: _tokenKey);

  @override
  void setToken(final String token) {
    _storage.write(key: _tokenKey, value: token);
  }
}