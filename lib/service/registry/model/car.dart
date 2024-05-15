sealed class Car {
  final String registrationId;
  final String make;
  final String model;
  final int year;
  final String color;
  final String owner;

  Car({
    required this.registrationId,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.owner,
  });
}

class SetPasswordCar extends Car {
  SetPasswordCar({
    required super.registrationId,
    required super.make,
    required super.model,
    required super.year,
    required super.color,
    required super.owner,
  });
}

class UnsetPasswordCar extends Car {
  final String temporaryPassword;

  UnsetPasswordCar({
    required super.registrationId,
    required super.make,
    required super.model,
    required super.year,
    required super.color,
    required super.owner,
    required this.temporaryPassword,
  });
}
