abstract class ApiException {
  String get message;
}

class CarNotFoundException extends ApiException {
  final String registrationId;

  CarNotFoundException({required this.registrationId});

  @override
  String get message =>
      'Car with registration ID $registrationId is not in the registry';
}

class RegistrationIdTakenException extends ApiException {
  final String registrationId;

  RegistrationIdTakenException({required this.registrationId});

  @override
  String get message =>
      'Registration ID $registrationId is already taken';
}

class FieldCannotBeBlankException extends ApiException {
  final String fieldName;

  FieldCannotBeBlankException({required this.fieldName});

  @override
  String get message =>
      'Field $fieldName cannot be blank';
}

class PasswordTooShortException extends ApiException {
  final int minLength;

  PasswordTooShortException({required this.minLength});

  @override
  String get message =>
      'Password must be at least $minLength characters long';
}

class IncorrectPasswordException extends ApiException {
  @override
  String get message =>
      'Incorrect password';
}

class InvalidTokenException extends ApiException {
  @override
  String get message =>
      'Invalid token';
}

class UnknownException extends ApiException {
  @override
  String get message =>
      'An unknown error occurred';
}