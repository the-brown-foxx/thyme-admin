import 'package:thyme_to_park_admin/service/authenticator/token/model/token.dart';

abstract interface class TokenStorage {
  Future<Token?> get token;

  void setToken(final String? token);
}
