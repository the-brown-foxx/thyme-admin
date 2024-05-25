import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/api.dart';
import 'package:thyme_to_park_admin/service/api/model/json_response.dart';

import 'model/exception.dart';

class ActualApi implements Api {
  final _baseUrl = const String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://127.0.0.1:8069',
  );

  @override
  Uri urlOf(final String endpoint) {
    return Uri.parse('$_baseUrl$endpoint');
  }

  @override
  JsonResponse parseJsonResponse(final Response response) {
    final jsonResponse = JsonResponse(response);

    switch (jsonResponse.body['status']) {
      case 'CAR_NOT_FOUND':
        throw CarNotFoundException(
          registrationId: jsonResponse.body['registration_id'],
        );
      case 'REGISTRATION_ID_TAKEN':
        throw RegistrationIdTakenException(
          registrationId: jsonResponse.body['registration_id'],
        );
      case 'FIELD_CANNOT_BE_BLANK':
        throw FieldCannotBeBlankException(
          fieldName: jsonResponse.body['field_name'],
        );
      case 'PASSWORD_TOO_SHORT':
        throw PasswordTooShortException(
          minLength: jsonResponse.body['min_length'],
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
        return jsonResponse;
      default:
        throw UnknownException();
    }
  }
}
