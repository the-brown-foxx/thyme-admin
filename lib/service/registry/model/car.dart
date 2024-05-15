sealed class Car {
  final String registrationId;
  final String make;
  final String model;
  final int year;
  final String color;
  final String owner;

  const Car({
    required this.registrationId,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.owner,
  });

  factory Car.fromJson(final Map<String, dynamic> json) {
    final registrationId = json['registrationId'] as String;
    final make = json['make'] as String;
    final model = json['model'] as String;
    final year = json['year'] as int;
    final color = json['color'] as String;
    final owner = json['owner'] as String;
    final temporaryPassword = json['temporaryPassword'] as String?;

    return temporaryPassword == null
        ? SetPasswordCar(
            registrationId: registrationId,
            make: make,
            model: model,
            year: year,
            color: color,
            owner: owner,
          )
        : UnsetPasswordCar(
            registrationId: registrationId,
            make: make,
            model: model,
            year: year,
            color: color,
            owner: owner,
            temporaryPassword: temporaryPassword,
          );
  }
}

class SetPasswordCar extends Car {
  const SetPasswordCar({
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

  const UnsetPasswordCar({
    required super.registrationId,
    required super.make,
    required super.model,
    required super.year,
    required super.color,
    required super.owner,
    required this.temporaryPassword,
  });
}
