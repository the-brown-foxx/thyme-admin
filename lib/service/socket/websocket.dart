import 'dart:async';
import 'dart:convert';

import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/service/api/model/json.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/authenticator/token/token_storage.dart';
import 'package:thyme_to_park_admin/service/socket/socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Websocket implements Socket {
  final TokenStorage _tokenStorage;

  final AdminAuthenticator _adminAuthenticator;

  late WebSocketChannel _channel;

  final _messages = StreamController<Json>.broadcast();

  @override
  Stream<Json> get messages => _messages.stream;

  Websocket({
    required final TokenStorage tokenStorage,
    required final AdminAuthenticator adminAuthenticator,
    required final Uri uri,
  })  : _tokenStorage = tokenStorage,
        _adminAuthenticator = adminAuthenticator {
    StreamSubscription<dynamic>? subscription;
    _adminAuthenticator.loggedIn.listen((final loggedIn) {
      if (loggedIn) {
        subscription?.cancel();
        _channel = WebSocketChannel.connect(uri);
        _authenticate();
        subscription = _channel.stream.listen(
              (final message) {
            final messageJson = jsonDecode(message) as Json;
            _messages.sink.add(messageJson);
          },
          onDone: () {
            _adminAuthenticator.logout();
          },
        );
      }
    });
  }

  Future<void> _authenticate() async {
    await send({
      'action': 'authenticate',
      'token': await _tokenStorage.token,
    });
  }

  @override
  Future<Json> send(final Json message) async {
    _channel.sink.add(jsonEncode(message));
    await for (final message in messages) {
      if (message['status'] != null) {
        print(message);
        switch (message['status']) {
          case 'CAR_NOT_FOUND':
            throw CarNotFoundException(
              registrationId: message['registration_id'],
            );
          case 'REGISTRATION_ID_TAKEN':
            throw RegistrationIdTakenException(
              registrationId: message['registration_id'],
            );
          case 'FIELD_CANNOT_BE_BLANK':
            throw FieldCannotBeBlankException(
              fieldName: message['field_name'],
            );
          case 'PASSWORD_TOO_SHORT':
            throw PasswordTooShortException(
              minLength: message['min_length'],
            );
          case 'INCORRECT_PASSWORD':
            throw IncorrectPasswordException();
          case 'INVALID_TOKEN':
            throw InvalidTokenException();
          case 'UNSET_PARKING_SPACE':
            throw UnsetParkingSpaceException();
          case 'TOTAL_SPACE_LESS_THAN_VACANT_SPACE':
            throw TotalSpaceLessThanVacantSpaceException();
          case null:
            throw InvalidTokenException();
          case 'SUCCESSFUL':
            return message;
        }
      }
    }
    throw UnknownException();
  }
}
